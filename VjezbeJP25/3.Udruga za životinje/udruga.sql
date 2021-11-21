drop database if exists udruga;
create database udruga character set utf8;
use udruga;

# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\3.Udruga za životinje\udruga.sql"

create table osoba(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    placa decimal(18.2)
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

insert into prostor(sifra,ime,bojazidova) values 
(null, 'Prostorija A', 'Plava'),
(null, 'Prostorija B', 'Žuta'),
(null, 'Prostorija C', 'Crvena');

insert into osoba(sifra,ime,placa) values
(null, 'Marko', 4000),
(null, 'Luka', 4000),
(null, 'Pero', 4500),
(null, 'Josip', 4700);

insert into zivotinja(sifra,ime,prostor) values
(null, 'Crypto', 1),
(null, 'Penny', 2),
(null, 'Aron', 3);

