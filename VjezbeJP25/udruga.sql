drop database if exists udruga;
create database udruga character set utf8;
use udruga;

# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\udruga.sql

create table osoba(
    sifra int not null primary key auto_increment,
    prostor int not null,
    ime varchar(50) not null
);

create table zivotinja(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prostor int not null
);

create table prostor(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    bojazidova varchar(50) null
);

create table sticenik(
    osoba int,
    zivotinja int
);

alter table sticenik add foreign key (osoba) references osoba(sifra);
alter table sticenik add foreign key (zivotinja) references zivotinja(sifra);

alter table zivotinja add foreign key (prostor) references prostor(sifra);



