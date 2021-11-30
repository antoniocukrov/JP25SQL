drop database if exists vjezba2;
create database vjezba2 character set utf8;
use vjezba2;

create table decko (
sifra int not null primary key auto_increment,
indiferentno bit null,
vesta varchar(34) null,
asocijalno bit not null
);

create table prijatelj (
sifra int not null primary key auto_increment,
modelnaocala varchar(37) null,
treciputa datetime not null,
ekstroventno bit not null,
prviputa datetime null,
svekar int not null
);

create table decko_zarucnica (
sifra int not null primary key auto_increment,
decko int not null,
zarucnica int not null
);

create table svekar (
sifra int not null primary key auto_increment,
stilfrizura varchar(48) null,
ogrlica int not null,
asocijalno bit not null
);

create table cura (
sifra int not null primary key auto_increment,
haljina varchar(33) not null,
drugiputa datetime not null,
suknja varchar(38) null,
narukvica int null,
introvertno bit null,
majica varchar(40) not null,
decko int null
);

create table zarucnica (
sifra int not null primary key auto_increment,
narukvica int null,
bojakose varchar(37) not null,
novcica decimal(15, 9) null,
lipa decimal(15, 8) not null,
indiferentno boolean not null
);


create table neprijatelj (
sifra int not null primary key auto_increment,
majica varchar(32) null,
haljina varchar(43) not null,
lipa decimal(16, 8) null,
modelnaocala varchar(49) not null,
kuna decimal(12, 6) not null,
jmbag char(11) null,
cura int null
);

create table brat (
sifra int not null primary key auto_increment,
suknja varchar(47) null,
ogrlica int not null,
asocijalno bit not null,
neprijatelj int not null
);

alter table prijatelj add foreign key (svekar) references svekar(sifra);

alter table cura add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);

alter table neprijatelj add foreign key (cura) references cura(sifra);
alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

insert into neprijatelj(haljina,modelnaocala,kuna) values
('crvena','okrugle',500),
('ljubičasta','pepeljarke',200),
('Gucci','Combo',2000);

insert into cura(haljina,drugiputa,majica) values
('na bretele',2012-05-21,'nike'),
('roza',2017-05-17,'adidas'),
('kratka',2019-07-05,'zara');

insert into zarucnica(bojakose,lipa,indiferentno) values
('Plava',50,1),
('Smeđa',30,1),
('Roza',99,0);

insert into decko(asocijalno) values
(1),
(1),
(0);

insert into decko_zarucnica(decko,zarucnica) values
(1,1),
(2,2),
(3,3);