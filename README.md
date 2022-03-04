# Projet_Tut_Dev_Mobile

## Saker Lucas - Spilmont François - Toubon Julien

### Initialisation du projet

* Copier `.env.example` dans `.env`
* Modifier les valeurs de `.env` avec les informations de votre base de données
* Exécuter `composer install`
* Exécuter `php artisan migrate:fresh --seed` pour créer la base de données avec un jeu de test (10 users & 20 messages)
* Exécuter `php -S localhost:8000 -t public` pour lancer le serveur
* Aller sur http://localhost:8000/api
