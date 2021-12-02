select
    Q.SEMAINE,
    Q.REFERENCE,
    sum(Q.KM) KILOMETRAGE
from
    (select
         week(E.DATE_EMPRUNT) SEMAINE,
         V.REFERENCE,
         sum(S.DISTANCE) as   KM
     from
         VELOS V
         inner join EMPRUNTS E
                    on V.NUMERO_VELO = E.NUMERO_VELO
         inner join SEPARER S
                    on S.NUMERO_STATION_1 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_2 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO, SEMAINE
     union
     select
         week(E.DATE_EMPRUNT) SEMAINE,
         V.REFERENCE,
         sum(S.DISTANCE) as   KM
     from
         VELOS V
         inner join EMPRUNTS E
                    on V.NUMERO_VELO = E.NUMERO_VELO
         inner join SEPARER S
                    on S.NUMERO_STATION_2 = E.NUMERO_STATION_DEPART and S.NUMERO_STATION_1 = E.NUMERO_STATION_ARRIVEE
     group by V.NUMERO_VELO, SEMAINE) Q
group by
    Q.SEMAINE, Q.REFERENCE
order by
    Q.SEMAINE;