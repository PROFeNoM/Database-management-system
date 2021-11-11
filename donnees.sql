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
insert into STATIONS values (11, 12, '1 Rue Pardon', 33004);
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
insert into STATIONS values (61, 16, '1 Allée Jean Gioni', 33063);
insert into STATIONS values (62, 30, '34 Rue Edouard Vaillant', 33119);
insert into STATIONS values (63, 18, '10 Avenue du Président Francois Mittérand', 33167);
insert into STATIONS values (64, 18, 'Square M-L. Sue', 33063);
insert into STATIONS values (65, 41, '7 Place Stalingrad', 33063);
insert into STATIONS values (66, 20, 'Gare d''Orléans', 33063);
insert into STATIONS values (67, 18, '34 Allée de Serr', 33063);
insert into STATIONS values (68, 18, '73 Avenue Thiers', 33063);
insert into STATIONS values (69, 14, '5 Place Calixte Camelle', 33063);
insert into STATIONS values (70, 20, 'Pôle d''échanges Buttinière', 33249);
insert into STATIONS values (71, 18, 'Avenue des Griffons, Terminus Bus', 33249);
insert into STATIONS values (72, 24, 'Avenue Jean Zay, Stations Tramway', 33119);
insert into STATIONS values (73, 19, '307 Boulevard J.J. Bosc', 33039);
insert into STATIONS values (74, 22, '2 Rue Calixte Camelle', 33039);
insert into STATIONS values (75, 18, '111 Avenue Lucien Lerousseau', 33039);
insert into STATIONS values (76, 21, '564 Route de Toulouse', 33550);
insert into STATIONS values (77, 20, 'Place Bernard Roumegoux', 33192);
insert into STATIONS values (78, 22, '243 Avenue Bougnard', 33318);
insert into STATIONS values (79, 20, '2 Rue Gustave Eiffel', 33318);
insert into STATIONS values (80, 18, '30 Avenue du haut leveque', 33318);
insert into STATIONS values (81, 18, '33 Avenue du Général Leclerc', 33318);
insert into STATIONS values (82, 20, '62 Avenue de Canéjan', 33318);
insert into STATIONS values (83, 21, '25 Rue Eugène et Marc Dulout', 33318);
insert into STATIONS values (84, 18, '110 Avenue P. Mendès France', 33281);
insert into STATIONS values (85, 18, '42 Avenue de la Marne', 33281);
insert into STATIONS values (86, 20, '309 Avenue de la Somme', 33281);
insert into STATIONS values (87, 20, '3 Avenue Rudolf Diesel', 33281);
insert into STATIONS values (88, 18, 'Place Jean Jaurès', 33281);
insert into STATIONS values (89, 21, '1 Avenue Verdun', 33281);
insert into STATIONS values (90, 18, '189 Avenue Francois Mitterand', 33281);
insert into STATIONS values (91, 16, '4 Rue Georges Clémenceau', 33200);
insert into STATIONS values (92, 16, '5 Avenue Montesquieu', 33449);
insert into STATIONS values (93, 16, '3 Avenue de Picot', 33162);
insert into STATIONS values (94, 18, '1 Rue de la Gare', 33056);
insert into STATIONS values (95, 16, '87 Avenue du Général de Gaulle', 33075);
insert into STATIONS values (96, 26, '76 Avenue de Laroque', 33063);
insert into STATIONS values (97, 20, '101 Rue Joseph Brunet', 33063);
insert into STATIONS values (98, 18, '83 Quai de Bacalan', 33063);
insert into STATIONS values (99, 20, '36 Quai de Bacalan', 33063);
insert into STATIONS values (100, 40, '119 Quai des Chartrons', 33063);
insert into STATIONS values (101, 20, '30 Quai Maréchal Lyautey', 33063);
insert into STATIONS values (102, 20, '6 Quai de la douane', 33063);
insert into STATIONS values (103, 20, '40 Cours Alsace et Lorraine', 33063);
insert into STATIONS values (104, 17, '12 Place de la ferme de Richemont', 33063);
insert into STATIONS values (105, 20, '63 Rue du Mirail', 33063);
insert into STATIONS values (106, 40, '23 Place de la Victoire', 33063);
insert into STATIONS values (107, 15, '20 Rue Brian', 33063);
insert into STATIONS values (108, 16, '3 Rue Grateloup', 33063);
insert into STATIONS values (109, 36, '276 Cours de l''Argonne', 33063);
insert into STATIONS values (110, 30, '1 Cours de la Libération', 33522);
insert into STATIONS values (111, 32, 'Avenue Roul, Terminus Bus', 33522);
insert into STATIONS values (112, 39, '345 Avenue des Facultés', 33522);
insert into STATIONS values (113, 20, '112 Cours de la Libération', 33522);
insert into STATIONS values (114, 27, '32 Rue Compostelle', 33192);
insert into STATIONS values (115, 32, '10 Avenue de la Libération', 33522);
insert into STATIONS values (116, 40, 'Station Montaigne Montesquieu', 33318);
insert into STATIONS values (117, 20, 'Rond-Point Avenue des Facultés', 33318);
insert into STATIONS values (118, 20, '35 Allée de Boutaut', 33069);
insert into STATIONS values (119, 19, '45 Avenue Emile Counord', 33063);
insert into STATIONS values (120, 30, '196 Cours Saint Louis', 33063);
insert into STATIONS values (121, 14, '30 Place Saint Martial', 33063);
insert into STATIONS values (122, 16, '77 Cours Saint Louis', 33063);
insert into STATIONS values (123, 36, '42 Quai Richelieu', 33063);
insert into STATIONS values (124, 19, '8 Quai de la Monnaie', 33063);
insert into STATIONS values (125, 30, 'Quai Sainte Croix, Conservatoire', 33063);
insert into STATIONS values (126, 12, '82 Quai Paludate', 33063);
insert into STATIONS values (127, 22, 'Rue Saint Vincent de Paul, Terminus Bus', 33063);
insert into STATIONS values (128, 16, '112 Rue Pelleport', 33063);
insert into STATIONS values (129, 17, 'Parking du Cinéma', 33039);
insert into STATIONS values (130, 19, '8B Boulevard Albert 1er', 33063);
insert into STATIONS values (131, 18, '238 Cours de l''Yser', 33063);
insert into STATIONS values (132, 14, '118 Cours de la Somme', 33063);
insert into STATIONS values (133, 20, '30 Place des Capucins', 33063);
insert into STATIONS values (134, 20, '20 Place du Maucaillou', 33063);
insert into STATIONS values (135, 20, '7 Rue des Faures', 33063);
insert into STATIONS values (136, 18, 'Place Pierre Renaudel', 33063);
insert into STATIONS values (137, 24, 'Place Andre Meunier', 33063);
insert into STATIONS values (138, 18, 'Place Pigalle', 33063);
insert into STATIONS values (139, 18, '152 Cours de l''Yser', 33063);
insert into STATIONS values (140, 20, '120 Rue de la Bechade', 33063);
insert into STATIONS values (141, 20, '254 Cours du Maréchal Gallieni', 33522);
insert into STATIONS values (142, 20, '160 Avenue de Verdun', 33281);
insert into STATIONS values (143, 18, '46 Rue Domion', 33063);
insert into STATIONS values (144, 19, '92 Rue Andre Messager', 33075);
insert into STATIONS values (145, 17, '65 Cours du Quebec', 33063);
insert into STATIONS values (146, 30, '17 Avenue Jean Gabriel Domergue', 33063);
insert into STATIONS values (147, 30, '1 Allée Louis Ratabou', 33063);
insert into STATIONS values (148, 14, '49 Avenue du Docteur Schinazi', 33063);
insert into STATIONS values (149, 20, '5 Avenue de la Résistance', 33249);
insert into STATIONS values (150, 19, '22 Boulevard Feydeau', 33013);
insert into STATIONS values (151, 20, '1 Rue Salvador Allende', 33167);
insert into STATIONS values (152, 20, '349 Route de Toulouse', 33550);
insert into STATIONS values (153, 20, '325 Chemin de Leysotte', 33550);
insert into STATIONS values (154, 20, '221 Avenue de Thouars', 33522);
insert into STATIONS values (155, 24, '10 Rue de Naudet', 33192);
insert into STATIONS values (156, 20, '39 Rue Maurice Utrillo', 33281);
insert into STATIONS values (157, 20, '2 Rue Alphonse Daudet', 33281);
insert into STATIONS values (158, 20, '1 Avenue de Magudas', 33200);
insert into STATIONS values (159, 24, '26 Boulevard Jacques Chaban-Delmas', 33075);
insert into STATIONS values (160, 10, '254 Route de Saint-Médard', 33376);
insert into STATIONS values (161, 13, '46 Avenue de Soulac', 33519);
insert into STATIONS values (162, 20, '14 Avenur Lénine', 33039);
insert into STATIONS values (163, 20, '516 Route de Toulouse', 33039);
insert into STATIONS values (164, 15, '140 Avenue du haut leveque', 33318);
insert into STATIONS values (165, 20, '10 Avenue du haut leveque', 33318);
insert into STATIONS values (166, 20, '53 Avenue du Lac', 33063);
insert into STATIONS values (167, 20, '75 Avenue René Descartes', 33449);
insert into STATIONS values (168, 20, '24 Rue de Dehez', 33056);
insert into STATIONS values (169, 20, '2 Rue Léopold Laplante', 33075);
insert into STATIONS values (170, 20, '107 Cours du Raccordement', 33063);
insert into STATIONS values (171, 20, 'Place Amédée Larrieu', 33063);
insert into STATIONS values (172, 28, '345 Quai de Bacalan', 33063);
insert into STATIONS values (173, 18, '1 Rue Achard', 33063);
insert into STATIONS values (174, 43, '54 Quai de Queyries', 33063);
insert into STATIONS values (175, 20, 'Place Mayensa', 33167);
insert into STATIONS values (176, 20, '1 Rue de la Gare', 33312);

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