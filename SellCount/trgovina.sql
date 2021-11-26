drop database if exists trgovina;
create database trgovina character set utf8;
use trgovina;

#c:\xampp\mysql\bin\mysql -uedunova -pedunova --default_character_set=utf8 < "C:\Users\Lord Pupcent\Documents\GitHub\JP25SQL\SellCount\trgovina.sql"

create table artikl(
    sifra int not null primary key auto_increment,
    naziv varchar(50) not null,
    EANkod varchar(50) not null,
    cijena decimal(18.2),    
    JM int not null,
    klasifikacija int null,
    zaliha decimal(18.2) not null
);

create table djelatnik(
    sifra int not null primary key auto_increment,
    ime varchar(50) not null,
    prezime varchar(50) not null,
    lozinka varchar(50) not null
);

create table primka(
    sifra int not null primary key auto_increment,
    djelatnik int not null,
    brojotpremnice varchar(50) not null,
    dobavljac varchar(50) null
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
    artikl int not null,
    kolicina decimal(18.2) not null
);

alter table artikl add foreign key (JM) references JM(sifra);
alter table artikl add foreign key (klasifikacija) references klasifikacija(sifra);

alter table primka add foreign key (djelatnik) references djelatnik(sifra);

alter table primka_artikl add foreign key (primka) references primka(sifra);
alter table primka_artikl add foreign key (artikl) references artikl(sifra);

insert into djelatnik(sifra,ime,prezime,lozinka) values
(null,'Dijana','Božić','01'),
(null,'Nedeljko','Vukoja','02'),
(null,'Stojan','Horvat','03'),
(null,'Finka','Tomčić','04'),
(null,'Manda','Knežević','05'),
(null,'Dijana','Božić','06'),
(null,'Nedeljko','Vukoja','07'),
(null,'Stojan','Horvat','08'),
(null,'Finka','Tomčić','09'),
(null,'Manda','Knežević','10'),
(null,'Dijana','Božić','11'),
(null,'Nedeljko','Vukoja','12'),
(null,'Stojan','Horvat','13'),
(null,'Finka','Tomčić','14'),
(null,'Manda','Knežević','15');

insert into klasifikacija(sifra,naziv) values
(null,'Piće'),
(null,'Grickalice'),
(null,'Kozmetika'),
(null,'IT Oprema'),
(null,'Voće'),
(null,'Ulja i mazivi proizvodi'),
(null,'BISTRO');

insert into jm(sifra,naziv) values
(null,'kg'),
(null,'L'),
(null,'KOM');

insert into primka(sifra,djelatnik,brojotpremnice,dobavljac) values
(null,1,'OT00001123','Roto d.o.o'),
(null,2,'RO00014576','Panino d.o.o'),
(null,2,'DA00018949','Celjske mesnine'),
(null,3,'OT00017248','Atlantic d.o.o'),
(null,1,'PE00013519','Rox d.o.o'),
(null,4,'OT00054674','Cellularline');

insert into artikl(sifra,naziv,EANkod,cijena,JM,klasifikacija,zaliha) values
(null,'Coca-cola 0.5L','978020137962',9.99,3,1,40),
(null,'Sprite 0.5L','893267165377',9.99,3,1,10),
(null,'Corny čokolada 80g','761114683244',4.99,3,2,30),
(null,'Bananko 60g','367354095265',3.99,3,3,30),
(null,'Always','240427427173',15.50,3,3,10),
(null,'Axe aftershave','448676229150',21.0,3,3,9),
(null,'Punjač za Iphone 120cm','848770914637',90.00,3,4,4),
(null,'Punjač za Android Type-C 100 cm','425708251559',80.50,3,4,5),
(null,'Juneći but','814161371066',60.0,1,7,0.5),
(null,'Ćevapi','758382682209',10.40,1,7,5),
(null,'Kompot breskva','661706104847',16.0,3,5,10),
(null,'Shell 10W-40','643728005007',79.99,3,6,4);


