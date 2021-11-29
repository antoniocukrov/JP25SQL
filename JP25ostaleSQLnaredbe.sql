# BAZA sakila

select a.country, d.first_name, d.last_name 
from country a
inner join city b on a.country_id  = b.country_id 
inner join address c on b.city_id  = c.city_id 
inner join staff d on d.address_id =c.address_id;

# "Zaposlite" se u sakila bazi. 
# Unesite zemlju, grad, adresu i sebe kao zaposlenika

describe country;

insert into country (country) values ('Croatia');

# 110
select * from country order by country_id desc limit 1;

describe city;

insert into city (city,country_id) values ('Osijek',110);

# 601
select * from city order by 1 desc limit 1;


describe address;

insert into address (address,district, city_id, phone) values
('Lorenza Jagera 2', 'Osječko baranjska', 601,'031/225-669');

# 606
select * from address order by 1 desc limit 1;

describe staff;

# 1
select * from store;

insert into staff (first_name, last_name, address_id, store_id,username)
values ('Tomislav','Jakopec',606,1,'tjakopec');


select count(*) from customer;


# 599
select first_name from customer;

# 591
select distinct first_name from customer;


select first_name, count(*)
from customer
where first_name like '%a%' # filtiraju se podaci pohranjeni u tablici
group by first_name
having count(*)>1 # filritaju se izvedeni / agregirani podaci
order by 1 desc
limit 2; 


select first_name, last_name from customer
union
select first_name, last_name from staff;

create table osoba
select first_name, last_name from customer
union
select first_name, last_name from staff;

select * from osoba where last_name like 'Ja%';

update osoba set first_name=upper(first_name), last_name=upper(last_name);

# Baza edunovajp25
select * from grupa;

select * from predavac;
# unesite Predavača Pavle Vidaković

describe osoba;
insert into osoba(ime,prezime,email) 
values ('Pavle','Vidaković','pavle@gmail.com');

select * from osoba order by 1 desc limit 1;

describe predavac;

insert into predavac (osoba) values (25);

select predavac from grupa where predavac is not null;

select b.ime, b.prezime
from predavac a inner join osoba b on a.osoba =b.sifra 
where a.sifra not in (
	select predavac from grupa where predavac is not null
);


# obrišite Pavle Vidakovića

delete from predavac where osoba=(select sifra from osoba where prezime='Vidaković');
delete from osoba where prezime='Vidaković';



# Baza Sakila

select * from film;

select *, datediff(return_date, rental_date) from rental where return_date is not null;


select a.first_name, a.last_name, 
sum(datediff(b.return_date, b.rental_date)*d.rental_rate) as ukupno,
avg(datediff(b.return_date, b.rental_date)) as prosjekdana
from customer a 
inner join rental b on a.customer_id  = b.customer_id 
inner join inventory c on b.inventory_id  = c.inventory_id 
inner join film d on c.film_id =d.film_id 
group by a.first_name, a.last_name
having ukupno>700
order by 4 desc;

# Koje je sve jedinstvene filmove RHONDA KENNEDY posudila?







