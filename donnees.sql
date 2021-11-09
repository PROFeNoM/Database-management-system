-- ============================================================
--    suppression des donnees
-- ============================================================
delete from VELOS;

delete from STATIONS;

delete from ADHERENTS;

delete from EMPRUNTS;

delete from ETATS;

delete from ADRESSES;

delete from COMMUNES;

delete from SEPARER;

commit;

-- ============================================================
--    creation des donnees
-- ============================================================

-- ETATS

insert into ETATS values (0, 'parfait etat');
insert into ETATS values (1, 'tres bon etat');
insert into ETATS values (2, 'etat correct');

-- COMMUNES

-- ADRESSES

-- STATIONS

-- ADHERENTS

-- SEPARER

-- VELOS

insert into VELOS values (1, '12139990003', '2019-12-03', 'Gitane', 57, 83, 0, 0);

-- EMPRUNTS


-- ============================================================
--    verification des donnees
-- ============================================================
