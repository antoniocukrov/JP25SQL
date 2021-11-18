drop database if exists vrtic;
create database vrtic character set utf8;
use vrtic;

# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\vrtic.sql

create table skupina(
   sifra int not null primary key auto_increment,
   ime varchar(50) not null,
   logo varchar(50) null,
   teta int not null
);

create table dijete(
    sifra int not null primary key auto_increment,
    ime varchar(50),
    starost int
);

create table teta(
    sifra int not null primary key auto_increment,
    ime varchar(50),
    strucnasprema int   
);

create table strucnasprema (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    certificiran boolean
);

create table clan (
    skupina int,
    dijete int
);

alter table skupina add foreign key (teta) references teta(sifra);

alter table teta add foreign key (strucnasprema) references strucnasprema(sifra);

alter table clan add foreign key (skupina) references skupina(sifra);
alter table clan add foreign key (dijete) references dijete(sifra);