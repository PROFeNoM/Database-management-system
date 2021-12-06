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
