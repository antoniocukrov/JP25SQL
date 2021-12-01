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
