drop database if exists vjezba5;
create database vjezba5 character set utf8;
use vjezba5;

create table mladic (
sifra int not null primary key auto_increment,
kratkamajica varchar(48) not null,
haljina varchar(30) not null,
asocijalno boolean null,
zarucnik int null
);

create table zarucnik (
sifra int not null primary key auto_increment,
jmbag char(11) null,
lipa decimal(12, 8) null,
indiferentno boolean not null
);

create table svekar (
sifra int not null primary key auto_increment,
bojakose varchar(33) null,
majica varchar(31) null,
carape varchar(31) not null,
haljina varchar(43) null,
narukvica int null,
eura decimal(14, 5) not null
);

create table svekar_cura (
sifra int not null primary key auto_increment,
svekar int not null,
cura int not null
);

create table cura (
sifra int not null primary key auto_increment,
carape varchar(41) not null,
maraka decimal(17, 10) not null,
asocijalno boolean null,
vesta varchar(47) not null
);

create table punac (
sifra int not null primary key auto_increment,
dukserica varchar(33) null,
prviputa datetime not null,
majica varchar(36) null,
svekar int not null
);

create table punica (
sifra int not null primary key auto_increment,
hlace varchar(43) not null,
nausnica int not null,
ogrlica int null,
vesta varchar(49) not null,
modelnaocala varchar(31) not null,
treciputa datetime not null,
punac int not null
);


create table ostavljena (
sifra int not null primary key auto_increment,
majica varchar(33) null,
ogrlica int not null,
carape varchar(44) null,
stilfrizura varchar(42) null,
punica int not null
);

alter table mladic add foreign key (zarucnik) references zarucnik(sifra);
alter table svekar_cura add foreign key (svekar) references svekar(sifra);
alter table svekar_cura add foreign key (cura) references cura(sifra);
alter table punac add foreign key (svekar) references svekar(sifra);
alter table punica add foreign key (punac) references punac(sifra);
alter table ostavljena add foreign key (punica) references punica(sifra);

insert into svekar(carape,eura) values
('Zelene',500),
('ray ban',600),
('Nike čapare', 20);

insert into punac(prviputa,svekar) values
(2019-04-06,1),
(2020-03-07,2),
(2017-09-22,3);

insert into punica(hlace,nausnica,vesta,modelnaocala,treciputa,punac) values
('Dugacke',1,'plava','pepeljarke',2019-04-12,1),
('kratke',12,'zelena','ray banković',2012-08-30,2),
('Bermude',13,'otvorena','harry potter',2015-11-30,3);

insert into cura(carape,maraka,vesta) values
('zelene',100,'zelena'),
('christmas',200,'loving'),
('stopice',300,'otvorena');

insert into svekar_cura(svekar,cura) values
(1,1),
(2,2),
(3,3);