<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>App-Jeu-Hasard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400&display=swap"
	rel="stylesheet">
<link href="my_styles.css" type="text/css" rel="stylesheet">



</head>
<body>
	<div
		class="container d-flex justify-content-center align-items-center vh-100">
		<div class="card p-4 shadow-lg" style="max-width: 500px; width: 90%;">
			<%
			String displayedWord = (String) request.getAttribute("displayedWord");
			String wordToGuess = (String) request.getAttribute("wordToGuess");
			String defaultWord = "---";
			if (displayedWord == null) {
				if (wordToGuess != null) {
					defaultWord = "-".repeat(wordToGuess.length());
				}
			}
			%>
			<h1 class="text-center mb-4">Jeu de Hasard</h1>
			<p class="text-center">
				Tentatives restantes : <span id="attemptsLeft">${not empty attemptsLeft ? attemptsLeft : 4}</span>
			</p>
			<p id="message">${not empty message ? message : ''}</p>
			<p class="text-center" id="word">${not empty displayedWord ? displayedWord : defaultWord}</p>
			<form action="JeuServlet" method="post" class="mt-4" id="guessForm">
				<div class="input-group">
					<input type="text" class="form-control" name="guess"
						id="guessInput" placeholder="Entrez une lettre" maxlength="1"
						required>

					<button type="submit" class="btn btn-primary" id="submitBtn">
						Deviner</button>
					<button type="button" class="btn btn-secondary mr-2"
						onclick="restartGame();">
						<i class="fas fa-redo"></i> Recommencer
					</button>
					<button type="button" class="btn btn-danger"
						onclick="closeWindow();">
						<i class="fas fa-times"></i> Quitter
					</button>
				</div>

			</form>


		</div>
	</div>
	<script>
        function restartGame() {
            fetch('JeuServlet?reset=true', { method: 'POST' })
                .then(response => {
                    if (response.redirected) {
                        document.getElementById('guessInput').disabled = false; // Activer la zone de texte
                        document.getElementById('submitBtn').style.display = 'block'; // Afficher le bouton Soumettre
                        document.getElementById('submitBtn').disabled = false; // Activer le bouton Soumettre
                        window.location.href = response.url; // Rediriger pour commencer une nouvelle partie
                    }
                })
                .catch(error => {
                    console.error('Erreur lors de la réinitialisation du jeu:', error);
                });
        }

        function closeWindow() {
            if (confirm("Voulez-vous vraiment quitter le jeu?")) {
                window.close();
            }
        }

        // Fonction pour masquer la zone de texte et le bouton Soumettre lorsque nécessaire
        function hideInputAndButton(success, attemptsLeft) {
            if (success) {
                document.getElementById('guessInput').disabled = true; // Désactiver la zone de texte
                document.getElementById('submitBtn').style.display = 'none'; // Masquer le bouton Soumettre
            } else if (attemptsLeft === 0) {
                document.getElementById('guessInput').disabled = true; // Désactiver la zone de texte
                document.getElementById('submitBtn').style.display = 'none'; // Masquer le bouton Soumettre
                document.getElementById('message').textContent = "tentatives épuisé! Le mot était : ${not empty wordToGuess ? wordToGuess : ''}"; 
            }
        }

        // Récupérer les informations de la requête pour masquer la zone de texte et le bouton Soumettre si nécessaire
        let message = "${not empty message ? message : ''}";
        let attemptsLeft = "${not empty attemptsLeft ? attemptsLeft : 4}";
        let success = message.includes("Bravo") || message.includes("épuisé toutes les tentatives");
        hideInputAndButton(success, attemptsLeft);
    </script>
</body>
</html>
