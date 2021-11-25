# https://dev.to/azibom/sql-joins-29j4
select naziv,smjer from grupa;

select a.naziv as grupa, b.naziv as smjer
from grupa a inner join smjer b on a.smjer=b.sifra;

# drugi način
select grupa.naziv as grupa, smjer.naziv as smjer
from grupa inner join smjer on grupa.smjer=smjer.sifra;

# stari način
select grupa.naziv as grupa, smjer.naziv as smjer
from grupa, smjer where grupa.smjer = smjer.sifra; 


select a.naziv as grupa, b.naziv as smjer, d.ime, d.prezime 
from grupa a inner join smjer b on a.smjer=b.sifra
left join predavac c on a.predavac = c.sifra
left join osoba d on c.osoba = d.sifra;

# Ispišite sve šifre polaznika i njihova imena i prezimena
select a.sifra, b.ime, b.prezime 
from polaznik a inner join osoba b on a.osoba=b.sifra;


# ispišite sva imena i prezimena polaznika koji su članovi grup JP25


select d.ime, d.prezime
from clan a inner join grupa b on a.grupa = b.sifra 
inner join polaznik c on a.polaznik = c.sifra 
inner join osoba d on c.osoba = d.sifra
where b.naziv = 'JP25';


# Upišite sebe u grupu PP24

select * from osoba;
select * from polaznik;
select * from clan;

insert into clan(grupa,polaznik) values
(2,14);


# Ispišite sve nazive grupa u kojima se nalazite Vi
select b.naziv
from clan a inner join grupa b on a.grupa = b.sifra 
inner join polaznik c on a.polaznik = c.sifra 
inner join osoba d on c.osoba = d.sifra 
where d.ime='Ivan';


# "Udajte" se svi i promjenite si prezime na novo željeno

# Obrišite sve svoje podatke iz baze



###### DZ

# Baza Knjižnica
#izvucite sve nazive knjiga koje su izdali
#ne aktivni izdavači

# izvucite sve autore koji u svojim naslovima 
# knjiga nemaju slovo B

# izvucite sve aktivne izdavače koji su izdali knjige u Zagrebu



# sakila baza
# izvucite sve nazive zemalja čiji gradovi nemaju definiranu 
# adresu 





