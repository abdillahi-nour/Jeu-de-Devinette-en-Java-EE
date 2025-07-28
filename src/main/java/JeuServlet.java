import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/JeuServlet")
public class JeuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String[]
            words = {"banane", "mangue", "pomme", "cerise", "raisin","kiwi","orange","ananas","fraise","poire"};
    private static final int maxAttempts = 4;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true); // Crée une nouvelle session si elle n'existe pas
        if (session.isNew()) {
            session.invalidate(); // Détruire la session existante
            session = request.getSession(true); // Créer une nouvelle session
            resetGame(session); // Appeler restartGame() pour la nouvelle session
        }

        // Rediriger vers la page d'accueil
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true); // Crée une nouvelle session si elle n'existe pas

        // Vérifier si c'est une nouvelle session
        if (session.isNew()) {
            resetGame(session);
        }

        // Gérer la demande de réinitialisation
        String resetParam = request.getParameter("reset");
        if (resetParam != null && resetParam.equals("true")) {
            resetGame(session);
            response.sendRedirect("index.jsp"); // Rediriger vers le début d'une nouvelle partie
            return;
        }

        // Récupérer l'état du jeu depuis la session
        String wordToGuess = (String) session.getAttribute("wordToGuess");
        String displayedWord = (String) session.getAttribute("displayedWord");
        Integer attemptsLeftObj = (Integer) session.getAttribute("attemptsLeft");

        // Gérer le cas où attemptsLeft n'est pas trouvé dans la session
        int attemptsLeft = (attemptsLeftObj != null) ? attemptsLeftObj.intValue() : maxAttempts;

        String guess = request.getParameter("guess");

        if (guess != null && !guess.isEmpty()) {
            guess = guess.toLowerCase(); // Convertir l'entrée en minuscules

            boolean letterFound = false;
            StringBuilder newDisplayedWord = new StringBuilder();
            for (int i = 0; i < wordToGuess.length(); i++) {
                if (wordToGuess.charAt(i) == guess.charAt(0)) {
                    newDisplayedWord.append(guess);
                    letterFound = true;
                } else {
                    newDisplayedWord.append(displayedWord.charAt(i));
                }
            }

            if (!letterFound) {
                attemptsLeft--;
                session.setAttribute("attemptsLeft", attemptsLeft);
                request.setAttribute("message", " Lettre incorrecte!  Essayez à nouveau !");
            } else {
                request.setAttribute("message", "Bien joué ! Continuez !");
            }

            session.setAttribute("displayedWord", newDisplayedWord.toString());

            if (newDisplayedWord.toString().equals(wordToGuess)) {
                request.setAttribute("message", "Bravo, vous avez deviné le mot !");
            } else if (attemptsLeft == 0) {
                request.setAttribute("message", "Dommage ! Tentatives épuisé toutes les tentatives ! Le mot était : " + wordToGuess);
            }
        }

        request.setAttribute("wordToGuess", wordToGuess);
        request.setAttribute("displayedWord", session.getAttribute("displayedWord"));
        request.setAttribute("attemptsLeft", attemptsLeft);

        // Rediriger vers la page d'accueil
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void resetGame(HttpSession session) {
        // Générer un nouveau mot aléatoire et initialiser les variables du jeu
        String wordToGuess = words[new Random().nextInt(words.length)];
        session.setAttribute("wordToGuess", wordToGuess);
        session.setAttribute("displayedWord", "_".repeat(wordToGuess.length()));
        session.setAttribute("attemptsLeft", maxAttempts); // Réinitialiser le nombre de tentatives à maxAttempts
    }
}
