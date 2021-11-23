drop database if exists trgovina;
create database trgovina character set utf8;
use trgovina;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\Sell&Count\trgovina.sql"

create table artikl(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    EANkod varchar(50) not null,
    cijena decimal(18.2),    
    JM int not null,
    klasifikacija int null
);

create table djelatnik(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    lozinka varchar(50) not null
);

create table primka(
    sifra int not null primary key auto_increment,
    djelatnik int not null,
    brojotpremnice varchar(50) not null,
    dobavljač varchar(50) null
);


create table klasifikacija(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null
);

create table JM(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null
);

create table primka_artikl(
    primka int not null,
    artikl int not null
);

alter table artikl add foreign key (JM) references JM(sifra);
alter table artikl add foreign key (klasifikacija) references klasifikacija(sifra);

alter table primka add foreign key (djelatnik) references djelatnik(sifra);

alter table primka_artikl add foreign key (primka) references primka(sifra);
alter table primka_artikl add foreign key (artikl) references artikl(sifra);
