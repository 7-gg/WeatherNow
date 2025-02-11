# weathernow

## Objectifs 
    Développer une application mobile Flutter qui permet aux utilisateurs de
    rechercher la météo d’une ville et d’obtenir des informations détaillées sur
    les conditions actuelles ainsi que les prévisions pour les prochains jours.

## Technologies 
    -Flutter
    -Riverpod 
    -HTTPS      
    -OpenWeatherMap API

## Installation
    - installation de flutter 
        * dossier zip télécharger sur le site officiel
        * dossier dézippé dans le dossier C
        * ajout du path dans la variable d'environnement
    - installation d'android studio + démarrage de l'émulateur
    - installation du jdk 21 + ajout aux variables d'environnement
    - flutter doctor 
    - création de compte OpenWeatherMap pour obtenir la clé API
    - installation des dépendances (flutter pub get)
    - utilisation de https pour l'appel api et la récupération des données dans le service
    - utilisation de riverpod pour     

    - dart run flutter_launcher_icons :: ajout de l'icon sur l'ecran de l'utilisateur 
    - dart run flutter_native_splash:create :: splash screen qtatic lors du chargement

## lancer l'application 
    - flutter run

## Choix techniques
    - Gestion d'état : Riverpod a été choisi pour sa simplicité et sa scalabilité.
    - Appels API : Https
