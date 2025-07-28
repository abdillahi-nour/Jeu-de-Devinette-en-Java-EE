# 🎯 Jeu de Devinette en Java EE

Une application web simple qui permet à l'utilisateur de deviner un mot caché avec un nombre limité d'essais. Ce projet illustre l'utilisation des technologies Java EE côté serveur, avec une interface dynamique grâce à JSP, JavaScript et Bootstrap.

## 📌 Objectifs

- Permettre à un joueur de deviner un mot choisi aléatoirement
- Limiter le nombre de tentatives
- Afficher des messages de succès ou d'échec
- Offrir une interface attrayante et interactive

---

## 🛠️ Technologies utilisées

- **Java EE** (Servlets + JSP)
- **JavaScript** : pour désactiver le bouton "Deviner" une fois les essais terminés
- **Bootstrap** : pour une interface moderne et colorée
- **HTML/CSS** : structure de la page
- **Tomcat** : serveur d'exécution
- **Eclipse / IntelliJ** : IDE de développement

---

## 📸 Captures d'écran

### 🎮 Interface du jeu  
![Interface du jeu](jeu.png)

---

## ⚙️ Fonctionnalités

- Initialisation du mot à deviner via la Servlet
- Gestion des essais côté serveur
- Affichage du nombre d’essais restants
- Blocage du bouton après avoir atteint la limite d'essais
- Redémarrage du jeu sans recharger la page

---

## 🚀 Lancer l'application

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/ton-nom-utilisateur/jeu-devinette-javaee.git
