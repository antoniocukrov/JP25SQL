select * from smjer;

# filtriranje kolona - select lista

# * sve kolone
select * from smjer;

# nazivi kolona odvojeni zarezom
select naziv from smjer;
select naziv, cijena from smjer;
select naziv, cijena, naziv from smjer;

select *, naziv from smjer;

# konstanta
select naziv, 'Osijek', 7 from smjer;

# koloni se može dati zamjensko ime
select naziv, 'Osijek' as mjesto, 7 as mjeseci from smjer;


# izraz
select naziv, length(naziv) as duzina from smjer;





# Filtriranje redova
select * from smjer where sifra=1;

# operatori uspoređivanja: =, <, >, <=, >=, != (<>)

select * from smjer where sifra!=2;

# logički operatori: and, or i not https://introcs.cs.princeton.edu/java/71boolean/images/truth-table.png


select * from smjer where sifra>1 and sifra<3;
1 0 i 1
2 1 i 1
3 1 i 0

select * from smjer where sifra=1 or sifra=3;
1 1 ili 0
2 0 ili 0
3 0 ili 1

select * from smjer where not (sifra=1 or sifra=3);


# Ostali nama bitni operatori: like, is null, is not null, in, between

select * from osoba where ime='Filip';

select * from osoba where ime like '%f%';

select * from osoba where ime like 'f%';

select * from osoba where ime not like '%a';

select * from osoba where oib is null;
select * from osoba where oib is not null;

select * from osoba where sifra=1 or sifra=7 or sifra=12 or sifra=19;
select * from osoba where sifra in (1,7,12,19);

select * from osoba where sifra>=5 and sifra<=15;
select * from osoba where sifra between 5 and 15;


# Izlistajte prezimena i imena osoba




# baza mjesta
# odaberite sva mjesta koja se nalaze u Osječko baranjskoj
# županiji

# odaberite sva mjesta koja u sebi imaju niz znakova ac

# Dodajte mjesto Programovci u Osječko baranjskoj županiji

################################################
#DOMAĆA ZADAĆA: UČITATI SVE BAZE

##### baza knjiznica
# odaberite sve autore za koje ne znamo datum rođenja

# Unesite sebe kao autora

# odaberite autore koji su rođeni na Vaš datum rođenja
# uključujući i godinu

# odaberite autore koji se zovu kao Vi

# odaberite sve izdavače koji su 
# društva s ograničenom odgovornošću


##### baza world
# odaberite sve zemlje iz Europe

# unesite mjesto Donji Miholjac

# Promjenite Donji Miholjac u Špičkovinu

# Obrišite mjesto Špičkovina









