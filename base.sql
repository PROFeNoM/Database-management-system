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
    NUMERO_VELO            INT not null,
    REFERENCE              CHAR(42),
    DATE_MISE_EN_SERVICE   DATE,
    MARQUE                 CHAR(42),
    KILOMETRAGE            INT,
    NIVEAU_CHARGE_BATTERIE INT,
    NUMERO_ETAT            INT not null,
    NUMERO_STATION         INT,
    constraint PK_VELOS primary key (NUMERO_VELO)
);

-- ============================================================
--   Table : STATIONS
-- ============================================================
create table STATIONS
(
    NUMERO_STATION INT not null,
    NOMBRE_BORNES  INT not null,
    NUMERO_ADRESSE INT not null,
    constraint PK_STATIONS primary key (NUMERO_STATION)
);

-- ============================================================
--   Table : ADHERENTS
-- ============================================================
create table ADHERENTS
(
    NUMERO_ADHERENT INT      not null,
    NOM_ADHERENT    CHAR(42) not null,
    PRENOM_ADHERENT CHAR(42),
    NUMERO_ADRESSE  INT      not null,
    constraint PK_ADHERENTS primary key (NUMERO_ADHERENT)
);

-- ============================================================
--   Table : EMPRUNTS
-- ============================================================
create table EMPRUNTS
(
    NUMERO_EMPRUNT         INT  not null,
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
    ETAT        CHAR(10) not null,
    constraint PK_ETATS primary key (NUMERO_ETAT)
);

-- ============================================================
--   Table : ADRESSES
-- ============================================================
create table ADRESSES
(
    NUMERO_ADRESSE INT       not null,
    LIEU           CHAR(255) not null,
    NUMERO_COMMUNE INT       not null,
    constraint PK_ADRESSES primary key (NUMERO_ADRESSE)
);

-- ============================================================
--   Table : COMMUNES
-- ============================================================
create table COMMUNES
(
    NUMERO_INSEE INT       not null,
    NOM_COMMUNE  CHAR(255) not null,
    CODE_POSTAL  INT       not null,
    constraint PK_COMMUNES primary key (NUMERO_INSEE)
);

-- ============================================================
--   Table : SEPARER
-- ============================================================
create table SEPARER
(
    NUMERO_STATION_1 INT not null,
    NUMERO_STATION_2 INT not null,
    DISTANCE         INT,
    constraint PK_COMMUNES primary key (NUMERO_STATION_1, NUMERO_STATION_2)
);

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
    add constraint FK_ADRESSE_STATION
        foreign key (NUMERO_ADRESSE)
            references ADRESSES (NUMERO_ADRESSE)
            on update cascade
            on delete cascade;

alter table ADHERENTS
    add constraint FK_ADRESSE_ADHERENT
        foreign key (NUMERO_ADRESSE)
            references ADRESSES (NUMERO_ADRESSE)
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

alter table ADRESSES
    add constraint FK_COMMUNE_ADRESSE
        foreign key (NUMERO_COMMUNE)
            references COMMUNES (NUMERO_INSEE)
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