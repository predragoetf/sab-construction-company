use gradjevina2
go

delete from RadiNa
DISABLE TRIGGER  ALL ON Zaduzio; 
delete from Zaduzio
ENABLE TRIGGER  ALL ON Zaduzio;
delete from PotrebanZa
delete from JeSef
delete from JeZaposlen
delete from Zaposleni
DISABLE TRIGGER  ALL ON Posao;  
delete from Posao
ENABLE TRIGGER  ALL ON Posao;
DISABLE TRIGGER  ALL ON Sprat;
delete from Sprat
ENABLE TRIGGER  ALL ON Sprat;
delete from Objekat
delete from Norma
delete from Sadrzi
delete from Magacin
delete from Roba
delete from Tip
delete from Gradiliste