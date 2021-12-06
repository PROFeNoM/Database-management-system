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
