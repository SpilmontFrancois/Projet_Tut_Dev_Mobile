# Projet_Tut_Dev_Mobile

## Saker Lucas - Spilmont François - Toubon Julien

### Initialisation du projet

#### API

* Exécuter `cd api/`
* Copier `.env.example` dans `.env`
* Modifier les valeurs de `.env` avec les informations de votre base de données
* Exécuter `composer install`
* Exécuter `php artisan migrate:fresh --seed` pour créer la base de données avec un jeu de test (10 users & 20 messages)
* Exécuter `php -S 0.0.0.0:8000 -t public` pour lancer le serveur (remplacer 0.0.0.0 par l'adresse IP de votre serveur, doit être différent de localhost)
* Aller sur http://0.0.0.0:8000/api

#### Front VueJS

* Exécuter `cd vuejs/`
* Exécuter `yarn install` ou `npm install`
* Exécuter `yarn dev` ou `npm run dev`
* Aller sur http://localhost:3000 (par défaut)

#### Front Flutter

* Exécuter `cd flutter_app/`
* Exécuter `flutter run`
* Une fenêtre s'ouvrira avec un navigateur internet
