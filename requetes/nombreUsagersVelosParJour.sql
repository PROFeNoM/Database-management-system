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
    E.DATE_EMPRUNT