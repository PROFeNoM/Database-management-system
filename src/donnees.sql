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

insert into ETATS values (1, 'parfait etat');
insert into ETATS values (2, 'tres bon etat');
insert into ETATS values (3, 'etat correct');

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
insert into STATIONS values (4, 12, '1 Avenue Pierre Bérégovoy', 33004);
insert into STATIONS values (5, 19, '22 Boulevard Feydeau', 33013);
insert into STATIONS values (6, 19, '307 Boulevard J.J. Bosc', 33039);
insert into STATIONS values (7, 20, '24 Rue de Dehez', 33056);
insert into STATIONS values (8, 19, '92 Rue Andre Messager', 33075);
insert into STATIONS values (9, 16, '7 Rue de l''Eglise', 33110);
insert into STATIONS values (10, 30, '34 Rue Edouard Vaillant', 33119);
/*
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
*/

commit;

-- ADHERENTS

insert into ADHERENTS values (1, 'Shavershian', 'Aziz', '59 Rue de la Paix', 33096, '2020-12-03');
insert into ADHERENTS values (2, 'Diakhaté', 'Issa', '667 Rue Yves Saint Laurent', 33434, '2020-12-03');
insert into ADHERENTS values (3, 'Andrieu', 'Nabil', '2 Rue Deux Frères', 33318, '2020-12-03');
insert into ADHERENTS values (4, 'Andrieu', 'Tarik', '2B Rue Deux Frères', 33318, '2020-12-03');
insert into ADHERENTS values (5, 'Jackson', 'Mickael', '89 Rue des frissons', 33522, '2020-12-03');
insert into ADHERENTS values (6, 'Bruce Mathers III', 'Marshall', '1 Rue des Dieux', 33063, '2020-12-03');
insert into ADHERENTS values (7, 'Shakur', 'Tupac', '42 Rue Vision', 33449, '2020-12-03');

commit;

-- SEPARER

insert into SEPARER values (1, 2, 0.650);
insert into SEPARER values (1, 3, 0.850);
insert into SEPARER values (1, 4, 25.0);
insert into SEPARER values (1, 5, 8.7);
insert into SEPARER values (1, 6, 5.3);
insert into SEPARER values (1, 7, 10.3);
insert into SEPARER values (1, 8, 5.9);
insert into SEPARER values (1, 9, 3.7);
insert into SEPARER values (1, 10, 6.2);

insert into SEPARER values (2, 3, 0.7);
insert into SEPARER values (2, 4, 24.4);
insert into SEPARER values (2, 5, 8.6);
insert into SEPARER values (2, 6, 5.6);
insert into SEPARER values (2, 7, 9.1);
insert into SEPARER values (2, 8, 5.9);
insert into SEPARER values (2, 9, 3.0);
insert into SEPARER values (2, 10, 5.5);

insert into SEPARER values (3, 4, 24.1);
insert into SEPARER values (3, 5, 8.2);
insert into SEPARER values (3, 6, 4.9);
insert into SEPARER values (3, 7, 8.9);
insert into SEPARER values (3, 8, 5.1);
insert into SEPARER values (3, 9, 3.4);
insert into SEPARER values (3, 10, 4.6);

insert into SEPARER values (4, 5, 2.0);
insert into SEPARER values (4, 6, 6.5);
insert into SEPARER values (4, 7, 14.2);
insert into SEPARER values (4, 8, 9.1);
insert into SEPARER values (4, 9, 10.8);
insert into SEPARER values (4, 10, 3.9);

insert into SEPARER values (5, 6, 9.1);
insert into SEPARER values (5, 7, 16.8);
insert into SEPARER values (5, 8, 10.6);
insert into SEPARER values (5, 9, 11.9);
insert into SEPARER values (5, 10, 4.4);

insert into SEPARER values (6, 7, 14.4);
insert into SEPARER values (6, 8, 9.6);
insert into SEPARER values (6, 9, 8.0);
insert into SEPARER values (6, 10, 7.7);

insert into SEPARER values (7, 8, 5.6);
insert into SEPARER values (7, 9, 8.7);
insert into SEPARER values (7, 10, 11.7);

insert into SEPARER values (8, 9, 6.6);
insert into SEPARER values (8, 10, 6.4);

insert into SEPARER values (9, 10, 8.2);

commit;

-- VELOS

insert into VELOS values (1, '12139990003', '2020-12-03', 'Gitane', 83, 1, 3);
insert into VELOS values (2, '12139990004', '2020-12-03', 'Gitane', 99, 2, 1);
insert into VELOS values (3, '12139990005', '2020-12-03', 'Gitane', 87, 1, 3);
insert into VELOS values (4, '12139990006', '2020-12-03', 'Gitane', 36, 3, null);
insert into VELOS values (5, '12139990007', '2020-12-04', 'Gitane', 87, 3, null);
insert into VELOS values (6, '12139990008', '2020-12-04', 'Gitane', 13, 2, 8);
insert into VELOS values (7, '12139990009', '2020-12-04', 'Gitane', 24, 2, 9);
insert into VELOS values (8, '12139990010', '2020-12-04', 'Gitane', 24, 2, 9);
insert into VELOS values (9, '12139990011', '2020-12-04', 'Gitane', 65, 3, 10);
insert into VELOS values (10, '12139990012', '2020-12-04', 'Gitane', 76, 1, 10);

commit;

-- EMPRUNTS

insert into EMPRUNTS values (1, '2020-12-05', '12:56:32', '2020-12-05', '13:23:34', 1, 2, 3, 1);
insert into EMPRUNTS values (2, '2020-12-05', '13:56:32', '2020-12-05', '14:23:34', 1, 2, 1, 3);
insert into EMPRUNTS values (3, '2020-12-05', '15:56:32', '2020-12-05', '16:23:34', 1, 2, 3, 1);
insert into EMPRUNTS values (4, '2020-12-05', '13:43:01', '2020-12-05', '13:59:01', 6, 3, 8, 4);
insert into EMPRUNTS values (5, '2020-12-05', '23:43:01', null, null, 6, 3, 4, null);

commit;

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
    '=20 ?',
    'STATIONS'
from
    STATIONS
union
select
    count(*),
    '=7 ?',
    'ADHERENTS'
from
    ADHERENTS
union
select
    count(*),
    '=45 ?',
    'SEPARER'
from
    SEPARER
union
select
    count(*),
    '=10 ?',
    'VELOS'
from
    VELOS
union
select
    count(*),
    '=5 ?',
    'EMPRUNTS'
from
    EMPRUNTS;