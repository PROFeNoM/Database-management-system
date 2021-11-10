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
-- Source : https://www.infotbm.com/fr/v3/

insert into STATIONS values (1, 33, '3 Rue Claude Bonnier', 33063);
insert into STATIONS values (2, 20, '14 Rue François de Sourdis', 33063);
insert into STATIONS values (3, 26, 'Place du capitaine du Tertre', 33063);
insert into STATIONS values (4, 20, '37 Place des martyrs de la résistance', 33063);
insert into STATIONS values (5, 40, '2 Place Gambetta', 33063);
insert into STATIONS values (6, 40, '12 Cours d''Albret', 33063);
insert into STATIONS values (7, 14, '18 Cours du Maréchal Juin', 33063);
insert into STATIONS values (8, 20, '120 Cours du Maréchal Juin', 33063);
insert into STATIONS values (9, 20, '206 Rue d''Ornano', 33063);
insert into STATIONS values (10, 22, '115 Boulevard Antoine Gautier', 33063);
insert into STATIONS values (12, 15, '24 Avenue Louis Barthou', 33063);
insert into STATIONS values (13, 20, '278 Boulevard Président Wilson', 33063);
insert into STATIONS values (14, 30, '75 Rue de Lyon', 33063);
insert into STATIONS values (15, 14, '71 Rue de la Croix Blanche', 33063);
insert into STATIONS values (16, 30, '65 Avenue Thiers', 33063);
insert into STATIONS values (17, 14, '1 Rue Emile Fourcand', 33063);
insert into STATIONS values (18, 14, '78 Rue du Palais Gallien', 33063);
insert into STATIONS values (19, 30, '58 Allées de Tourny', 33063);
insert into STATIONS values (20, 22, '1 Place des Grands Hommes', 33063);
insert into STATIONS values (21, 15, '1 Place Puy Paulin', 33063);
insert into STATIONS values (22, 33, 'Place Pey Berland', 33063);
insert into STATIONS values (23, 38, 'Place de la République', 33063);
insert into STATIONS values (24, 16, '9 Rue Léon Drouyn', 33063);
insert into STATIONS values (25, 15, '97 Rue Francois de Sourdis', 33063);
insert into STATIONS values (26, 16, '247 Boulevard Maréchal Leclerc', 33063);
insert into STATIONS values (27, 20, 'Université Bordeaux II, Maternité Pellegrin', 33063);
insert into STATIONS values (28, 32, 'Place Amélie Raba Léon', 33063);
insert into STATIONS values (29, 20, 'Place de L''Eglise Saint-Augustin', 33063);
insert into STATIONS values (30, 18, 'Place Mondésir', 33281);
insert into STATIONS values (31, 16, '7 Rue de l''Eglise', 33110);
insert into STATIONS values (32, 16, '67 Avenue Carnot', 33110);
insert into STATIONS values (33, 20, '6 Boulevard Pierre 1er', 33063);
insert into STATIONS values (34, 14, '17 Rue Rivière', 33063);
insert into STATIONS values (35, 19, '211 Rue Fondaudège', 33063);
insert into STATIONS values (36, 17, '2 Place de Longchamps', 33063);
insert into STATIONS values (37, 30, '60 Cours de Verdun', 33063);
insert into STATIONS values (38, 16, '16 Place Charles Gruet', 33063);
insert into STATIONS values (39, 40, '9 Cours du 30 Juillet', 33063);
insert into STATIONS values (40, 20, '3 Rue esprit des lois', 33063);
insert into STATIONS values (41, 18, '9 Rue des Trois Conils', 33063);
insert into STATIONS values (42, 20, '31 Rue du pas Saint Georges', 33063);
insert into STATIONS values (43, 18, '7 Rue Ravez', 33063);
insert into STATIONS values (44, 20, '16 Cours Pasteur', 33063);
insert into STATIONS values (45, 19, '2 Place Sainte Eulalie', 33063);
insert into STATIONS values (46, 21, 'Allée Eugène Delacroix', 33063);
insert into STATIONS values (47, 16, '212 Rue Fernand Audeguil', 33063);
insert into STATIONS values (48, 18, '50 Boulevard George V', 33063);
insert into STATIONS values (49, 18, '43 Rue Emile Zola', 33069);
insert into STATIONS values (50, 14, '14 Boulevard Godard', 33063);
insert into STATIONS values (51, 20, '159 Boulevard Godard', 33063);
insert into STATIONS values (52, 18, 'Cours de Luze', 33063);
insert into STATIONS values (53, 14, '230 Rue Camille Godard', 33063);
insert into STATIONS values (54, 44, '28 Rue Saint Vincent de Paul', 33063);
insert into STATIONS values (55, 16, '35 Cours Evrard de Fayolle', 33063);
insert into STATIONS values (56, 20, 'Place Paul Doumer', 33063);
insert into STATIONS values (57, 16, '9 Rue Sicard', 33063);
insert into STATIONS values (58, 18, '73 Quai des Chartrons', 33063);
insert into STATIONS values (59, 18, '17 Quai des Chartrons', 33063);
insert into STATIONS values (60, 20, '1 Allées de Chartres', 33063);

-- Y'en a d'autres qui arrivent wllh ça va jusqu'au numéro 251 jpp

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
    VILLES;