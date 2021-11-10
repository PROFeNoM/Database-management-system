-- ============================================================
--    suppression des donnees
-- ============================================================
delete from VELOS;

delete from STATIONS;

delete from ADHERENTS;

delete from EMPRUNTS;

delete from ETATS;

delete from VILLES;

delete from SEPARER;

commit;

-- ============================================================
--    creation des donnees
-- ============================================================

-- ETATS

insert into ETATS values (0, 'parfait etat');
insert into ETATS values (1, 'tres bon etat');
insert into ETATS values (2, 'etat correct');

-- VILLES

insert into VILLES values (33063, 'Bordeaux', 33000);
insert into VILLES values (33003, 'Anbarès-et-Lagrave', 33440);
insert into VILLES values (33004, 'Ambès', 33810);
insert into VILLES values (33013, 'Artigues-près-Bordeaux', 33370);
insert into VILLES values (33032, 'Bassens', 33530);
insert into VILLES values (33039, 'Bègles', 33130);
insert into VILLES values (33056, 'Blanquefort', 33290);
insert into VILLES values (33065, 'Bouliac', 33270);
insert into VILLES values (33075, 'Bruges', 33520);
insert into VILLES values (33096, 'Carbon-Blanc', 33560);
insert into VILLES values (33110, 'Caudéran', 33200);
insert into VILLES values (33119, 'Cenon', 33150);
insert into VILLES values (33162, 'Eysines', 33320);
insert into VILLES values (33167, 'Floirac', 33270);
insert into VILLES values (33192, 'Gradignan',33170);
insert into VILLES values (33069, 'Le Bouscat', 33110);
insert into VILLES values (33200, 'Le Haillan', 33185);
insert into VILLES values (33519, 'Le Taillan-Médoc', 33320);
insert into VILLES values (33249, 'Lormont', 33310);
insert into VILLES values (33273, 'Martignas-sur-Jalle', 33127);
insert into VILLES values (33281, 'Mérignac', 33700);
insert into VILLES values (33312, 'Parempuyre', 33290);
insert into VILLES values (33318, 'Pessac', 33600);
insert into VILLES values (33376, 'Saint-Aubin-de-Médoc', 33160);
insert into VILLES values (33434, 'Saint-Louis-de-Montferrand', 33440);
insert into VILLES values (33449, 'Saint-Médard-en-Jalles', 33160);
insert into VILLES values (33487, 'Saint-Vincent-de-Paul', 33440);
insert into VILLES values (33522, 'Talence', 33522);
insert into VILLES values (33550, 'Villenave-d''Ornon', 33140);

-- STATIONS

-- ADHERENTS

-- SEPARER

-- VELOS

insert into VELOS values (1, '12139990003', '2019-12-03', 'Gitane', 57, 83, 0, 0);

-- EMPRUNTS


-- ============================================================
--    verification des donnees
-- ============================================================
