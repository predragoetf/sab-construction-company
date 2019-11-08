
alter trigger ZaduzioInsert
on Zaduzio
for insert
as
begin
	declare @idZaposleni int
	declare @idSadrzi int
	declare @idMagacin int
	declare @idRoba int
	declare @tip varchar(50)
	declare @dOd date
	declare @dDo date
	declare @kolicina decimal

	select @idZaposleni = IdZaposleni, @idMagacin = IdMagacin, @idRoba = IdRoba
	from inserted

	select @idSadrzi = IdSadrzi
	from Sadrzi
	where IdMagacin = @idMagacin and
	IdRoba = @idRoba

	select @tip = T.Naziv 
	from Roba R, Tip T
	where IdRoba = @idRoba
	and R.IdTip = T.IdTip

	begin
		print 'usao'
	end

	if (@tip<>'HTZ' and @tip<>'alat')
	begin
		print 'los tip'
		print @tip
		rollback transaction
		return
	end

	select @kolicina = Kolicina
	from Sadrzi
	where IdSadrzi = @idSadrzi

	if (@kolicina>=1)
	begin
		if (@kolicina = 1)
		begin
			delete from Sadrzi
			where IdSadrzi = @idSadrzi

			print 'update zaposlenog br zaduz op'
			print @idZaposleni
			update Zaposleni
			set BrojZaduzeneOpreme = BrojZaduzeneOpreme + 1
			where IdZaposleni = @idZaposleni
			print 'gotov update zaposlenog br zaduz op'
		end
		else
		begin
			update Sadrzi
			set Kolicina = Kolicina - 1
			where IdSadrzi = @idSadrzi

			print 'update zaposlenog br zaduz op'
			print @idZaposleni
			update Zaposleni
			set BrojZaduzeneOpreme = BrojZaduzeneOpreme + 1
			where IdZaposleni = @idZaposleni
			print 'gotov update zaposlenog br zaduz op'
		end
	end
	else
	begin
		print 'nema dovoljno'
		rollback transaction
		return
	end

	

end