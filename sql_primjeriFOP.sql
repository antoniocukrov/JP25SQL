


# funkcije

select now(); # ne prima niti jedan parametar

select lower(left(ime,1)) from osoba order by 1; # left prima dva parametara, lower prima jedan parametar

select concat(ime, ' ', prezime, ' žive u Osijeku') from osoba;

# matematičke funkcije

select pow(2,10);

select sqrt(9);

select abs(-1);


# znakovne

select upper(ime) from osoba;

# ispisati imena prvo slovo malo, sva ostala velika

select concat(lower(left(ime,1)),upper(right(ime,length(ime)-1))) from osoba;


# datumske funkcije
# koji je datum za 90 dana
select adddate(now(),interval 90 day);

# koji je datum bio prije 90 dana
select adddate(now(),interval -90 day);

select datediff(now(),'1980-12-07') * 24 * 60 * 70;


# kreiranje vlastitih funkcija
delimiter $$
create function email(ime varchar(50), prezime varchar(50)) returns varchar(255)
begin
	return concat(ime,prezime,'@edunova.hr');
	
end;
$$ 
delimiter ;


select email(ime,prezime) from osoba;


drop function if exists email;
DELIMITER $$
CREATE FUNCTION email(ime varchar(50), prezime varchar(50)) RETURNS varchar(255)
begin

return concat(left(lower(ime),1),'.', lower(
replace(
replace(
replace(
replace(
replace(replace(upper(prezime),' ',''),'Č','C')
,'Š','S')
,'Đ','D')
,'Ć','C')
,'Ž','Z')
), '@edunova.hr');
end;
$$
DELIMITER ;



# procedure

delimiter $$
create procedure brisismjer(in sifrasmjera int)
begin
	delete from clan where grupa in (select sifra from grupa where smjer=sifrasmjera);

	delete from grupa where smjer = sifrasmjera;

	delete from smjer where sifra=sifrasmjera;

	
end
$$
delimiter ;

call brisismjer(1);

select * from smjer;


# okidači (trigger)


create table logiranje(
tko varchar(255),
sto varchar(255),
kada datetime default now()
);

select * from logiranje;
drop trigger if exists osoba_unos;
delimiter $$
create trigger osoba_unos before insert on osoba for each row
begin
 insert into logiranje (tko,sto) values ('unos nove osobe', concat(new.ime,' ', new.prezime));
	
end
$$
delimiter ;
select * from osoba limit 1;
insert into osoba (ime,prezime,email) values ('Pero','Perić','email');



delimiter $$
CREATE TRIGGER update_osoba
before update
   ON osoba FOR EACH ROW
BEGIN

insert into logiranje values('osoba promjena',concat(old.ime, ' - ', new.ime),now());

END$$

delimiter ;


delimiter $$
CREATE TRIGGER delete_osoba
after delete
   ON osoba FOR EACH ROW
BEGIN

insert into logiranje values('obrisao osobu',concat(old.ime, ' ', old.prezime),now());

END$$

delimiter ;


insert into osoba (ime,prezime,email) values ('Pero','Perić','pp');

select * from osoba order by 1 desc;

update osoba set ime = 'Perica' where sifra=46;

delete from osoba where sifra=46;







#baza knjiznica
#proširim tablicu autor
alter table autor add column dodatak varchar(10);

select * from autor;

#primjer procedure koja će u kolonu dodatak pohraniti A1 - An
drop procedure if exists inicijalni_dodatak;

delimiter $$
CREATE PROCEDURE inicijalni_dodatak ()
BEGIN

DECLARE kraj INTEGER DEFAULT 0;
DECLARE _sifra int;
 DECLARE broj int;
 DEClARE autor_kursor CURSOR FOR 
SELECT sifra FROM autor order by sifra;

DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET kraj = 1;


OPEN autor_kursor;
set broj=1;
petlja: LOOP

FETCH autor_kursor INTO _sifra;

IF kraj = 1 THEN 
 LEAVE petlja;
 END IF;
 
 update autor set dodatak=concat('A',broj) where sifra=_sifra;
set broj=broj+1;

END LOOP petlja;

CLOSE autor_kursor;

END$$

delimiter ;


call inicijalni_dodatak();






#primjer procedure koja će u nadopuniti ne popunjene kolone
drop procedure if exists nadopuni_dodatak;
delimiter $$
CREATE PROCEDURE nadopuni_dodatak ()
BEGIN
DECLARE kraj INTEGER DEFAULT 0;
 DECLARE _sifra int;
 DECLARE broj int;
 DEClARE autor_kursor CURSOR FOR 
 select sifra from autor where dodatak is null or dodatak='' order by sifra;

 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET kraj = 1;
OPEN autor_kursor;
set broj=(select max(cast(substring(dodatak,2) as SIGNED)) from autor where dodatak is not null);
petlja: LOOP

FETCH autor_kursor INTO _sifra;

IF kraj = 1 THEN 
 LEAVE petlja;
 END IF;
set broj=broj+1;
update autor set dodatak=concat('A',broj) where sifra=_sifra;


END LOOP petlja;


CLOSE autor_kursor;

END$$

delimiter ;

#pozivanje procedure
call nadopuni_dodatak();


#zabraniti nepoznavanje dodatka
alter table autor MODIFY column dodatak varchar(10) not null ;




#napraviti trigger kada se odradi insert da se odmah dodjeli dodatak
drop TRIGGER if exists insert_autor;
delimiter $$

CREATE TRIGGER insert_autor
before INSERT
   ON autor FOR EACH ROW

BEGIN

   DECLARE broj int;
   set broj=(select max(cast(substring(dodatak,2) as SIGNED)) from autor where dodatak is not null);
    set broj=broj+1;
    set NEW.dodatak=concat('A',broj);
    
   
END$$

delimiter ;





# ručni backup
#mysqldump -uedunova -pedunova knjiznica > e:\knjiznica_backup.sql

#batch skripta koja se postavi u sceduller svaki dan
#@ECHO OFF
#for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a
#mysqldump -uedunova -pedunova knjiznica > e:\knjiznica_backup%datetime%.sql
#type e:\knjiznicaPTF.sql >> e:\knjiznica_backup%datetime%.sql
#datoteka knjiznicaPTF.sql sadrži sve dodatne procedure, funkcije i okidače








#čisti dijakritike
DROP FUNCTION IF EXISTS cisti;
DELIMITER $$
CREATE FUNCTION cisti(t varchar(100))
  RETURNS varchar(100)
BEGIN
  RETURN replace(
replace(
replace(
replace(
replace(
replace(lower(t),'š','s'),'ć','c'),'ž','z'),'đ','d'),'č','c'),' ','');
END;
$$
DELIMITER ;


DROP FUNCTION IF EXISTS email;
DELIMITER $$
CREATE FUNCTION email(ime varchar(100),prezime varchar(100))
  RETURNS varchar(200)
BEGIN
  RETURN concat(cisti(ime),cisti(prezime),'@edunova.hr');
END;
$$
DELIMITER ;




#LOG MYSQL servera se omogućuje u my.ini datoteci bez znakova #
# The MySQL server
#[mysqld]
#....
#general_log=1
#general_log_file=c:\mysqllog.log



#u log će se spremati podaci definirani po trigerima
create table log(
tko varchar(100),
sto varchar(100),
kada datetime);


drop TRIGGER if exists insert_izdavac;
delimiter $$

CREATE TRIGGER insert_izdavac
before INSERT
   ON izdavac FOR EACH ROW

BEGIN

  
    insert into log(tko,sto,kada) values ('inser izdavac',new.naziv,now());

END$$

delimiter ;


drop TRIGGER if exists update_izdavac;
delimiter $$

CREATE TRIGGER update_izdavac
before UPDATE
   ON izdavac FOR EACH ROW

BEGIN

  
    insert into log(tko,sto,kada) values ('update izdavac',concat(old.naziv, ' : ',new.naziv),now());

END$$

delimiter ;



#update ako je uvjet u drugoj tablici

update autor a inner join katalog b on a.sifra=b.autor
inner join izdavac c on b.izdavac=c.sifra
set a.ime=replace(a.ime,'A','AA')
where c.aktivan=0;


#podupiti: svi autori koji nisu objavili niti jednu knjigu


select * from autor where sifra not in 
(select distinct autor from katalog where autor is not null);



















#lozinke postavljajte kao char(32)
alter table osoba add column lozinka char(32);

#funkcije
#now() ne prima niti jedan parametar
#rtrim(X) - prima jedan parametar
#funkcije primaju više parametara odvojenih zarezom
#concat nadoljepljuje stringove (y,y,y,y,y)
select now(),lozinka, rtrim(lozinka) from osoba;

#upit koji radi ali ne uvjek
select * from osoba where 
email like '%tomislav jakopec%'
or ime like '%tomislav jakopec%'
or prezime like '%tomislav jakopec%';

select *
 from osoba where 
concat(email IS NOT NULL, ' ', ime, ' ', prezime, ' ', ime) 
like '%tomislav jakopec%';

select concat('>>', lozinka, '<<') 
 from osoba ;

#lozinke se neće vidjeti već će biti pohranjena hash vrijednost prema md5 algoritmu


#funkcije na nizovima znakova (string functions): 
update osoba set lozinka=md5('god12345') where oib='00000000001';


select lower(ime), upper(ime) from osoba;
select concat(upper(left(ime,1)),lower(SUBSTRING(ime,2,length(ime)-2))) from osoba;
#primjer matematičke funkcije
select pi();

#datumske funkcije
#nakon 3 mjeseca
select adddate(now(), interval 3 month);

#prije 90 dana
select adddate(now(), interval -90 day);

#za 1000 sati
select adddate(now(), interval 1000 hour);

#razlika u danima
select abs(datediff('2014-11-12',now()));

#prosječan broj otkucaja srca od 07. 12. 1980.
select TIMESTAMPDIFF(minute, '1980-12-07', now())*70;



#kreiranje vlastite funkcije
#1. mjenjamo delimiter
# funkcija kada se pozove isiše broj 1
DELIMITER $$
CREATE FUNCTION pozdrav() RETURNS int
begin

#hrpa koda
return 1;
end;
$$

select pozdrav(), ime from osoba;



# funkcija koja za primljeni niz znakova dodaje isprad g.
DELIMITER $$
CREATE FUNCTION titula(x varchar(50)) RETURNS varchar(50)
begin
return concat('g. ',x);
end;
$$
delimiter ;

select titula(prezime), ime from osoba;

create table logtablica(tko varchar(50),sto varchar(50), kada datetime);

#okidači - trigger
drop TRIGGER if exists insert_osoba;
delimiter $$
CREATE TRIGGER insert_osoba
before INSERT
   ON osoba FOR EACH ROW
BEGIN

insert into logtablica values('osoba',new.ime,now());

END$$

delimiter ;

insert into osoba (oib,ime,prezime) values ('11111111111','Pero','Stolica');
select * from logtablica;

create table osoba_arhiva(
datum datetime,
oib char(11)  ,
ime varchar(50) not null,
prezime varchar(50) not null,
email varchar(100) ,
lozinka char(32)
)engine=innodb;

drop TRIGGER if exists update_osoba;
delimiter $$
CREATE TRIGGER update_osoba
before UPDATE
   ON osoba FOR EACH ROW
BEGIN

insert into osoba_arhiva values
(now(), old.oib,old.ime,old.prezime,old.email,old.lozinka);

END$$

delimiter ;

update osoba set prezime='Herc' where oib='00000000011';
select * from osoba_arhiva;



#pohranjene procedure služe za logičko objedinjavanje više upita (osnovno)
#ovo nije realan primjer
drop procedure if exists koeficijent;
delimiter $$
CREATE procedure koeficijent()
BEGIN
select ime from osoba;
update smjer set upisnina=200;
select naziv from smjer;

END$$
delimiter ;

call koeficijent();


#korištenje procedure da se utječe na podatke u tablici

#PREBACITI SE NA KNJIZNICU
#baza knjiznica
#proširim tablicu autor
alter table autor add column dodatak varchar(10);

select * from autor;

#primjer procedure koja će u kolonu dodatak pohraniti A1 - An
drop procedure if exists inicijalni_dodatak;

delimiter $$
CREATE PROCEDURE inicijalni_dodatak ()
BEGIN
DECLARE kraj INTEGER DEFAULT 0;#obavezno
DECLARE _sifra int;
 DECLARE broj int;
 DEClARE autor_kursor CURSOR FOR SELECT sifra FROM autor order by sifra; #obavezno
DECLARE CONTINUE HANDLER  FOR NOT FOUND SET kraj = 1; #obavezno
OPEN autor_kursor; #obavezno
set broj=1;
petlja: LOOP #obavezno
FETCH autor_kursor INTO _sifra;#obavezno
IF kraj = 1 THEN #obavezno
 LEAVE petlja;#obavezno
 END IF;#obavezno
 update autor set dodatak=concat('A',broj) where sifra=_sifra;
set broj=broj+1;
END LOOP petlja;#obavezno
CLOSE autor_kursor;#obavezno
END$$#obavezno
delimiter ;


call inicijalni_dodatak();



update autor set dodatak='' where sifra in (1,2,15156);


#primjer procedure koja će u nadopuniti ne popunjene kolone
drop procedure if exists nadopuni_dodatak;
delimiter $$
CREATE PROCEDURE nadopuni_dodatak ()
BEGIN
DECLARE kraj INTEGER DEFAULT 0;
 DECLARE _sifra int;
 DECLARE broj int;
 DEClARE autor_kursor CURSOR FOR 
 select sifra from autor where dodatak is null or dodatak='' order by sifra;

 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET kraj = 1;
OPEN autor_kursor;

set broj=(select max(cast(substring(dodatak,2) as SIGNED)) 
from autor where dodatak is not null);

petlja: LOOP

FETCH autor_kursor INTO _sifra;

IF kraj = 1 THEN 
 LEAVE petlja;
 END IF;
set broj=broj+1;
update autor set dodatak=concat('A',broj) where sifra=_sifra;


END LOOP petlja;


CLOSE autor_kursor;

END$$

delimiter ;

#pozivanje procedure
call nadopuni_dodatak();
select * from autor;

# ručni backup
#mysqldump -uedunova -pedunova knjiznica > e:\knjiznica_backup.sql

#batch skripta koja se postavi u sceduler svaki dan
#@ECHO OFF
#for /f %%a in ('powershell -Command "Get-Date -format yyyy_MM_dd__HH_mm_ss"') do set datetime=%%a
#mysqldump -uedunova -pedunova knjiznica > e:\knjiznica_backup%datetime%.sql

#čisti dijakritike
DROP FUNCTION IF EXISTS cisti;
DELIMITER $$
CREATE FUNCTION cisti(t varchar(100))
  RETURNS varchar(100)
BEGIN
  RETURN replace(
replace(
replace(
replace(
replace(
replace(lower(t),'š','s'),'ć','c'),'ž','z'),'đ','d'),'č','c'),' ','');
END;
$$
DELIMITER ;


DROP FUNCTION IF EXISTS email;
DELIMITER $$
CREATE FUNCTION email(ime varchar(100),prezime varchar(100))
  RETURNS varchar(200)
BEGIN
  RETURN concat(cisti(ime),cisti(prezime),'@edunova.hr');
END;
$$
DELIMITER ;




#LOG MYSQL servera se omogućuje u my.ini datoteci bez znakova #
# The MySQL server
#[mysqld]
#....
#general_log=1
#general_log_file=c:\mysqllog.log



#u log će se spremati podaci definirani po trigerima
create table log(
tko varchar(100),
sto varchar(100),
kada datetime);


drop TRIGGER if exists insert_izdavac;
delimiter $$

CREATE TRIGGER insert_izdavac
before INSERT
   ON izdavac FOR EACH ROW

BEGIN

  
    insert into log(tko,sto,kada) values ('inser izdavac',new.naziv,now());

END$$

delimiter ;


drop TRIGGER if exists update_izdavac;
delimiter $$

CREATE TRIGGER update_izdavac
before UPDATE
   ON izdavac FOR EACH ROW

BEGIN

  
    insert into log(tko,sto,kada) values ('update izdavac',concat(old.naziv, ' : ',new.naziv),now());

END$$

delimiter ;



#update ako je uvjet u drugoj tablici

update autor a inner join katalog b on a.sifra=b.autor
inner join izdavac c on b.izdavac=c.sifra
set a.ime=replace(a.ime,'A','AA')
where c.aktivan=0;


#podupiti: svi autori koji nisu objavili niti jednu knjigu


select * from autor where sifra not in 
(select distinct autor from katalog where autor is not null);














#knjiznica
select * from katalog;

alter table katalog add column cijena decimal(18,2);

update katalog set cijena=rand()*100;

select a.ime,a.prezime,b.naslov, b.cijena
from autor a inner join katalog b on a.sifra=b.autor
where b.sifra<10;


select a.ime,a.prezime, sum(b.cijena)
from autor a inner join katalog b on a.sifra=b.autor
where b.sifra<10
group by a.ime,a.prezime
having sum(cijena)<200;

#classicmodels
select * from orderdetails;

select c.orderNumber, c.orderDate, sum(b.quantityOrdered*b.priceEach)
from products a inner join orderdetails b on a.productCode=b.productCode
inner join orders c on b.orderNumber=c.orderNumber
group by  c.orderNumber, c.orderDate
order by 2;

#edunovawp12
select a.naziv, count(b.polaznik)
from grupa a inner join clan b on a.sifra=b.grupa
group by a.naziv;

describe smjer;

insert into smjer (naziv)
select concat(ime,cast(rand() as char(10))) from osoba;

select * from smjer;

select naziv from smjer;

select upper(naziv) from smjer;

select ime,prezime from osoba;

select concat(ime, ' ',prezime) as imeprezime from osoba;


select left(ime,1), prezime from osoba;

select concat(left(ime,1), prezime, '@edunova.hr') from osoba;

select lower(concat(left(ime,1), prezime, '@edunova.hr')) from osoba;

select 
	replace(
		replace(
			replace(
				replace(
					replace(
						lower(
							concat(left(ime,1), prezime, '@edunova.hr'
							)
						),'š','s'
					),'đ','d'
				),'č','c'
			),'ć','c'
		) ,'ž','z'
	)
    as email 
from osoba;


DELIMITER $$
CREATE FUNCTION email(
ime varchar(50),
prezime varchar(50), 
domena varchar(50)) 
RETURNS varchar(50)
begin
return replace(
			replace(
				replace(
					replace(
						replace(
							lower(
								concat(left(ime,1), prezime, '@',domena
								)
							),'š','s'
						),'đ','d'
					),'č','c'
				),'ć','c'
			) ,'ž','z'
		);
end;
$$
DELIMITER ;

select email(ime,prezime,'edunova.hr') as email from osoba;

select email('grupa.',naziv,'edunova.hr') from grupa;

drop procedure mjesecnaObrada;
delimiter $$
CREATE procedure mjesecnaObrada()
BEGIN
drop table if exists posao;
create table posao
select ime as kolona from osoba;
insert into posao(kolona)
select naziv from smjer;
insert into posao(kolona)
select naziv from grupa;
insert into posao(kolona)
select brojugovora from polaznik;
insert into posao(kolona)
select ziroracun from predavac;
insert into posao(kolona)
select grupa from clan;
select * from posao;
end;
$$
DELIMITER ;

call mjesecnaObrada();

drop table log;
create table log(
user varchar(50),
tko varchar(50),
sto varchar(50),
kada timestamp default current_timestamp
);

select * from log;
insert into log(tko,sto) values ('Test','Test');

drop trigger insert_osoba;
delimiter $$

CREATE TRIGGER insert_osoba
after INSERT
   ON osoba FOR EACH ROW

BEGIN
    insert into log(user,tko,sto) values (CURRENT_USER(),'insert osoba',concat(new.ime, ' ', new.prezime));

END$$

delimiter ;

insert into osoba(oib,ime,prezime) values ('4585856961','Marija', 'Novalić');


drop trigger insert_grupa;
delimiter $$

CREATE TRIGGER insert_grupa
after INSERT
   ON grupa FOR EACH ROW

BEGIN
    insert into log(user,tko,sto) values (CURRENT_USER(),'insert grupa',new.naziv);

END$$

delimiter ;

insert into grupa (smjer,naziv,predavac) values (1,'WP16',1);


delimiter $$

CREATE TRIGGER update_grupa
after update
   ON grupa FOR EACH ROW

BEGIN
    insert into log(user,tko,sto) values (CURRENT_USER(),'promjena grupe',new.naziv);

END$$

delimiter ;


update grupa set brojpolaznika=15 where naziv='WP16';

create table smjer_log(
sto varchar(50),
sifra int,
naziv varchar(50),
trajanje int ,
cijena decimal(18,2),
upisnina decimal(18,2),
kada timestamp default current_timestamp);

insert into smjer_log
select 'inicijalni insert', a.*,now() from smjer a;

select * from smjer_log;

delimiter $$

CREATE TRIGGER insert_smjer
after INSERT
   ON smjer FOR EACH ROW

BEGIN
    insert into smjer_log(sto,sifra,naziv,trajanje,cijena,upisnina) 
    values ('insert smjer',new.sifra,new.naziv,new.trajanje,new.cijena,new.upisnina);

END$$

delimiter ;

insert into smjer(naziv) values('Serviseri');

delimiter $$

CREATE TRIGGER update_smjer
after update
   ON smjer FOR EACH ROW

BEGIN
    insert into smjer_log(sto,sifra,naziv,trajanje,cijena,upisnina) 
    values ('update smjer staro',old.sifra,old.naziv,old.trajanje,old.cijena,old.upisnina);
     insert into smjer_log(sto,sifra,naziv,trajanje,cijena,upisnina) 
    values ('update smjer novo',new.sifra,new.naziv,new.trajanje,new.cijena,new.upisnina);

END$$

delimiter ;

select * from smjer;

update smjer set trajanje=230 where sifra=65;


delimiter $$

CREATE TRIGGER delete_smjer
after delete
   ON smjer FOR EACH ROW

BEGIN
    insert into smjer_log(sto,sifra,naziv,trajanje,cijena,upisnina) 
    values ('delete smjer',old.sifra,old.naziv,old.trajanje,old.cijena,old.upisnina);

END$$

delimiter ;

delete from smjer where sifra=65;



create database skladiste;

delimiter $$
CREATE procedure arhiviraj()
BEGIN
create table skladiste.mjesec
select * from smjer where sifra>20;
delete from smjer where sifra>20;
end;
$$
DELIMITER ;

call arhiviraj();










#knjižnica
#Nazivi mjesta gdje šifra nije između 2000 i 3000
select * from mjesto
where sifra not between 2000 and 3000;

#Izlistajte sve neaktivne izdavače 
#koji nemaju šifre 346, 234, 589
select * from izdavac
where aktivan=0 and sifra not in (346, 234, 589);

create table nova
select a.prezime, 
count(b.naslov) as ukupno from autor a
inner join katalog b on a.sifra=b.autor
where a.prezime like '%a%'
group by a.prezime
having ukupno>1
order by ukupno desc, prezime desc limit 10,10;


alter table katalog add column cijena decimal(18,2);

update katalog set cijena=rand()*100;

select * from katalog;

select a.prezime, 
sum(b.cijena) as ukupno from autor a
inner join katalog b on a.sifra=b.autor
where a.prezime like '%a%'
group by a.prezime;


select min(cijena) from katalog;

select * from katalog order by cijena desc limit 1;



select ime, prezime from autor;

select ime, prezime, 
concat(left(lower(ime),1), lower(
replace(
replace(
replace(
replace(
replace(replace(upper(prezime),' ',''),'Č','C')
,'Š','S')
,'Đ','D')
,'Ć','C')
,'Ž','Z')
), '@edunova.hr') as email
from autor;


#kreiranje vlastite funkcije
#1. mjenjamo delimiter
# funkcija kada se pozove isiše broj 1
DELIMITER $$
CREATE FUNCTION email(ime varchar(50), prezime varchar(50)) RETURNS varchar(255)
begin

return concat(left(lower(ime),1), lower(
replace(
replace(
replace(
replace(
replace(replace(upper(prezime),' ',''),'Č','C')
,'Š','S')
,'Đ','D')
,'Ć','C')
,'Ž','Z')
), '@edunova.hr');
end;
$$
DELIMITER ;
select ime, prezime, email(ime,prezime) as email
from autor;
select ime, prezime, email(ime,concat(prezime,'_1')) as email
from autor;


#izvući iz tablice 4 slučajna retka

#select floor(rand()*10000 )+10000;
DELIMITER $$
drop procedure if exists slucajniRedovi;
CREATE PROCEDURE slucajniRedovi() 
BEGIN

	SET @ukupno = 0;
	create table tt(sifra int); 
		 WHILE(@ukupno < 4) DO
			insert into tt
			select sifra from autor where sifra in (floor(rand()*10000 )+10000);
			SET @ukupno = (select count(*) from tt);
            #select @ukupno;
		 END WHILE;
         
         select * from autor where sifra in (select sifra from tt);
         drop table tt;
END$$
DELIMITER ;

call slucajniRedovi();

#select * from tt;


create table logiranje(
tko varchar(255), 
sto varchar(255), 
kada datetime default now());


select now();

insert into logiranje (tko,sto) values ('ja','edunova');

#okidači - trigger
drop TRIGGER if exists insert_autor;
delimiter $$
CREATE TRIGGER insert_autor
before INSERT
   ON autor FOR EACH ROW
BEGIN

insert into logiranje values('osoba',new.ime,now());

END$$

delimiter ;

select * from logiranje;

insert into autor values (99999,'s','fsf',null);

#index
create index ai_1 on autor(ime);