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
    NUMERO_ADHERENT INT       not null auto_increment,
    NOM_ADHERENT    CHAR(42)  not null,
    PRENOM_ADHERENT CHAR(42),
    ADRESSE         CHAR(255) not null,
    NUMERO_VILLE    INT       not null,
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
    DISTANCE         DECIMAL(4, 1),
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

-- TODO: use procedure to prevent duplication
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

create trigger STATIONS_UPDATE_CHECK_BORNES
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

-- TODO: Trigger checking if a bike is available when inserting in EMPRUNTS
-- TODO: Trigger changing bike's NUMERO_STATION to null when EMPRUNTS.HEURE_DEPOT is null for the corresponding bike
-- TODO: Trigger checking that HEURE_DEPOT > HEURE_EMPRUNT
-- TODO: kilometrageParVelo.sql
-- TODO: procedures to prevent duplication between triggers

-- ============================================================
--   Utilisateur de la base de données
-- ============================================================

create user if not exists 'velo'@'localhost' identified by 'P@ssW0rd';
grant select, insert, update, delete on VELO.* to 'velo'@'localhost';
flush privileges;