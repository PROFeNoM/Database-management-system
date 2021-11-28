-- ============================================================
--   Nom de la base   :  VELO
--   Nom de SGBD      :  MySQL Version 8.0
--   Date de creation :  09/11/21  16:33
-- ============================================================

drop database if exists VELO;

create database VELO;
use VELO;

-- ============================================================
--   Table : VELOS
-- ============================================================
create table VELOS
(
    NUMERO_VELO            INT not null auto_increment,
    REFERENCE              CHAR(42),
    DATE_MISE_EN_SERVICE   DATE,
    MARQUE                 CHAR(42),
    NIVEAU_CHARGE_BATTERIE INT check ( NIVEAU_CHARGE_BATTERIE >= 0 and NIVEAU_CHARGE_BATTERIE <= 100),
    NUMERO_ETAT            INT not null,
    NUMERO_STATION         INT,
    constraint PK_VELOS primary key (NUMERO_VELO)
);

-- ============================================================
--   Table : STATIONS
-- ============================================================
create table STATIONS
(
    NUMERO_STATION INT       not null auto_increment,
    NOMBRE_BORNES  INT       not null check ( NOMBRE_BORNES > 0 ),
    ADRESSE        CHAR(255) not null,
    NUMERO_VILLE   INT       not null,
    constraint PK_STATIONS primary key (NUMERO_STATION)
);

-- ============================================================
--   Table : ADHERENTS
-- ============================================================
create table ADHERENTS
(
    NUMERO_ADHERENT  INT       not null auto_increment,
    NOM_ADHERENT     CHAR(42)  not null,
    PRENOM_ADHERENT  CHAR(42),
    ADRESSE          CHAR(255) not null,
    NUMERO_VILLE     INT       not null,
    DATE_INSCRIPTION DATE      not null,
    constraint PK_ADHERENTS primary key (NUMERO_ADHERENT)
);

-- ============================================================
--   Table : EMPRUNTS
-- ============================================================
create table EMPRUNTS
(
    NUMERO_EMPRUNT         INT  not null auto_increment,
    DATE_EMPRUNT           DATE not null,
    HEURE_EMPRUNT          TIME not null,
    DATE_DEPOT             DATE null,
    HEURE_DEPOT            TIME,
    NUMERO_VELO            INT  not null,
    NUMERO_ADHERENT        INT  not null,
    NUMERO_STATION_DEPART  INT  not null,
    NUMERO_STATION_ARRIVEE INT,
    constraint PK_EMPRUNTS primary key (NUMERO_EMPRUNT)
);

-- ============================================================
--   Table : ETATS
-- ============================================================
create table ETATS
(
    NUMERO_ETAT INT      not null,
    ETAT        CHAR(20) not null,
    constraint PK_ETATS primary key (NUMERO_ETAT)
);

-- ============================================================
--   Table : VILLES
-- ============================================================
create table VILLES
(
    NUMERO_VILLE INT       not null,
    NOM_VILLE    CHAR(255) not null,
    CODE_POSTAL  INT       not null,
    constraint PK_VILLES primary key (NUMERO_VILLE)
);

-- ============================================================
--   Table : SEPARER
-- ============================================================
create table SEPARER
(
    NUMERO_STATION_1 INT not null,
    NUMERO_STATION_2 INT not null,
    DISTANCE         DECIMAL(4, 2),
    constraint PK_VILLES primary key (NUMERO_STATION_1, NUMERO_STATION_2)
);

-- ============================================================
--   Clés étrangères
-- ============================================================

alter table VELOS
    add constraint FK_ETAT_VELO
        foreign key (NUMERO_ETAT)
            references ETATS (NUMERO_ETAT)
            on update cascade
            on delete cascade;

alter table VELOS
    add constraint FK_STATION_VELO
        foreign key (NUMERO_STATION)
            references STATIONS (NUMERO_STATION)
            on update cascade
            on delete cascade;

alter table STATIONS
    add constraint FK_VILLE_STATION
        foreign key (NUMERO_VILLE)
            references VILLES (NUMERO_VILLE)
            on update cascade
            on delete cascade;

alter table ADHERENTS
    add constraint FK_VILLE_ADHERENT
        foreign key (NUMERO_VILLE)
            references VILLES (NUMERO_VILLE)
            on update cascade
            on delete cascade;

alter table EMPRUNTS
    add constraint FK_VELO_EMPRUNT
        foreign key (NUMERO_VELO)
            references VELOS (NUMERO_VELO)
            on update cascade
            on delete cascade;

alter table EMPRUNTS
    add constraint FK_ADHERENT_EMPRUNT
        foreign key (NUMERO_ADHERENT)
            references ADHERENTS (NUMERO_ADHERENT)
            on update cascade
            on delete cascade;

alter table EMPRUNTS
    add constraint FK_STATION_DEPART_EMPRUNT
        foreign key (NUMERO_STATION_DEPART)
            references STATIONS (NUMERO_STATION)
            on update cascade
            on delete cascade;

alter table EMPRUNTS
    add constraint FK_STATION_ARRIVEE_EMPRUNT
        foreign key (NUMERO_STATION_ARRIVEE)
            references STATIONS (NUMERO_STATION)
            on update cascade
            on delete cascade;

alter table SEPARER
    add constraint FK_STATION_1_SEPARER
        foreign key (NUMERO_STATION_1)
            references STATIONS (NUMERO_STATION)
            on update cascade
            on delete cascade;

alter table SEPARER
    add constraint FK_STATION_2_SEPARER
        foreign key (NUMERO_STATION_2)
            references STATIONS (NUMERO_STATION)
            on update cascade
            on delete cascade;

-- ============================================================
--   Triggers
-- ============================================================

create trigger EMPRUNTS_INSERT_STARTING_TERMINAL
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_VELO = NEW.NUMERO_VELO
                and V.NUMERO_STATION != NEW.NUMERO_STATION_DEPART)
    then
        signal sqlstate '45000'
            set message_text = 'Starting terminals don''t match ';
    end if;
end;

create trigger EMPRUNTS_UPDATE_STARTING_TERMINAL
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_VELO = NEW.NUMERO_VELO
                and V.NUMERO_STATION != NEW.NUMERO_STATION_DEPART)
    then
        signal sqlstate '45000'
            set message_text = 'Starting terminals don''t match ';
    end if;
end;

create trigger VELOS_INSERT_BATTERY_CHECK
    before insert
    on VELOS
    for each row
begin
    if NEW.NIVEAU_CHARGE_BATTERIE > 100 or NEW.NIVEAU_CHARGE_BATTERIE < 0
    then
        signal sqlstate '45000'
            set message_text = 'Please insert a battery level between 0 and 100 inclusive';
    end if;
end;

create trigger VELOS_UPDATE_BATTERY_CHECK
    before update
    on VELOS
    for each row
begin
    if NEW.NIVEAU_CHARGE_BATTERIE > 100 or NEW.NIVEAU_CHARGE_BATTERIE < 0
    then
        signal sqlstate '45000'
            set message_text = 'Please insert a battery level between 0 and 100 inclusive';
    end if;
end;

create trigger STATIONS_INSERT_CHECK_BORNES
    before insert
    on STATIONS
    for each row
begin
    if NEW.NOMBRE_BORNES < 0
    then
        signal sqlstate '45000'
            set message_text = 'Please insert a positive number of terminal';
    end if;
end;

create trigger STATIONS_UPDATE_CHECK_BORNES
    before update
    on STATIONS
    for each row
begin
    if NEW.NOMBRE_BORNES < 0
    then
        signal sqlstate '45000'
            set message_text = 'Please insert a positive number of terminal';
    end if;
end;

create trigger EMPRUNTS_INSERT_CHECK_AVAILABLE
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_STATION is null
                and V.NUMERO_VELO = NEW.NUMERO_VELO)
    then
        signal sqlstate '45000'
            set message_text = 'The selected bike isn''t available for now.';
    end if;
end;
/*
create trigger EMPRUNTS_UPDATE_CHECK_AVAILABLE
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_STATION is null
                and V.NUMERO_VELO = NEW.NUMERO_VELO)
    then
        signal sqlstate '45000'
            set message_text = 'The selected bike isn''t available for now.';
    end if;
end;
*/
create trigger EMPRUNTS_INSERT_TAKE_BIKE
    before insert
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is null)
    then
        update VELOS set NUMERO_STATION = null where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end;

create trigger EMPRUNTS_UPDATE_TAKE_BIKE
    before update
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is null)
    then
        update VELOS set NUMERO_STATION = null where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end;

create trigger EMPRUNTS_INSERT_RELEASE_BIKE
    before insert
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is not null)
    then
        update VELOS set NUMERO_STATION = NEW.NUMERO_STATION_ARRIVEE where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end;

create trigger EMPRUNTS_UPDATE_RELEASE_BIKE
    before update
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is not null)
    then
        update VELOS set NUMERO_STATION = NEW.NUMERO_STATION_ARRIVEE where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end;

create trigger EMPRUNTS_INSERT_CHECK_HOURS
    before insert
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT < NEW.HEURE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'The deposit time must be later than the borrowing time';
    end if;
end;

create trigger EMPRUNTS_UPDATE_CHECK_HOURS
    before update
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT < NEW.HEURE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'The deposit time must be later than the borrowing time';
    end if;
end;

create trigger EMPRUNTS_INSERT_MATCHING_AVAILABILITY
    before insert
    on EMPRUNTS
    for each row
begin
    if ((NEW.HEURE_DEPOT is null and NEW.NUMERO_STATION_ARRIVEE is not null)
        or (NEW.HEURE_DEPOT is not null and NEW.NUMERO_STATION_ARRIVEE is null))
    then
        signal sqlstate '45000'
            set message_text = 'HEURE_DEPOT doesn''t match NUMERO_STATION_ARRIVEE';
    end if;
end;

create trigger EMPRUNTS_UPDATE_MATCHING_AVAILABILITY
    before update
    on EMPRUNTS
    for each row
begin
    if ((NEW.HEURE_DEPOT is null and NEW.NUMERO_STATION_ARRIVEE is not null)
        or (NEW.HEURE_DEPOT is not null and NEW.NUMERO_STATION_ARRIVEE is null))
    then
        signal sqlstate '45000'
            set message_text = 'HEURE_DEPOT doesn''t match NUMERO_STATION_ARRIVEE';
    end if;
end;

create trigger EMPRUNTS_INSERT_BETWEEN_TIMES
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.HEURE_EMPRUNT <= NEW.HEURE_EMPRUNT
                and NEW.HEURE_EMPRUNT <= E.HEURE_DEPOT
                and NEW.HEURE_DEPOT is not null)
    then
        signal sqlstate '45000'
            set message_text = 'Selected bike is already being used during this time frame.';
    end if;
end;

create trigger EMPRUNTS_UPDATE_BETWEEN_TIMES
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.HEURE_EMPRUNT <= NEW.HEURE_EMPRUNT
                and NEW.HEURE_EMPRUNT <= E.HEURE_DEPOT
                and NEW.HEURE_DEPOT is not null)
    then
        signal sqlstate '45000'
            set message_text = 'Selected bike is already being used during this time frame.';
    end if;
end;

create trigger STATIONS_UPDATE_BIKE_LIMIT
    before update
    on STATIONS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) > NEW.NOMBRE_BORNES)
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de vélos à la station dépasse la capacité disponible.';
    end if;
end;

create trigger VELOS_UPDATE_STATIONS_LIMIT
    before update
    on VELOS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) >
        (select NOMBRE_BORNES from STATIONS S where S.NUMERO_STATION = NEW.NUMERO_STATION))
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de vélos à la station dépasse la capacité disponible.';
    end if;
end;

create trigger VELOS_INSERT_STATIONS_LIMIT
    before insert
    on VELOS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) >
        (select NOMBRE_BORNES from STATIONS S where S.NUMERO_STATION = NEW.NUMERO_STATION))
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de vélos à la station dépasse la capacité disponible.';
    end if;
end;

create trigger SEPARER_UPDATE_DISTANCE_POSITIVE
    before update
    on SEPARER
    for each row
begin
    if (NEW.DISTANCE < 0)
    then
        signal sqlstate '45000'
            set message_text = 'La distance séparant deux stations doit être positive ou nulle.';
    end if;
end;

create trigger SEPARER_INSERT_DISTANCE_POSITIVE
    before insert
    on SEPARER
    for each row
begin
    if (NEW.DISTANCE < 0)
    then
        signal sqlstate '45000'
            set message_text = 'La distance séparant deux stations doit être positive ou nulle.';
    end if;
end;

create trigger EMPRUNTS_UPDATE_IS_USER_CREATED
    before update
    on EMPRUNTS
    for each row
begin
    if ((select A.DATE_INSCRIPTION from ADHERENTS A where A.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT) > NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date d\'inscription doit être antérieure à la date d\'emprunt';
    end if;
end;

create trigger EMPRUNTS_INSERT_IS_USER_CREATED
    before insert
    on EMPRUNTS
    for each row
begin
    if ((select A.DATE_INSCRIPTION from ADHERENTS A where A.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT) > NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date d\'inscription doit être antérieure à la date d\'emprunt';
    end if;
end;

create trigger ADHERENTS_UPDATE_CHECK_DATES
    before update
    on ADHERENTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT
                and E.DATE_EMPRUNT < NEW.DATE_INSCRIPTION)
    then
        signal sqlstate '45000'
            set message_text = 'La date d\'inscription doit être antérieure à la date d\'emprunt';
    end if;
end;

create trigger STATIONS_INSERT_CREATE_SEPARER_DISTANCE
    after insert
    on STATIONS
    for each row
begin
    insert into SEPARER values (NEW.NUMERO_STATION, NEW.NUMERO_STATION, 0);
end;

create trigger SEPARER_UPDATE_SAME_STATION
    before update
    on SEPARER
    for each row
begin
    if (OLD.NUMERO_STATION_1 = OLD.NUMERO_STATION_2)
    then
        signal sqlstate '45000'
            set message_text = 'Interdiction de modifier cette entrée.';
    end if;
end;

create trigger EMPRUNTS_DELETE_BIKE_IN_USE
    after delete
    on EMPRUNTS
    for each row
begin
    if (OLD.HEURE_DEPOT is null)
    then
        delete from VELOS where VELOS.NUMERO_VELO = OLD.NUMERO_VELO;
    end if;
end;

create trigger ETATS_DELETE_EXISTS_IN_VELOS
    before delete
    on ETATS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                  V.NUMERO_ETAT = OLD.NUMERO_ETAT)
    then
        signal sqlstate '45000'
            set message_text = 'L\'etat est toujours utilisé par un vélos.';
    end if;
end;

create trigger VILLES_DELETE_USED_ADHERENTS
    before delete
    on VILLES
    for each row
begin
    if exists(select * from ADHERENTS A where A.NUMERO_VILLE = OLD.NUMERO_VILLE)
    then
        signal sqlstate '45000'
            set message_text = 'La ville est toujours utilisée par un adhérent.';
    end if;
end;

create trigger VILLES_DELETE_USED_STATIONS
    before delete
    on VILLES
    for each row
begin
    if exists(select * from STATIONS S where S.NUMERO_VILLE = OLD.NUMERO_VILLE)
    then
        signal sqlstate '45000'
            set message_text = 'La ville est toujours utilisée par une station.';
    end if;
end;

create trigger EMPRUNTS_UPDATE_DATES_MISE_EN_SERVICE
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_VELO = NEW.NUMERO_VELO
                and V.DATE_MISE_EN_SERVICE > NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date de mise en service doit être antérieure à celle d\'emprunt';
    end if;
end;

create trigger EMPRUNTS_INSERT_DATES_MISE_EN_SERVICE
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  VELOS V
              where
                    V.NUMERO_VELO = NEW.NUMERO_VELO
                and V.DATE_MISE_EN_SERVICE > NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date de mise en service doit être antérieure à celle d\'emprunt';
    end if;
end;

create trigger VELOS_UPDATE_DATE_MISE_EN_SERVICE
    before update
    on VELOS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.NUMERO_VELO = NEW.NUMERO_VELO
                and E.DATE_EMPRUNT < NEW.DATE_MISE_EN_SERVICE)
    then
        signal sqlstate '45000'
            set message_text = 'La date de mise en service doit être antérieure à celle d\'emprunt';
    end if;
end;

-- TODO: procedures to prevent duplication between triggers
-- TODO: When deleting a terminal, don't delete previous borrow
-- TODO: Classement vélos par semaine

-- ============================================================
--   Utilisateur de la base de données
-- ============================================================

create user if not exists 'velo'@'localhost' identified by 'P@ssW0rd';
grant select, insert, update, delete on VELO.* to 'velo'@'localhost';
flush privileges;