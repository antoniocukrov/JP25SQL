drop database if exists FOP1;
create database FOP1 character set utf8;
use FOP1;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\kolokvij_FOP\kolokvij_FOP_1.sql"
 
create table muskarac (
    id int(11) not null primary key auto_increment,
    maraka decimal(17,7) not null,
    hlace varchar(45) NOT NULL,
    prstena int(11) not null,
    nausnica int(11),
    neprijateljica int(11) not NULL
);

create table sestra (
    id int(11) not null primary key auto_increment,
    introvertno boolean not null,
    carape varchar(41),
    suknja varchar(40),
    narukvica int(11) not null
);

create table neprijateljica (
id int(11) not null,
indiferentno boolean not null,
modelnaocala varchar(39) not null,
maraka decimal(12,10) not null,
kratkamajica varchar(32) not null,
ogrlica int(11)
);

create table punac (
    id int(11) not null primary key auto_increment,
    modelnaocala varchar(39),
    treciputa datetime,
    drugiputa datetime,
    novcica decimal(14,6) not null,
    narukvica int(11)
);

create table zarucnica (
    id int(11) not null primary key auto_increment,
    stilfrizura varchar(40),
    prstena int(11) not null,
    gustoca decimal(14,5),
    modelnaocala varchar(35) not null,
    nausnica int(11) not null    
);