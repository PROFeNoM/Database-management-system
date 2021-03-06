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
    NUMERO_ETAT INT      not null auto_increment,
    ETAT        CHAR(20) not null,
    constraint PK_ETATS primary key (NUMERO_ETAT)
);

-- ============================================================
--   Table : VILLES
-- ============================================================
create table VILLES
(
    NUMERO_VILLE INT       not null auto_increment,
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
--   Cl??s ??trang??res
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
            on update cascade;

alter table EMPRUNTS
    add constraint FK_STATION_ARRIVEE_EMPRUNT
        foreign key (NUMERO_STATION_ARRIVEE)
            references STATIONS (NUMERO_STATION)
            on update cascade;

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


delimiter //
create trigger EMPRUNTS_INSERT_CHECK_TERMINAL_SUCCESSION
    before insert
    on EMPRUNTS
    for each row
begin
    -- If there's a borrow before the new record, check if the new record's starting point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = NEW.NUMERO_VELO
                 and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                     cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                 and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT)
        and (select
                 E.NUMERO_STATION_ARRIVEE
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = NEW.NUMERO_VELO
               and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                   cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
               and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) desc
             limit 1) != NEW.NUMERO_STATION_DEPART)
    then
        signal sqlstate '45000'
            set message_text = 'La station de d??part du v??lo est diff??rente de celle o?? il est';
    end if;

    -- If there's a borrow after the new record, check if the new record's ending point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = NEW.NUMERO_VELO
                 and cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME) <=
                     cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
                 and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
            )
        and (select
                 E.NUMERO_STATION_DEPART
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = NEW.NUMERO_VELO
               and cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME) <=
                   cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
               and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) asc
             limit 1) != NEW.NUMERO_STATION_ARRIVEE)
    then
        signal sqlstate '45000'
            set message_text = 'La station d\'arriv??e du v??lo est diff??rente de celle du prochain emprunt';
    end if;
end //

delimiter //
create trigger EMPRUNTS_DELETE_CHECK_TERMINAL_SUCCESSION
    before delete
    on EMPRUNTS
    for each row
begin
    -- If there's a borrow before the deleted record, check if the next record's starting point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = OLD.NUMERO_VELO
                 and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                     cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME)
                 and OLD.NUMERO_EMPRUNT != E.NUMERO_EMPRUNT)
        and exists(select *
                   from
                       EMPRUNTS E
                   where
                         E.NUMERO_VELO = OLD.NUMERO_VELO
                     and cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME) <=
                         cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
                     and OLD.NUMERO_EMPRUNT != E.NUMERO_EMPRUNT)
        and (select
                 E.NUMERO_STATION_ARRIVEE
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = OLD.NUMERO_VELO
               and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                   cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME)
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) desc
             limit 1) != OLD.NUMERO_STATION_ARRIVEE)
    then
        signal sqlstate '45000'
            set message_text = 'La station de d??part du v??lo est diff??rente de celle d\'emprunt';
    end if;

    -- If there's a borrow after the delete record, check if the record's ending point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = OLD.NUMERO_VELO
                 and cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME) <=
                     cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
                 and E.NUMERO_EMPRUNT != OLD.NUMERO_EMPRUNT
            )
        and exists(select *
                   from
                       EMPRUNTS E
                   where
                         E.NUMERO_VELO = OLD.NUMERO_VELO
                     and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                         cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME)
                     and E.NUMERO_EMPRUNT != OLD.NUMERO_EMPRUNT
            )
        and (select
                 E.NUMERO_STATION_DEPART
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = OLD.NUMERO_VELO
               and cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME) <=
                   cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
               and E.NUMERO_EMPRUNT != OLD.NUMERO_EMPRUNT
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) asc
             limit 1) != OLD.NUMERO_STATION_DEPART)
    then
        signal sqlstate '45000'
            set message_text = 'La succession des stations du v??lo serait incoh??rente.';
    end if;

    if (not exists(select *
                   from
                       EMPRUNTS E
                   where
                         E.NUMERO_VELO = OLD.NUMERO_VELO
                     and cast(concat(OLD.DATE_EMPRUNT, ' ', OLD.HEURE_EMPRUNT) as DATETIME) <=
                         cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
                     and E.NUMERO_EMPRUNT != OLD.NUMERO_EMPRUNT
        ) and (select V.NUMERO_STATION from VELOS V where V.NUMERO_VELO = OLD.NUMERO_VELO) is not null)
    then
        update VELOS set NUMERO_STATION = OLD.NUMERO_STATION_DEPART where VELOS.NUMERO_VELO = OLD.NUMERO_VELO;
    end if;
end //

delimiter //


create trigger EMPRUNTS_UPDATE_CHECK_TERMINAL_SUCCESSION
    before update
    on EMPRUNTS
    for each row
begin
    -- If there's a borrow before the new record, check if the new record's starting point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = NEW.NUMERO_VELO
                 and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                     cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                 and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT)
        and (select
                 E.NUMERO_STATION_ARRIVEE
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = NEW.NUMERO_VELO
               and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) <=
                   cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
               and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) desc
             limit 1) != NEW.NUMERO_STATION_DEPART)
    then
        signal sqlstate '45000'
            set message_text = 'La station de d??part du v??lo est diff??rente de celle o?? il est';
    end if;

    -- If there's a borrow after the new record, check if the new record's ending point is ok
    if (exists(select *
               from
                   EMPRUNTS E
               where
                     E.NUMERO_VELO = NEW.NUMERO_VELO
                 and cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME) <=
                     cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
                 and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
            )
        and (select
                 E.NUMERO_STATION_DEPART
             from
                 EMPRUNTS E
             where
                   E.NUMERO_VELO = NEW.NUMERO_VELO
               and cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME) <=
                   cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME)
               and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
             order by
                 cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) asc
             limit 1) != NEW.NUMERO_STATION_ARRIVEE)
    then
        signal sqlstate '45000'
            set message_text = 'La station d\'arriv??e du v??lo est diff??rente de celle du prochain emprunt';
    end if;
end //


delimiter //
create trigger VELOS_INSERT_BATTERY_CHECK
    before insert
    on VELOS
    for each row
begin
    if NEW.NIVEAU_CHARGE_BATTERIE > 100 or NEW.NIVEAU_CHARGE_BATTERIE < 0
    then
        signal sqlstate '45000'
            set message_text = 'Le niveau de charge de la batterie doit ??tre en 0 et 100.';
    end if;
end //

delimiter //
create trigger VELOS_UPDATE_BATTERY_CHECK
    before update
    on VELOS
    for each row
begin
    if NEW.NIVEAU_CHARGE_BATTERIE > 100 or NEW.NIVEAU_CHARGE_BATTERIE < 0
    then
        signal sqlstate '45000'
            set message_text = 'Le niveau de charge de la batterie doit ??tre en 0 et 100.';
    end if;
end //

delimiter //
create trigger STATIONS_INSERT_CHECK_BORNES
    before insert
    on STATIONS
    for each row
begin
    if NEW.NOMBRE_BORNES < 0
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de bornes doit ??tre positif.';
    end if;
end //

delimiter //
create trigger STATIONS_UPDATE_CHECK_BORNES
    before update
    on STATIONS
    for each row
begin
    if NEW.NOMBRE_BORNES < 0
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de bornes doit ??tre positif';
    end if;
end //

delimiter //
create trigger VELOS_UPDATE_CHECK_AVAILABLE
    before update
    on VELOS
    for each row
begin
    if (OLD.NUMERO_STATION is null and (select
                                            E.NUMERO_STATION_ARRIVEE
                                        from
                                            EMPRUNTS E
                                        where
                                            E.NUMERO_VELO = NEW.NUMERO_VELO
                                        order by
                                            cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME) desc
                                        limit 1) is null)
    then
        signal sqlstate '45000'
            set message_text = 'Merci de faire la modification de la station ?? partir de EMPRUNTS ';
    end if;
end //

delimiter //
create trigger VELOS_UPDATE_CHECK_AVAILABLE2
    after update
    on VELOS
    for each row
begin
    if (OLD.NUMERO_STATION is not null and NEW.NUMERO_STATION is null and not exists(
            select * from EMPRUNTS E where E.NUMERO_VELO = NEW.NUMERO_VELO and E.HEURE_DEPOT is null
        ))
    then
        signal sqlstate '45000'
            set message_text = 'Merci de faire la modification ?? partir de EMPRUNTS';
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_TAKE_BIKE
    after insert
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is null and (select NUMERO_STATION from VELOS where NUMERO_VELO = NEW.NUMERO_VELO) is not null)
    then
        update VELOS set NUMERO_STATION = null where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_TAKE_BIKE
    after update
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is null and (OLD.HEURE_DEPOT is not null or NEW.NUMERO_VELO != OLD.NUMERO_VELO))
    then
        update VELOS set NUMERO_STATION = null where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_RELEASE_BIKE
    after insert
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is not null and (select
                                             NUMERO_EMPRUNT
                                         from
                                             EMPRUNTS E
                                         order by
                                             cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) desc
                                         limit 1) = NEW.NUMERO_EMPRUNT)
    then
        update VELOS set NUMERO_STATION = NEW.NUMERO_STATION_ARRIVEE where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_RELEASE_BIKE
    after update
    on EMPRUNTS
    for each row
begin
    if (NEW.HEURE_DEPOT is not null and (select
                                             NUMERO_EMPRUNT
                                         from
                                             EMPRUNTS E
                                         order by cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) desc
                                         limit 1) = NEW.NUMERO_EMPRUNT)
    then
        update VELOS set NUMERO_STATION = NEW.NUMERO_STATION_ARRIVEE where NUMERO_VELO = NEW.NUMERO_VELO;
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_CHECK_HOURS
    before insert
    on EMPRUNTS
    for each row
begin
    if ((NEW.DATE_DEPOT < NEW.DATE_EMPRUNT) or
        (NEW.HEURE_DEPOT < NEW.HEURE_EMPRUNT and NEW.DATE_EMPRUNT = NEW.DATE_DEPOT))
    then
        signal sqlstate '45000'
            set message_text = 'Le d??p??t doit s\'effectuer apr??s l\'emprunt';
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_CHECK_HOURS
    before update
    on EMPRUNTS
    for each row
begin
    if ((NEW.DATE_DEPOT < NEW.DATE_EMPRUNT) or
        (NEW.HEURE_DEPOT < NEW.HEURE_EMPRUNT and NEW.DATE_EMPRUNT = NEW.DATE_DEPOT))
    then
        signal sqlstate '45000'
            set message_text = 'Le d??p??t doit s\'effectuer apr??s l\'emprunt';
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_MATCHING_AVAILABILITY
    before insert
    on EMPRUNTS
    for each row
begin
    if ((NEW.HEURE_DEPOT is null and not (NEW.NUMERO_STATION_ARRIVEE is null and NEW.DATE_DEPOT is null))
        or (NEW.DATE_DEPOT is null and not (NEW.NUMERO_STATION_ARRIVEE is null and NEW.HEURE_DEPOT is null))
        or (NEW.NUMERO_STATION_ARRIVEE is null and not (NEW.HEURE_DEPOT is null and NEW.DATE_DEPOT is null)))
    then
        signal sqlstate '45000'
            set message_text = 'HEURE_DEPOT, NUMERO_STATION_ARRIVEE and DATE_DEPOT don\'t match';
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_MATCHING_AVAILABILITY
    before update
    on EMPRUNTS
    for each row
begin
    if ((NEW.HEURE_DEPOT is null and not (NEW.NUMERO_STATION_ARRIVEE is null and NEW.DATE_DEPOT is null))
        or (NEW.DATE_DEPOT is null and not (NEW.NUMERO_STATION_ARRIVEE is null and NEW.HEURE_DEPOT is null))
        or (NEW.NUMERO_STATION_ARRIVEE is null and not (NEW.HEURE_DEPOT is null and NEW.DATE_DEPOT is null)))
    then
        signal sqlstate '45000'
            set message_text = 'HEURE_DEPOT, NUMERO_STATION_ARRIVEE and DATE_DEPOT don\'t match';
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_BETWEEN_TIMES
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    NEW.NUMERO_VELO = E.NUMERO_VELO
                and ((E.HEURE_DEPOT is null and (
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                           <= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME)
                          and NEW.HEURE_DEPOT is null)
                      or
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                      or
                      (cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                  )) or (E.HEURE_DEPOT is not null and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) >=
                                                       cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                  and (NEW.HEURE_DEPOT is null or cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME) <=
                                                  cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME))))
        )
    then
        signal sqlstate '45000'
            set message_text = 'Le v??lo s??lectionn?? n\'est pas disponible durant cette p??riode';
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_BETWEEN_TIMES
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    NEW.NUMERO_VELO = E.NUMERO_VELO
                and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
                and ((E.HEURE_DEPOT is null and (
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                           <= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME)
                          and NEW.HEURE_DEPOT is null)
                      or
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                      or
                      (cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                  )) or (E.HEURE_DEPOT is not null and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) >=
                                                       cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                  and (NEW.HEURE_DEPOT is null or cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME) <=
                                                  cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME))))
        )
    then
        signal sqlstate '45000'
            set message_text = 'Le v??lo s??lectionn?? n\'est pas disponible durant cette p??riode';
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_CHECK_USER_AVAILABILITY
    before insert
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT
                and ((E.HEURE_DEPOT is null and (
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                           <= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME)
                          and NEW.HEURE_DEPOT is null)
                      or
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                      or
                      (cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                  )) or (E.HEURE_DEPOT is not null and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) >=
                                                       cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                  and (NEW.HEURE_DEPOT is null or cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME) <=
                                                  cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME))))
        )
    then
        signal sqlstate '45000'
            set message_text = 'L\'adh??rent s??lectionn?? n\'est pas disponible durant cette p??riode';
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_CHECK_USER_AVAILABILITY
    before update
    on EMPRUNTS
    for each row
begin
    if exists(select *
              from
                  EMPRUNTS E
              where
                    E.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT
                and E.NUMERO_EMPRUNT != NEW.NUMERO_EMPRUNT
                and ((E.HEURE_DEPOT is null and (
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                           <= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME)
                          and NEW.HEURE_DEPOT is null)
                      or
                      (cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                      or
                      (cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME)
                          >= cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME))
                  )) or (E.HEURE_DEPOT is not null and cast(concat(E.DATE_DEPOT, ' ', E.HEURE_DEPOT) as DATETIME) >=
                                                       cast(concat(NEW.DATE_EMPRUNT, ' ', NEW.HEURE_EMPRUNT) as DATETIME)
                  and (NEW.HEURE_DEPOT is null or cast(concat(E.DATE_EMPRUNT, ' ', E.HEURE_EMPRUNT) as DATETIME) <=
                                                  cast(concat(NEW.DATE_DEPOT, ' ', NEW.HEURE_DEPOT) as DATETIME))))
        )
    then
        signal sqlstate '45000'
            set message_text = 'L\'adh??rent s??lectionn?? n\'est pas disponible durant cette p??riode';
    end if;
end //

delimiter //
create trigger STATIONS_UPDATE_BIKE_LIMIT
    before update
    on STATIONS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) > NEW.NOMBRE_BORNES)
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de v??los ?? la station d??passe la capacit?? disponible.';
    end if;
end //

delimiter //
create trigger VELOS_UPDATE_STATIONS_LIMIT
    before update
    on VELOS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) + 1 >
        (select NOMBRE_BORNES from STATIONS S where S.NUMERO_STATION = NEW.NUMERO_STATION))
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de v??los ?? la station d??passe la capacit?? disponible.';
    end if;
end //

delimiter //
create trigger VELOS_INSERT_STATIONS_LIMIT
    before insert
    on VELOS
    for each row
begin
    if ((select count(*) from VELOS V where V.NUMERO_STATION = NEW.NUMERO_STATION) + 1 >
        (select NOMBRE_BORNES from STATIONS S where S.NUMERO_STATION = NEW.NUMERO_STATION))
    then
        signal sqlstate '45000'
            set message_text = 'Le nombre de v??los ?? la station d??passe la capacit?? disponible.';
    end if;
end //

delimiter //
create trigger SEPARER_UPDATE_DISTANCE_POSITIVE
    before update
    on SEPARER
    for each row
begin
    if (NEW.DISTANCE < 0)
    then
        signal sqlstate '45000'
            set message_text = 'La distance s??parant deux stations doit ??tre positive ou nulle.';
    end if;
end //

delimiter //
create trigger SEPARER_INSERT_DISTANCE_POSITIVE
    before insert
    on SEPARER
    for each row
begin
    if (NEW.DISTANCE < 0)
    then
        signal sqlstate '45000'
            set message_text = 'La distance s??parant deux stations doit ??tre positive ou nulle.';
    end if;
end //

delimiter //
create trigger EMPRUNTS_UPDATE_IS_USER_CREATED
    before update
    on EMPRUNTS
    for each row
begin
    if ((select A.DATE_INSCRIPTION from ADHERENTS A where A.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT) >
        NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date d\'inscription doit ??tre ant??rieure ?? la date d\'emprunt';
    end if;
end //

delimiter //
create trigger EMPRUNTS_INSERT_IS_USER_CREATED
    before insert
    on EMPRUNTS
    for each row
begin
    if ((select A.DATE_INSCRIPTION from ADHERENTS A where A.NUMERO_ADHERENT = NEW.NUMERO_ADHERENT) >
        NEW.DATE_EMPRUNT)
    then
        signal sqlstate '45000'
            set message_text = 'La date d\'inscription doit ??tre ant??rieure ?? la date d\'emprunt';
    end if;
end //

delimiter //
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
            set message_text = 'La date d\'inscription doit ??tre ant??rieure ?? la date d\'emprunt';
    end if;
end //

delimiter //
create trigger STATIONS_INSERT_CREATE_SEPARER_DISTANCE
    after insert
    on STATIONS
    for each row
begin
    insert into SEPARER values (NEW.NUMERO_STATION, NEW.NUMERO_STATION, 0);
end //

delimiter //
create trigger SEPARER_UPDATE_SAME_STATION
    before update
    on SEPARER
    for each row
begin
    if (OLD.NUMERO_STATION_1 = OLD.NUMERO_STATION_2)
    then
        signal sqlstate '45000'
            set message_text = 'Interdiction de modifier cette entr??e. La distance doit rester 0.';
    end if;
end //

delimiter //
create trigger SEPARER_DELETE_SAME_STATION
    before delete
    on SEPARER
    for each row
begin
    if (OLD.NUMERO_STATION_1 = OLD.NUMERO_STATION_2)
    then
        signal sqlstate '45000'
            set message_text = 'Interdiction de supprimer cette entr??e. La distance doit rester 0.';
    end if;
end //

delimiter //
create trigger EMPRUNTS_DELETE_BIKE_IN_USE
    after delete
    on EMPRUNTS
    for each row
begin
    if (OLD.HEURE_DEPOT is null)
    then
        delete from VELOS where VELOS.NUMERO_VELO = OLD.NUMERO_VELO;
    end if;
end //

delimiter //
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
            set message_text = 'L\'etat est toujours utilis?? par un v??los.';
    end if;
end //

delimiter //
create trigger VILLES_DELETE_USED_ADHERENTS
    before delete
    on VILLES
    for each row
begin
    if exists(select * from ADHERENTS A where A.NUMERO_VILLE = OLD.NUMERO_VILLE)
    then
        signal sqlstate '45000'
            set message_text = 'La ville est toujours utilis??e par un adh??rent.';
    end if;
end //

delimiter //
create trigger VILLES_DELETE_USED_STATIONS
    before delete
    on VILLES
    for each row
begin
    if exists(select * from STATIONS S where S.NUMERO_VILLE = OLD.NUMERO_VILLE)
    then
        signal sqlstate '45000'
            set message_text = 'La ville est toujours utilis??e par une station.';
    end if;
end //

delimiter //
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
            set message_text = 'La date de mise en service doit ??tre ant??rieure ?? celle d\'emprunt';
    end if;
end //

delimiter //
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
            set message_text = 'La date de mise en service doit ??tre ant??rieure ?? celle d\'emprunt';
    end if;
end //

delimiter //
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
            set message_text = 'La date de mise en service doit ??tre ant??rieure ?? celle d\'emprunt';
    end if;
end //

-- TODO: procedures to prevent duplication between triggers
-- TODO: There's an issue (can't be solved) with kilometrageVelosParSemaine.sql where km = 0 when a VELOS goes from one STATIONS to the same one

