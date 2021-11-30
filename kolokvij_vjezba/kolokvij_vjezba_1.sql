drop database if exists vjezba1;
create database vjezba1 character set utf8;
use vjezba1;

create table sestra (
sifra int not null primary key auto_increment,
introvertno boolean null,
haljina varchar(31) not null,
maraka decimal(16, 6) null,
hlace varchar(46) not null,
narukvica int not null
);

create table punac(
sifra int not null primary key auto_increment,
ogrlica int null,
gustoca decimal(14, 9) null,
hlace varchar(41) not null
);

create table zena (
sifra int not null primary key auto_increment,
treciputa datetime null,
hlace varchar(46) null,
kratkamajica varchar(31) not null,
jmbag char(11) not null,
bojaociju varchar(39) not null,
haljina varchar(44) null,
sestra int not null
);

create table cura (
sifra int not null primary key auto_increment,
novcica decimal(16, 5) not null,
gustoca decimal(18, 6) not null,
lipa decimal(13, 10) null,
ogrlica int not null,
bojakose varchar(38) null,
suknja varchar(36) null,
punac int null
);

create table sestra_svekar (
sifra int not null primary key auto_increment,
sestra int not null,
svekar int not null
);

create table muskarac (
sifra int not null primary key auto_increment,
bojaociju varchar(50) not null,
hlace varchar(30) null,
modelnaocala varchar(43) null,
maraka decimal(14, 5) not null,
zena int not null
);

create table svekar (
sifra int not null primary key auto_increment,
bojaociju varchar(40) not null,
prstena int null,
dukserica varchar(41) null,
lipa decimal(13, 8) null,
eura decimal(12, 7) null,
majica varchar(35) null
);

create table mladic (
sifra int not null primary key auto_increment,
suknja varchar(50) not null,
kuna decimal(16, 8) not null,
drugiputa datetime null,
asocijalno boolean null,
ekstroventno boolean not null,
dukserica varchar(48) not null,
muskarac int null
);

alter table cura add foreign key (punac) references punac(sifra);

alter table zena add foreign key (sestra) references sestra(sifra);
alter table muskarac add foreign key (zena) references zena(sifra);

alter table mladic add foreign key (muskarac) references muskarac(sifra);

alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);


insert into sestra(haljina,hlace,narukvica) values 
('Haljina od rebrastog žerseja','SIKSILK JOGGERS',1),
('Kombinezon od viskoze','ZONAL TRACK PANTS',2),
('Baršunasti kombinezon','Bershka WIDE LEG',3);

insert into zena(kratkamajica,jmbag,bojaociju,sestra) values
('TMNT Exodus One2Play','2405999200004','Zelena',1),
('Žuta majica','1909986500003','Plava',2),
('Dres od Osijeka','3105994300002','Žuta',3);

insert into muskarac(bojaociju,maraka,zena) values
('Plava',400,1),
('Ljubičasta',1000,2),
('Crna',4000,3);

insert into svekar(bojaociju) values
('Zelena'),
('Plava'),
('Crvena');

insert into sestra_svekar(sestra,svekar) values
(1,1),
(2,2),
(3,3);

# update cura set gustoca=15.77;

# delete from mladic where kuna>15.78;

# select kratkamajica from zena where hlace like '%ana%';

# select f.dukserica,a.asocijalno,b.hlace from mladic a inner join muskarac b on a.muskarac=b.sifra inner join zena c on b.zena=c.sifra inner join sestra d on c.sestra=d.sifra inner join sestra_svekar e on e.sestra=d.sifra inner join svekar f on e.svekar=f.sifra where c.hlace like 'a%' and d.haljina like '%ba%' order by 3 desc;

# select a.haljina,a.maraka from sestra a inner join sestra_svekar b on b.sestra=a.sifra where a.sifra not in (select sestra from sestra_svekar where sestra is not null);