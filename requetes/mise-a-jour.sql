/*
 Ces requêtes sont écrites dans le code PHP en fonctions des actions du client.

 Ainsi, les requêtes ci-dessous peuvent représenter le format qu'elles utilisent, mais ce ne
 sont pas celles-ci qui sont directement utilisées par l'interface.

 Par ailleurs, les requêtes réellement utilisées sont toujours affichés par l'interface lors
 d'une action client.
 */


-- ============================================================
--   ADHERENTS
-- ============================================================

-- Insertion dans la table ADHERENTS
insert into adherents (NOM_ADHERENT, PRENOM_ADHERENT, ADRESSE, NUMERO_VILLE, DATE_INSCRIPTION)
values (?, ?, ?, ?, ?);

-- Modification d'une entrée de la table ADHERENTS
update adherents
set NOM_ADHERENT = ?, PRENOM_ADHERENT = ?, ADRESSE = ?, NUMERO_VILLE = ?, DATE_INSCRIPTION = ?
where NUMERO_ADHERENT = ?;

-- Suppression d'une entrée de la table ADHERENTS
delete
from adherents
where NUMERO_ADHERENT = ?;

