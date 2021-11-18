drop database if exists frizerski;
create database frizerski character set utf8;
use frizerski;

# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\1.Frizerski salon\frizerski.sql

create table djelatnica(
    sifra int not null primary key auto_increment,
    osoba int not null,
    placa decimal(18,2) null,
    usluga int not null,
    posjet int
);

create table korisnik(
    sifra int not null primary key auto_increment,
    osoba int not null,
    vrijeme datetime null,
    usluga int not null
);

create table usluga(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    trajanje int null,
    cijena decimal(18,2) not null
);

create table posjet(
    sifra int not null primary key auto_increment,
    korisnik int not null,
    usluga int not null  
);

create table osoba(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    oib char(11)
);



alter table posjet add foreign key (korisnik) references korisnik(sifra);
alter table posjet add foreign key (usluga) references usluga(sifra);

alter table djelatnica add foreign key (posjet) references posjet(sifra);

alter table djelatnica add foreign key (osoba) references osoba(sifra);
alter table korisnik add foreign key (osoba) references osoba(sifra);
