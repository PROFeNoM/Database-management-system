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