drop database if exists samostan;
create database samostan character set utf8;
use samostan;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\6.Samostan\samostan2.sql"

create table svecenik(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    archsvecenik int not null
);

create table archsvecenik(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    placa decimal(18.2)
);

create table posao(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    tezinaobavljanja varchar(50) null,
    brojradnika int
);

create table rad(
    svecenik int,
    posao int
);

alter table svecenik add foreign key (archsvecenik) references archsvecenik(sifra);

alter table rad add foreign key (svecenik) references svecenik(sifra);
alter table rad add foreign key (posao) references posao(sifra);