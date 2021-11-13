select
    STATIONS.*
from
    STATIONS
    inner join
        VILLES V
        on STATIONS.NUMERO_VILLE = V.NUMERO_INSEE
where
    NOM_VILLE = ?
;