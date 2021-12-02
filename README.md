=== PROJET SGBD FLOTTE VELO ==

CHOURA  Alexandre
ROGER   Gaëtan
BAUCHER Edgar

=== INSTALLER LES PACKAGES REQUIS ===

mysql (v8.0)
php (v7.4)
php-mysql
php-cgi

=== POUR LANCER LE PROJET: ==

1 - Lance la base sql:

>>./sql.sh

Un terminal sql va s'ouvrir, dedans rentrer:

>>source src.sql

Puis, laisser ce terminal ouvert.

2 - Ouvrir le projet via l'interface web php:

>>./serveur.sh

Une page firefox s'ouvre et la base de données y est accessible.

=== POUR FERMER LE PRJET: ===

Fermer les terminaux utilisés (sql et serveur).	