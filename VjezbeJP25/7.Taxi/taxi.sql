drop database if exists taxi;
create database taxi character set utf8;
use taxi;

# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\7.Taxi\taxi.sql"

create table vozilo(
sifra int primary key not null auto_increment,
model varchar(50) not null,
kilometraza varchar(50) not null,
brojvozila varchar(50)not null
);

create table putnik(
    sifra int primary key not null auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    nacinplacanja varchar(50)
);

create table vozac(
    sifra int primary key not null auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    sluzbenibroj varchar(50) not null 
);

create table voznja(
    vozilo int not null,
    putnik int not null,
    vozac int not null
);

alter table voznja add foreign key (putnik) references putnik(sifra);
alter table voznja add foreign key (vozilo) references vozilo(sifra);
alter table voznja add foreign key (vozac) references vozac(sifra);

insert into vozilo(sifra,model,kilometraza,brojvozila)values
(null,'Škoda Octavia','130456',13),
(null,'Škoda Octavia','130456',14),
(null,'Škoda Octavia','130456',15),
(null,'Škoda Octavia','130456',16),
(null,'Škoda Octavia','130456',17);

insert into putnik(sifra,ime,prezime,nacinplacanja)values
(null,'Marta','Ivanušić','Gotovina'),
(null,'Marina','Kuren','Gotovina'),
(null,'Margareta','Ostavić','Gotovina'),
(null,'Ana','Maret','Gotovina'),
(null,'Eugen','Streni','Kartica');

insert into vozac(sifra,ime,prezime,sluzbenibroj)values
(null,'Branko','Marić',26),
(null,'Julije','Cezarević',27),
(null,'Mario','Sreća',28),
(null,'Marijo','Nesreća',29),
(null,'Branko','Marić',30);

insert into voznja(vozilo,putnik,vozac)values
(1,3,4),
(2,1,3),
(3,2,5),
(4,5,1),
(5,4,2);