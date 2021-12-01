drop database if exists vjezba6;
create database vjezba6 character set utf8;
use vjezba6;

create table prijatelj(
sifra int not null primary key auto_increment;
haljina varchar(35) null,
prstena int not null,
introvertno boolean null,
stilfrizura varchar(36) not null
);

create table svekrva(
sifra int not null primary key auto_increment;
hlace varchar(48) not null,
suknja varchar(42) not null,
ogrlica int not null,
treciputa datetime not null,
dukserica varchar(32) not null,
narukvica int not null,
punac int null
);

create table punac(
sifra int not null primary key auto_increment;
ekstroventno boolean not null,
suknja varchar(30) not null,
majica varchar(44) not null,
prviputa datetime not null
);

create table prijatelj_ostavljena(
sifra int not null primary key auto_increment;
prijatelj int not null,
ostavljena int not null
);

create table brat(
sifra int not null primary key auto_increment;
nausnica int not null,
treciputa datetime not null,
narukvica int not null,
hlace varchar(31) null,
prijatelj int null
);

create table ostavljena(
sifra int not null primary key auto_increment;
prviputa datetime not null,
kratkamajica varchar(39) not null,
drugiputa datetime null,
maraka decimal(14, 10) null
);

create table zena(
sifra int not null primary key auto_increment;
novcica decimal(14, 8) not null,
narukvica int not null,
dukserica varchar(40) not null,
haljina varchar(30) null,
hlace varchar(32) null,
brat int not null
);

create table decko(
sifra int not null primary key auto_increment;
prviputa datetime null,
modelnaocala varchar(41) null,
nausnica int null,
zena int not null
);
