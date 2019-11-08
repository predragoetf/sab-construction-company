
alter trigger ZaduzioUpdate
on Zaduzio
for update
as
begin
	declare @idSadrzi int
	declare @idZaposleni int
	declare @idZaduzio int
	declare @idMagacin int
	declare @idRoba int
	declare @dOd date
	declare @dDo date
	declare @postojiRed int
	

	select @idZaduzio= IdZaduzio, @dDo = DatumDo 
	from inserted

	select @idMagacin = IdMagacin, @idRoba = IdRoba
	from Zaduzio
	where IdZaduzio = @idZaduzio

	select @idZaposleni = IdZaposleni,  @dOd = DatumOd
	from Zaduzio
	where IdZaduzio = @idZaduzio

	if (@dDo is null)
	begin
		print 'nije unet datum'
		rollback transaction
		return
	end
	if (@dOd is null or @dOd>@dDo)
	begin
		print 'los datum'
		rollback transaction
		return
	end

	select @idSadrzi = IdSadrzi
	from Sadrzi
	where IdMagacin = @idMagacin
	and IdRoba = @idRoba

	if (@idSadrzi is null)
	begin
		insert into Sadrzi (IdMagacin, IdRoba, Kolicina, Tip)
		values (@idMagacin, @idRoba, 1,'J') 

		update Zaposleni
		set BrojZaduzeneOpreme = BrojZaduzeneOpreme - 1
		where IdZaposleni = @idZaposleni
	end
	else
	begin
		update Sadrzi
		set Kolicina = Kolicina + 1
		where IdSadrzi = @idSadrzi

		update Zaposleni
		set BrojZaduzeneOpreme = BrojZaduzeneOpreme - 1
		where IdZaposleni = @idZaposleni
	end

end