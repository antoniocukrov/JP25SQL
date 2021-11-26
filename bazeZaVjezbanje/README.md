# Homework no.1: :bomb:

### Baza "knjiznica":books:
###### Odaberite sve autore za koje ne znamo datum rođenja:
        select * from autor where datumrodenja is null;
###### Unesite sebe kao autora:
        insert into autor(sifra,ime,prezime,datumrodenja) values (4,'Antonio','Cukrov',"1995-10-31 00:00:00");
###### Odaberite autore koji su rođeni na Vaš datum rođenja(uključujući i godinu):
        select * from autor where datumrodenja="1995-10-31";
###### Odaberite autore koji se zovu kao Vi:
        select * from autor where ime='ANTONIO';
###### Odaberite sve izdavače koji su društva s ograničenom odgovornošću:
        select * from izdavac where naziv like '%d.o.o%';

### Baza "world":earth_africa:
###### Odaberite sve zemlje iz Europe:
        select * from country where Continent='Europe';
###### Unesite mjesto Donji Miholjac:
        insert into city(ID,Name,CountryCode,District,Population) values (null, 'Donji Miholjac', 'HRV', 'Osjecko-baranjska', 9491);
###### Promjenite Donji Miholjac u Špičkovinu:
        update city set name='Špickovina' where ID=4080;
###### Obrišite mjesto Špičkovina:
        delete from city where ID=4080;

# Homework no.2: 

### Baza "knjiznica":books:
###### Izvucite sve nazive knjiga koje su izdali ne aktivni izdavači
        select a.naslov from katalog a inner join izdavac b on a.izdavac=b.sifra;
###### Izvucite sve autore koji u svojim naslovima knjiga nemaju slovo B
        select distinct b.ime,b.prezime from katalog a inner join autor b on a.autor=b.sifra where naslov not like '%b%';
###### Izvucite sve aktivne izdavače koji su izdali knjige u Zagrebu
        select a.sifra,a.naziv
        from katalog b inner join izdavac a on a.sifra = b.izdavac 
        inner join mjesto c on b.mjesto = c.sifra 
        where c.naziv='Zagreb' and a.aktivan=1;



### Baza "sakila" :heavy_dollar_sign:
###### Izvucite sve nazive zemalja čiji gradovi nemaju definiranu adresu 
        