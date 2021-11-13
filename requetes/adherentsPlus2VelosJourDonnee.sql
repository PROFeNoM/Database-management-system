select
    A.*,
    count(distinct E.NUMERO_VELO)
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
