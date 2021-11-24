select * from autor;
select * from autor where datumrodenja is null;

insert into autor(sifra,ime,prezime,datumrodenja) values (4,'Antonio','Cukrov',"1995-10-31 00:00:00");

select * from autor where datumrodenja="1995-10-31";

update smjer set cijena=3022.99 where sifra=1;

select * from autor where ime='ANTONIO';

select * from city where ID>4078;
select * from izdavac where naziv like '%d.o.o%';

select * from countrylanguage where CountryCode='HRV';
select * from country where Continent='Europe';

insert into city(ID,Name,CountryCode,District,Population) values (null, 'Donji Miholjac', 'HRV', 'Osjecko-baranjska', 9491);

update city set name='Špickovina' where ID=4080;

delete from city where ID=4080;