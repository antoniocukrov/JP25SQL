# DOMAĆA ZADAĆA: UČITATI SVE BAZE :bomb:

## Baza "knjiznica":books:
##### Odaberite sve autore za koje ne znamo datum rođenja:
        select * from autor where datumrodenja is null;
##### Unesite sebe kao autora:
        insert into autor(sifra,ime,prezime,datumrodenja) values (4,'Antonio','Cukrov',"1995-10-31 00:00:00");
##### Odaberite autore koji su rođeni na Vaš datum rođenja(uključujući i godinu):
        select * from autor where datumrodenja="1995-10-31";
##### Odaberite autore koji se zovu kao Vi:
        select * from autor where ime='ANTONIO';
##### Odaberite sve izdavače koji su društva s ograničenom odgovornošću:
        select * from izdavac where naziv like '%d.o.o%';

## Baza "world":earth_africa:
##### Odaberite sve zemlje iz Europe:

##### Unesite mjesto Donji Miholjac:

##### Promjenite Donji Miholjac u Špičkovinu:

##### Obrišite mjesto Špičkovina:
