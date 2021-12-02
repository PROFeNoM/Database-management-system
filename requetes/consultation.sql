-- ============================================================
--    requêtes statiques
-- ============================================================

-- Kilométrage des vélos par semaine
select * from KILOMETRAGEVELOSPARSEMAINE;

-- Kilométrage des vélos
select * from KILOMETRAGEPARVELO;

-- Nombre d'usagers par velos par jour

select * from NOMBREUSAGERSVELOSPARJOUR;

-- Listes des vélos en cours d'utilisation

select * from VELOSENCOURSUTILISATION;

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