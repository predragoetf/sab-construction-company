
/*Okida se kad se obrise Roba, Magacin ili Zaposleni! Proverava ko ga je okinuo.*/
create trigger [dbo].[ZaduzioDelete]
on [dbo].[Zaduzio]
after delete
as
begin
	declare @idMagacin int
	declare @idRoba int
	declare @idZaposleni int
	declare @dDo date
	declare @cntM int
	declare @cntR int
	declare @cntZ int
	declare @kursor cursor

	set @kursor = cursor for
	select IdZaposleni, IdMagacin, IdRoba, DatumDo
	from deleted
	/*U petlji obradjujemo jedno po jedno brisanje tako sto ispitamo zasto se brise!*/

	/* TODO: Uzeti u obzir da treba da se uvek proveri da li je datumDo null, pa samo ako nije, onda azurirati BrojZaduzeneOpreme! */
	open @kursor
	fetch next from @kursor
	into @idZaposleni, @idMagacin, @idRoba, @dDo

	while @@FETCH_STATUS = 0
	begin

		select @cntR = count(*)
		from Roba
		where IdRoba = @idRoba

		select @cntM = count(*)
		from Magacin
		where IdMagacin = @idMagacin

		select @cntZ = count(*)
		from Zaposleni
		where IdZaposleni = @idZaposleni

		if (@cntR = 0)
		begin
			/*Obrisana roba! Treba da se zaposlenom koji drzi tu robu smanji broj zaduzene opreme, ako vec nije vratio tu opremu!  */
			if (@dDo is null)
			begin
				update Zaposleni
				set BrojZaduzeneOpreme = BrojZaduzeneOpreme - 1
				where IdZaposleni = @idZaposleni
			end
			
		end

		if (@cntM = 0)
		begin
			/*Obrisan magacin! Treba da se svim zaposlenim koji drze tu robu smanji broj zaduzene opreme */
			if (@dDo is null)
			begin
				update Zaposleni
				set BrojZaduzeneOpreme = BrojZaduzeneOpreme - 1
				where IdZaposleni = @idZaposleni
			end		
		end

		if (@cntZ = 0)
		begin

			if(@dDo is null)
			begin
			/*Obrisan zaposleni! Vratiti jednu jedinicu robe u magacin za svako njegovo zaduzenje! */
				if exists (select * from Sadrzi where IdMagacin = @idMagacin and IdRoba = @idRoba)
				begin
					update Sadrzi
					set Kolicina = Kolicina + 1
					where IdRoba = @idRoba and
					IdMagacin = @idMagacin
				
				end
				else
				begin
					insert into Sadrzi(IdMagacin, IdRoba, Kolicina, Tip)
					values (@idMagacin, @idRoba, 1, 'J')
				end
			end
		end

		fetch next from @kursor
		into @idZaposleni, @idMagacin, @idRoba
	end

	close @kursor
	deallocate @kursor

end