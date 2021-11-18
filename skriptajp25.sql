drop database if exists edunovajp25;
create database edunovajp25 character set utf8;
# otvoriti cmd i zaljepiti od znaka # do kraja - pripaziti na putanju
# c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < c:\skriptajp25.sql
use edunovajp25;

create table smjer(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    trajanje int not null,
    cijena decimal(18,2),
    certificiran boolean
);

create table osoba(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    oib char(11),
    email varchar(50) not null
);

create table grupa(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    smjer int not null,
    predavac int,
    datumpocetka datetime
);

create table predavac(
    sifra int not null primary key auto_increment,
    osoba int not null,
    iban varchar(50)
);

create table polaznik(
    sifra int not null primary key auto_increment,
    osoba int not null,
    brojugovora varchar(50)
);

create table clan(
    grupa int not null,
    polaznik int not null
);


alter table grupa add foreign key (smjer) references smjer(sifra);
alter table grupa add foreign key (predavac) references predavac(sifra);

alter table predavac add foreign key (osoba) references osoba(sifra);

alter table polaznik add foreign key (osoba) references osoba(sifra);

alter table clan add foreign key (grupa) references grupa(sifra);
alter table clan add foreign key (polaznik) references polaznik(sifra);


# Loš način
# 1
insert into smjer values (null,'Java programiranje',130,5999.99,true);

# Malo bolji način
# 2
insert into smjer (sifra,naziv,trajanje) 
values (null,'PHP programiranje',130);

# Dobra praksa
# 3
insert into smjer (sifra,naziv,trajanje,cijena,certificiran)
values (null,'Računovodstvo',240,null,false);

# 1
insert into osoba(sifra,ime,prezime,oib,email)
values (null,'Tomislav','Jakopec','95800140506','tjakopec@gmail.com');

# 2 - 24
insert into osoba(sifra,ime,prezime,email) values
(null,'Stjepan','Groznica','stjepan.groznica@gmail.com'),
(null,'Franko','Vekić','franko.vekic@gmail.com'),
(null,'Ivana','Cerovski','ivana.cerovski85@gmail.com'),
(null,'Rudolf','Esert','rudolf.esert@gmail.com'),
(null,'Aleksandar','Jergić','acojergic@gmail.com'),
(null,'Mateo','Cvenić','mateo.cvenic@gmail.com'),
(null,'Juraj','Mak','juraj.mak90@gmail.com'),
(null,'Tea','Matasović','teamatasovic@gmail.com'),
(null,'Miroslav','Ambroš','miroslav.ambros@gmail.com'),
(null,'Matej','Lišćak','liscakmatej1@gmail.com'),
(null,'Filip','Stamenković','stameniwow83@gmail.com'),
(null,'Matej','Zovak','matejzovak031@gmail.com'),
(null,'Antonio','Cukrov','anub031@gmail.com'),
(null,'Ivan','Thür','ivan.thuer@gmail.com'),
(null,'Mario','Kordić','mario.kordic4@gmail.com'),
(null,'Igor','Davidović','igordavidovic137@gmail.com'),
(null,'Patrik','Bolf','bolfpatrik0@gmail.com'),
(null,'Neven','Gostić','neven.gostic@gmail.com'),
(null,'Frane','Dumančić','franedumancic@icloud.com'),
(null,'Filip','Janković','filip.vno.jankovic@gmail.com'),
(null,'Nikolina','Bradarić','nina.bradaric@gmail.com'),
(null,'Josip','Balog','jbalooog@gmail.com'),
(null,'Matija','Skrletović','skrlama@gmail.com');

# 1
insert into predavac (sifra,osoba,iban) values (null,1,null);


# 1 - 23
insert into polaznik (sifra,osoba,brojugovora) values
(null,2,null),
(null,3,null),
(null,4,null),
(null,5,null),
(null,6,null),
(null,7,null),
(null,8,null),
(null,9,null),
(null,10,null),
(null,11,null),
(null,12,null),
(null,13,null),
(null,14,null),
(null,15,null),
(null,16,null),
(null,17,null),
(null,18,null),
(null,19,null),
(null,20,null),
(null,21,null),
(null,22,null),
(null,23,null),
(null,24,null);


# 1
insert into grupa (sifra, naziv,smjer,predavac,datumpocetka) 
values (null,'JP25',1,1,'2021-10-27');

# 2
insert into grupa(naziv,smjer,sifra)
values ('PP24',2,null);


insert into clan (grupa,polaznik) values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(1,20),
(1,21),
(1,22),
(1,23);
