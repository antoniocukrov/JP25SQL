drop database if exists trgovina;
create database trgovina character set utf8;
use trgovina;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\Sell&Count\trgovina.sql"

create table artikl(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    EANkod int not null,
    cijena decimal(18.2),
    zaliha decimal(18.2) not null,
    klasifikacija int null,
    JM int not null,
    blagajnik int null
);

create table prodaja(
    sifra int not null primary key auto_increment,
    racun int not null,
    artikl int not null,
    kolicina decimal(18.2) not null,
    cijena decimal(18.2) null
);

create table blagajnik(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    lozinka varchar(50) not null
);

create table racun(
    sifra int not null primary key auto_increment,
    kupac int not null,
    cijena decimal(18.2) not null,
    tipplacanja varchar(50) null,
    vrijeme datetime null,
    blagajnik int null
);

create table primka(
    sifra int not null primary key auto_increment,
    artikl int not null,
    kolicina decimal(18.2) not null,
    vrijeme datetime null,
    dobavljac int not null,
    blagajnik int not null
);

create table narudzba(
    sifra int not null primary key auto_increment,
    artikl int not null,
    kolicina decimal(18.2) not null,
    cijena decimal(18.2) not null,
    vrijeme datetime not null

);

create table kupac(
    sifra int not null primary key auto_increment,
    oib varchar(11) not null,
    naziv varchar(50) not null,
    brojtelefona varchar(50) null
);

create table dobavljac(
    sifra int not null primary key auto_increment,
    oib varchar(11) not null,
    naziv varchar(50) not null,
    email varchar(50)
);

create table klasifikacija(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null
);

create table JM(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null
);

create table ima(
    dobavljac int,
    narudzba int
);

create table odraduje(
    blagajnik int,
    narudzba int
);

alter table artikl add foreign key (klasifikacija) references klasifikacija(sifra);
alter table artikl add foreign key (JM) references JM(sifra);
alter table artikl add foreign key (blagajnik) references blagajnik(sifra);

alter table prodaja add foreign key (racun) references racun(sifra);
alter table prodaja add foreign key (artikl) references artikl(sifra);

alter table racun add foreign key (kupac) references kupac(sifra);
alter table racun add foreign key (blagajnik) references blagajnik(sifra);

alter table primka add foreign key (artikl) references artikl(sifra);
alter table primka add foreign key (dobavljac) references dobavljac(sifra);
alter table primka add foreign key (blagajnik) references blagajnik(sifra);

alter table narudzba add foreign key (artikl) references artikl(sifra);

alter table ima add foreign key (dobavljac) references dobavljac(sifra);
alter table ima add foreign key (narudzba) references narudzba(sifra);

alter table odraduje add foreign key (blagajnik) references blagajnik(sifra);
alter table odraduje add foreign key (narudzba) references narudzba(sifra);

#insert u JM

insert into JM(sifra,naziv) values
(null,'kg'),
(null,'L'),
(null,'KOM'),
(null,'m2');


