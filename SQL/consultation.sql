-- ============================================================
--    requêtes statiques
-- ============================================================

-- Kilométrage des vélos par semaine
select
    NUMERO_VELO,
    REFERENCE,
    DATE_MISE_EN_SERVICE,
    MARQUE,
    NIVEAU_CHARGE_BATTERIE,
    NUMERO_ETAT,
    NUMERO_STATION,
    sum(KM) AS KILOMETRAGE
from
    (select
         V.*,
         sum(S.DISTANCE) as KM
     from
         VELOS V
             inner join EMPRUNTS E
                        on V.NUMERO_VELO = E.NUMERO_VELO
             inner join SEPARER S
                        on S.NUMERO_STATION_1 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_2 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO
     union
     select
         V.*,
         sum(S.DISTANCE) as KM
     from
         VELOS V
             inner join EMPRUNTS E
                        on V.NUMERO_VELO = E.NUMERO_VELO
             inner join SEPARER S
                        on S.NUMERO_STATION_2 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_1 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO) Q
group by
    NUMERO_VELO,
    REFERENCE,
    DATE_MISE_EN_SERVICE,
    MARQUE,
    NIVEAU_CHARGE_BATTERIE,
    NUMERO_ETAT,
    NUMERO_STATION
order by
    NUMERO_VELO;

-- Kilométrage des vélos

select
    NUMERO_VELO,
    REFERENCE,
    DATE_MISE_EN_SERVICE,
    MARQUE,
    NIVEAU_CHARGE_BATTERIE,
    NUMERO_ETAT,
    NUMERO_STATION,
    sum(KM) AS KILOMETRAGE
from
    (select
         V.*,
         sum(S.DISTANCE) as KM
     from
         VELOS V
             inner join EMPRUNTS E
                        on V.NUMERO_VELO = E.NUMERO_VELO
             inner join SEPARER S
                        on S.NUMERO_STATION_1 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_2 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO
     union
     select
         V.*,
         sum(S.DISTANCE) as KM
     from
         VELOS V
             inner join EMPRUNTS E
                        on V.NUMERO_VELO = E.NUMERO_VELO
             inner join SEPARER S
                        on S.NUMERO_STATION_2 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_1 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO) Q
group by
    NUMERO_VELO,
    REFERENCE,
    DATE_MISE_EN_SERVICE,
    MARQUE,
    NIVEAU_CHARGE_BATTERIE,
    NUMERO_ETAT,
    NUMERO_STATION
order by
    NUMERO_VELO;

-- Nombre d'usagers par velos par jour

select
    E.DATE_EMPRUNT DATE,
    V.REFERENCE,
    count(distinct E.NUMERO_ADHERENT) NOMBRE_USAGERS
from
    ADHERENTS A
        inner join EMPRUNTS E
                   on A.NUMERO_ADHERENT = E.NUMERO_ADHERENT
        inner join VELOS V
                   on E.NUMERO_VELO = V.NUMERO_VELO
group by
    E.DATE_EMPRUNT,
    V.REFERENCE
order by
    E.DATE_EMPRUNT;

-- Listes des vélos en cours d'utilisation

select *
from
    VELOS
where
    NUMERO_STATION is null;

-- ============================================================
--    requêtes paramétrables
-- ============================================================

-- Liste des adhérents ayant emprunté plus de 2 velos pour un jour donnée
select
    A.*,
    count(distinct E.NUMERO_VELO) NOMBRE_VELOS
from
    ADHERENTS A
        join EMPRUNTS E
             on A.NUMERO_ADHERENT = E.NUMERO_ADHERENT
where
        E.DATE_EMPRUNT = ?
group by
    A.NUMERO_ADHERENT
having
        count(distinct E.NUMERO_VELO) >= 2;

-- Classement des stations en fonction de leur nombre de places disponibles pour une commune donnée
select
    S.*,
    (select
             S.NOMBRE_BORNES - count(*)
     from
         STATIONS
             join VELOS V
                  on STATIONS.NUMERO_STATION = V.NUMERO_STATION
     where
             V.NUMERO_STATION = S.NUMERO_STATION) BORNES_DISPONIBLES
from
    STATIONS S
        join VILLES V2
             on V2.NUMERO_VILLE = S.NUMERO_VILLE
where
        V2.NOM_VILLE = ?
order by
    BORNES_DISPONIBLES desc;

-- Classement des vélos en fonction de leur niveau de charge pour une station donnée
select
    V.*
from
    VELOS V
        join
    STATIONS S
    on V.NUMERO_STATION = S.NUMERO_STATION
where
        S.NUMERO_STATION = ?
order by
    V.NIVEAU_CHARGE_BATTERIE desc;

-- Liste des stations dans une ville pour un code postal donné

select
    STATIONS.*
from
    STATIONS
        inner join
    VILLES V
    on STATIONS.NUMERO_VILLE = V.NUMERO_VILLE
where
        CODE_POSTAL = ?;

-- Liste des stations dans une ville pour un nom de ville donnée

select
    STATIONS.*
from
    STATIONS
        inner join
    VILLES V
    on STATIONS.NUMERO_VILLE = V.NUMERO_VILLE
where
        NOM_VILLE = ?;

-- Liste des vélos à une station donnée

select
    VELOS.*
from
    VELOS
where
        NUMERO_STATION = ?;