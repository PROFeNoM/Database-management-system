# PROJET SGBD FLOTTE VELO

CHOURA  Alexandre
ROGER   Gaëtan
BAUCHER Edgar

## INSTALLER LES PACKAGES REQUIS

- mysql (v8.0)
- php (v7.4)
- php-mysql
- php-cgi

## LANCER LE PROJET

### Utiliser la version en ligne
- http://ec2-35-180-22-19.eu-west-3.compute.amazonaws.com/projetss7-sgbd/interface/index.php

### Utiliser une version localement hébergée

1 - Créer la base sql

>>./sql.sh

Un terminal sql va s'ouvrir, dedans rentrer:

>>source src.sql

Puis, laisser ce terminal ouvert.

2 - Ouvrir le projet via l'interface web php:

>>./serveur.sh

Une page firefox s'ouvre et la base de données y est accessible.

## FERMER LE PROJET

Fermer les terminaux utilisés (sql et serveur).	