drop database if exists frizerski;
create database frizerski character set utf8;
use frizerski;

# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\VjezbeJP25\1.Frizerski salon\frizerski.sql"

create table djelatnica(
    sifra int not null primary key auto_increment,
    osoba int not null,
    placa decimal(18,2) null
);

create table korisnik(
    sifra int not null primary key auto_increment,
    osoba int not null,
    vrijeme datetime null
);

create table usluga(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    cijena decimal(18,2) not null
);

create table posjet(
    sifra int not null primary key auto_increment,
    djelatnica int not null,
    korisnik int not null,
    usluga int not null  
);

create table osoba(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    oib char(11)
);


alter table posjet add foreign key (djelatnica) references djelatnica(sifra);
alter table posjet add foreign key (korisnik) references korisnik(sifra);
alter table posjet add foreign key (usluga) references usluga(sifra);

alter table djelatnica add foreign key (osoba) references osoba(sifra);
alter table korisnik add foreign key (osoba) references osoba(sifra);

insert into osoba (sifra,ime,prezime,oib) values
(null, 'Legica', 'Petrović', 17667036992),
(null, 'Ivana', 'Tomeš',63671582930),
(null, 'Anamarija','Gudelj',00184169683),
(null, 'Pero','Djetlić',98157277116),
(null, 'Tarzan','Ciganović',94380282314),
(null, 'Sinan','Sakić',53383186859);

insert into djelatnica (sifra,osoba,placa) values
(null,1,5000),
(null,2,4500),
(null,3,3000);

insert into korisnik (sifra,osoba,vrijeme) values
(null,4,"2021-11-21 13:30:30"),
(null,5,"2021-11-21 13:30:30"),
(null,6,"2021-11-21 14:30:30");

insert into usluga (sifra,naziv,cijena) values
(null, 'Šišanje', 40),
(null, 'Pranje', 20),
(null, 'Farbanje', 100);

insert into posjet (sifra, djelatnica, korisnik, usluga) values
(null,1,1,1),
(null,2,2,2),
(null,1,3,1);