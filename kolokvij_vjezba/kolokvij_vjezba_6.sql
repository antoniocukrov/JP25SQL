drop database if exists vjezba6;
create database vjezba6 character set utf8;
use vjezba6;

create table prijatelj(
sifra int not null primary key auto_increment,
haljina varchar(35) null,
prstena int not null,
introvertno boolean null,
stilfrizura varchar(36) not null
);

create table svekrva(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
suknja varchar(42) not null,
ogrlica int not null,
treciputa datetime not null,
dukserica varchar(32) not null,
narukvica int not null,
punac int null
);

create table punac(
sifra int not null primary key auto_increment,
ekstroventno boolean not null,
suknja varchar(30) not null,
majica varchar(44) not null,
prviputa datetime not null
);

create table prijatelj_ostavljena(
sifra int not null primary key auto_increment,
prijatelj int not null,
ostavljena int not null
);

create table brat(
sifra int not null primary key auto_increment,
nausnica int not null,
treciputa datetime not null,
narukvica int not null,
hlace varchar(31) null,
prijatelj int null
);

create table ostavljena(
sifra int not null primary key auto_increment,
prviputa datetime not null,
kratkamajica varchar(39) not null,
drugiputa datetime null,
maraka decimal(14, 10) null
);

create table zena(
sifra int not null primary key auto_increment,
novcica decimal(14, 8) not null,
narukvica int not null,
dukserica varchar(40) not null,
haljina varchar(30) null,
hlace varchar(32) null,
brat int not null
);

create table decko(
sifra int not null primary key auto_increment,
prviputa datetime null,
modelnaocala varchar(41) null,
nausnica int null,
zena int not null
);


alter table svekrva add foreign key (punac) references punac(sifra);
alter table prijatelj_ostavljena add foreign key (ostavljena) references ostavljena(sifra);
alter table prijatelj_ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table brat add foreign key (prijatelj) references prijatelj(sifra);
alter table zena add foreign key (brat) references brat(sifra);
alter table decko add foreign key (zena) references zena(sifra);


insert into brat (nausnica,treciputa,narukvica) values
(9,2020-05-04,7),
(2,2020-04-17,6),
(32,2019-09-12,8);

insert into zena (novcica,narukvica,dukserica,brat) values
(18,1,'plava',1),
(13,22,'roza',2),
(300,12,'kapuljača',3);

insert into prijatelj (prstena,stilfrizura) values
(12,'Bekemica'),
(13,'Ronaldo style'),
(14,'SKINHEAD');

insert into ostavljena (prviputa,kratkamajica) values
(2020-09-13,'Nike'),
(2020-01-02,'Adidas'),
(1995-03-03,'OMG');

insert into prijatelj_ostavljena(prijatelj,ostavljena) values
(1,1),
(2,2),
(3,3);

#update svekrva set suknja='Osijek';

#delete from decko where modelnaocala<20;

#select narukvica from brat where treciputa is not null;

#select a.drugiputa, f.zena , e.narukvica from ostavljena a inner join prijatelj_ostavljena b on b.ostavljena=a.sifra inner join prijatelj c on b.prijatelj=c.sifra inner join brat d on d.prijatelj=c.sifra inner join zena e on e.brat=d.sifra inner join decko f on f.zena=e.sifra where d.treciputa not in(select treciputa from brat where treciputa is not null) and c.prstena=219 order by 3 desc;