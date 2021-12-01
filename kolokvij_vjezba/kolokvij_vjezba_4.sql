drop database if exists vjezba4;
create database vjezba4 character set utf8;
use vjezba4;

create table punac(
sifra int not null primary key auto_increment,
treciputa datetime null,
majica varchar(46) null,
jmbag char(11) not null,
novcica decimal(18, 7) not null,
maraka decimal(12, 6) not null,
ostavljen int not null
);

create table zena(
sifra int not null primary key auto_increment,
suknja varchar(39) not null,
lipa decimal(18, 7) null,
prstena int not null
);

create table zena_mladic(
sifra int not null primary key auto_increment,
zena int not null,
mladic int not null
);

create table snasa(
sifra int not null primary key auto_increment,
introvertno boolean null,
treciputa datetime null,
haljina varchar(44) not null,
zena int not null
);

create table ostavljen(
sifra int not null primary key auto_increment,
modelnaocala varchar(43) null,
introvertno boolean null,
kuna decimal(14, 10) null
);

create table mladic(
sifra int not null primary key auto_increment,
kuna decimal(15, 9) null,
lipa decimal(18, 5) null,
nausnica int null,
stilfrizura varchar(49) null,
vesta varchar(34) not null
);

create table becar(
sifra int not null primary key auto_increment,
novcica decimal(14, 8) null,
kratkamajica varchar(48) not null,
bojaociju varchar(36) not null,
snasa int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
eura decimal(16, 9) null,
prstena int not null,
gustoca decimal(16, 5) null,
jmbag char(11) not null,
suknja varchar(47) not null,
becar int not null
);


alter table punac add foreign key (ostavljen) references ostavljen(sifra);

alter table zena_mladic add foreign key (mladic) references mladic(sifra);
alter table zena_mladic add foreign key (zena) references zena(sifra);
alter table snasa add foreign key (zena) references zena(sifra);
alter table becar add foreign key (snasa) references snasa(sifra);
alter table prijatelj add foreign key (becar) references becar(sifra);

insert into zena(suknja,prstena) values
('roza',1),
('kratka',2),
('Unequipped',3);

insert into snasa(haljina,zena) values
('duga',1),
('s mašnom',2),
('Minnie',3);

insert into becar(kratkamajica,bojaociju,snasa) values
('Nike','Plava',1),
('Adidas','Zelena',2),
('Under armor','Smeđa',3);

insert into mladic(vesta) values
('Roza'),
('Plava'),
('Ona iz New Yorkera');

insert into zena_mladic(zena,mladic) values
(1,1),
(2,2),
(3,3);

#update punac set majica='Osijek';

#delete from prijatelj where prstena>17;

#select haljina from snasa where treciputa is null;

#select a.nausnica,f.jmbag, e.kratkamajica from mladic a inner join zena_mladic b on b.mladic=a.sifra inner join zena c on c.sifra=b.zena inner join snasa d on d.zena=c.sifra inner join becar e on e.snasa= d.sifra inner join prijatelj f on f.becar=e.sifra where d.treciputa not in (select treciputa from snasa where treciputa is not null) and c.lipa!=29 order by 3 desc;

#select a.lipa,a.prstena from zena a inner join zena_mladic b on b.zena=a.sifra where a.sifra not in(select zena from zena_mladic where zena is not null);




