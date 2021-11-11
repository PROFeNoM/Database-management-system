-- ============================================================
--    suppression des donnees
-- ============================================================
use VELO; -- Mayn't be necessary

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

commit;

-- VILLES

insert into VILLES values (33063, 'Bordeaux', 33000);
insert into VILLES values (33003, 'Ambarès-et-Lagrave', 33440);
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
insert into VILLES values (33192, 'Gradignan', 33170);
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

commit;

-- STATIONS

insert into STATIONS values (1, 33, '3 Rue Claude Bonnier', 33063);
insert into STATIONS values (2, 20, '37 Place des martyrs de la résistance', 33063);
insert into STATIONS values (3, 40, '2 Place Gambetta', 33063);
insert into STATIONS values (4, 12, '1 Rue Pardon', 33004);
insert into STATIONS values (5, 19, '22 Boulevard Feydeau', 33013);
insert into STATIONS values (6, 19, '307 Boulevard J.J. Bosc', 33039);
insert into STATIONS values (7, 20, '24 Rue de Dehez', 33056);
insert into STATIONS values (8, 19, '92 Rue Andre Messager', 33075);
insert into STATIONS values (9, 16, '7 Rue de l''Eglise', 33110);
insert into STATIONS values (10, 30, '34 Rue Edouard Vaillant', 33119);
insert into STATIONS values (11, 16, '3 Avenue de Picot', 33162);
insert into STATIONS values (12, 20, 'Place Mayensa', 33167);
insert into STATIONS values (13, 20, 'Place Bernard Roumegoux', 33192);
insert into STATIONS values (14, 18, '43 Rue Emile Zola', 33069);
insert into STATIONS values (15, 16, '4 Rue Georges Clémenceau', 33200);
insert into STATIONS values (16, 13, '46 Avenue de Soulac', 33519);
insert into STATIONS values (17, 20, 'Pôle d''échanges Buttinière', 33249);
insert into STATIONS values (18, 18, 'Place Mondésir', 33281);
insert into STATIONS values (19, 20, '1 Rue de la Gare', 33312);
insert into STATIONS values (20, 22, '243 Avenue Bougnard', 33318);

commit;

-- ADHERENTS

-- SEPARER

-- VELOS

-- insert into VELOS values (1, '12139990003', '2019-12-03', 'Gitane', 57, 83, 0, 0);

-- EMPRUNTS


-- ============================================================
--    verification des donnees
-- ============================================================
select
    count(*),
    '=3 ?',
    'ETAT'
from
    ETATS
union
select
    count(*),
    '=29 ?',
    'VILLES'
from
    VILLES
union
select
    count(*),
    '=176 ?',
    'STATIONS'
from
    STATIONS;