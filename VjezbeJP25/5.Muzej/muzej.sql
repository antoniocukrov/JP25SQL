drop database if exists muzej;
create database muzej character set utf8;
use muzej;

# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\muzej.sql

create table izlozba (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    sponzor int,
    kustos int
);

create table sponzor (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    kapital decimal(18.2)
);

create table kustos (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    IBAN varchar(50),
    certificiran boolean
);

create table djelo (
    sifra int not null primary key auto_increment,
    ime varchar(50),
    umjetnik varchar(50),
    izlozba int,
    starost int
);

create table izlaganje (
    izlozba int,
    djelo int
);

alter table izlozba add foreign key (sponzor) references sponzor (sifra);
alter table izlozba add foreign key (kustos) references kustos (sifra);

alter table izlaganje add foreign key (izlozba) references izlozba (sifra);
alter table izlaganje add foreign key (djelo) references djelo (sifra);
