drop database if exists samostan;
create database samostan character set utf8;
use samostan;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\6.Samostan\samostan2.sql"

create table nadredjeni(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    titula varchar(50) not null
);

create table posao(
    sifra int not null primary key auto_increment,
    vrsta varchar(50),
    naziv varchar(50)
);

create table svecenik(
    ime varchar(50),
    prezime varchar(50),
    nadredjeni int not null,
    posao int not null

);

alter table svecenik add foreign key (nadredjeni) references nadredjeni(sifra);
alter table svecenik add foreign key (posao) references posao(sifra);


insert into nadredjeni(sifra,ime,prezime,titula)values
(null,'Branko','Jurišić','nadbiskup'),
(null,'Tomislav','Ilić','guardian');

insert into posao(sifra,vrsta,naziv)values
(null,'čišćenje','pranje podova'),
(null,'spremanje','spremanje kreveta');

insert into svecenik(ime,prezime,nadredjeni,posao)values
('Dragan','Marić',1,2),
('Petar','Korin',2,1);