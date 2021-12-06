select
    STATIONS.*
from
    STATIONS
    inner join
        VILLES V
        on STATIONS.NUMERO_VILLE = V.NUMERO_VILLE
where
    CODE_POSTAL = ?
;