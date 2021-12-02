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
insert into
    ADHERENTS (NOM_ADHERENT, PRENOM_ADHERENT, ADRESSE, NUMERO_VILLE, DATE_INSCRIPTION)
values (?, ?, ?, ?, ?);

-- Modification d'une entrée de la table ADHERENTS
update ADHERENTS
set
    NOM_ADHERENT     = ?,
    PRENOM_ADHERENT  = ?,
    ADRESSE          = ?,
    NUMERO_VILLE     = ?,
    DATE_INSCRIPTION = ?
where
    NUMERO_ADHERENT = ?;

-- Suppression d'une entrée de la table ADHERENTS
delete
from
    ADHERENTS
where
    NUMERO_ADHERENT = ?;

-- ============================================================
--   EMPRUNTS
-- ============================================================

-- Insertion dans la table EMPRUNTS
insert into
    EMPRUNTS (DATE_EMPRUNT, HEURE_EMPRUNT, DATE_DEPOT, HEURE_DEPOT, NUMERO_VELO, NUMERO_ADHERENT, NUMERO_STATION_DEPART,
              NUMERO_STATION_ARRIVEE)
values (?, ?, ?, ?, ?, ?, ?, ?);

-- Modification d'une entrée de la table EMPRUNTS
update EMPRUNTS
set
    DATE_EMPRUNT           = ?,
    HEURE_EMPRUNT          = ?,
    DATE_DEPOT             = ?,
    HEURE_DEPOT            = ?,
    NUMERO_VELO            = ?,
    NUMERO_ADHERENT        = ?,
    NUMERO_STATION_DEPART  = ?,
    NUMERO_STATION_ARRIVEE = ?
where
    NUMERO_EMPRUNT = ?;

-- Suppression d'une entrée de la table EMPRUNTS
delete
from
    EMPRUNTS
where
    NUMERO_EMPRUNT = ?;

-- ============================================================
--   ETATS
-- ============================================================

-- Insertion dans la table ETATS
insert into ETATS (ETAT) values (?);

-- Modification d'une entrée de la table ETATS
update ETATS set ETAT = ? where NUMERO_ETAT = ?;

-- Suppression d'une entrée de la table ETATS
delete
from
    ETATS
where
    NUMERO_ETAT = ?;

-- ============================================================
--   SEPARER
-- ============================================================

-- Insertion dans la table SEPARER
insert into SEPARER (NUMERO_STATION_1, NUMERO_STATION_2, DISTANCE) values (?, ?, ?);

-- Modification d'une entrée de la table SEPARER
update SEPARER set DISTANCE = ? where NUMERO_STATION_1 = ? and NUMERO_STATION_2 = ?;

-- Suppression d'une entrée de la table SEPARER
delete from SEPARER where NUMERO_STATION_1 = ? and NUMERO_STATION_2 = ?;

-- ============================================================
--   STATIONS
-- ============================================================

-- Insertion dans la table STATIONS
insert into STATIONS (NOMBRE_BORNES, ADRESSE, NUMERO_VILLE) values (?, ?, ?);

-- Modification d'une entrée de la table STATIONS
update STATIONS set NOMBRE_BORNES = ?, ADRESSE = ?, NUMERO_VILLE = ? where NUMERO_STATION = ?;

-- Suppression d'une entrée de la table STATIONS
delete from STATIONS where NUMERO_STATION = ?;

-- ============================================================
--   VELOS
-- ============================================================

-- Insertion dans la table VELOS
insert into
    VELOS (REFERENCE, DATE_MISE_EN_SERVICE, MARQUE, NIVEAU_CHARGE_BATTERIE, NUMERO_ETAT, NUMERO_STATION)
values (?, ?, ?, ?, ?, ?);

-- Modification d'une entrée de la table STATIONS
update VELOS
set
    REFERENCE              = ?,
    DATE_MISE_EN_SERVICE   = ?,
    MARQUE                 = ?,
    NIVEAU_CHARGE_BATTERIE = ?,
    NUMERO_ETAT            = ?,
    NUMERO_STATION         = ?
where
    NUMERO_VELO = ?;

-- Suppression d'une entrée de la table VELOS
delete from VELOS where NUMERO_VELO = ?;

-- ============================================================
--   VILLES
-- ============================================================

-- Insertion dans la table VILLES
insert into VILLES (NOM_VILLE, CODE_POSTAL) values (?, ?);

-- Modification d'une entrée de la table VILLES
update VILLES set NOM_VILLE = ?, CODE_POSTAL = ? where NUMERO_VILLE = ?;

-- Suppression d'une entrée de la table VILLES
delete from VILLES where NUMERO_VILLE = ?;