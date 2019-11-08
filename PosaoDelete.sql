
alter trigger PosaoDelete
on Posao
for delete
as
begin
	declare @Status char
	declare @idPosao int
	declare @idNorma int
	declare @idObjekat int
	declare @idSprat int

	select @Status = [Status], @idPosao = IdPosao, @idNorma = IdNorma, @idSprat = IdSprat
	from deleted

	select @idObjekat = IdObjekat
	from Sprat 
	where IdSprat = @idSprat

	if (@Status = 'Z')
	begin
		print 'zavrsen posao se ne sme brisati'
		rollback transaction
		return
	end

	/*ako se brise posao koji nije zavrsen, RI ce obrisati u RadiNa, ali moraju da se vrate svi uzeti materijali u magacin!*/

	declare @idMagacin int

	select @idMagacin = IdMagacin
	from Magacin M, Gradiliste G, Objekat O
	where O.IdObjekat = @idObjekat
	and O.IdGradiliste = G.IdGradiliste
	and M.IdGradiliste = G.IdGradiliste

	if (@idMagacin is not null)/*postoji magacin gde treba da se vrate materijali!*/
	begin
		
		declare @kursor cursor

		set @kursor = cursor for
		select IdRoba, Kolicina, Tip
		from PotrebanZa PZ, Norma N
		where PZ.IdNorma = N.IdNorma
		and N.IdNorma = @idNorma
		
		declare @idPotreban int
		declare @kolicinaPotreban decimal(10,3)
		declare @tipPotreban char

		open @kursor 

		fetch next from @kursor
		into @idPotreban, @kolicinaPotreban, @tipPotreban

		while @@FETCH_STATUS = 0
		begin
			declare @idSadrzi int

			select @idSadrzi = IdSadrzi
			from Sadrzi
			where IdRoba = @idPotreban 
			and IdMagacin = @idMagacin

			if (@idSadrzi is null)
			begin
				insert into Sadrzi (IdMagacin, IdRoba, Kolicina, Tip)
				values (@idMagacin, @idPotreban, @kolicinaPotreban, @tipPotreban)
			end
			else
			begin
				update Sadrzi
				set Kolicina = Kolicina + @kolicinaPotreban
				where IdSadrzi = @idSadrzi
			end
			
			
			fetch next from @kursor
			into @idPotreban, @kolicinaPotreban, @tipPotreban
		end

	end

end