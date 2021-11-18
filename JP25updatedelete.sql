select * from smjer;

update smjer set cijena=3022.99 where sifra=1;

update smjer set naziv='PHP developer', cijena=5000 where sifra=2;

select * from grupa;

update grupa set predavac=2 where sifra=2;

select * from predavac;

# Dodajte predavača Shaquille O'Neal 
insert into osoba (sifra,ime,prezime,email) values
(null,'Shaquille', 'O''Neal','shaki@gmail.com');

select * from osoba;

insert into predavac (sifra,osoba) values (null,25);

# U tablici osoba postavite na sebe svoj OIB

update osoba 
set oib='15256585458'
where sifra=1;



# DELETE naredba
select * from smjer;
delete from smjer where sifra=1;
select * from grupa;
delete from grupa where sifra=1;
delete from clan where grupa=1;

# Obrišite sebe iz tablice osoba









