
alter trigger PosaoInsert
on Posao
for insert
as
begin
	declare @idP int
	declare @idS int
	declare @dOd date
	declare @dGrad date
	declare @idN int
	declare @idO int

	select @idP = IdPosao, @dOd = DatumOd, @idS = IdSprat, @idN = IdNorma
	from inserted

	select @idO = IdObjekat
	from Sprat 
	where IdSprat = @idS

	select @dGrad = G.DatumOsnivanja
	from Gradiliste G, Objekat O
	where O.IdGradiliste = G.IdGradiliste
	and O.IdObjekat = @idO

	if (@dOd < @dGrad)
	begin
		print 'ne moze se poceti sa poslom na gradilistu koje jos nije osnovano'
		rollback transaction
		return 
	end

	/*provere da li ima dovoljno materijala, pa ako ima uzimanje materijala!*/
	declare @kursor cursor

	set @kursor = cursor for
	select IdRoba, Kolicina 
	from PotrebanZa PZ, Norma N
	where N.IdNorma = PZ.IdNorma and
	N.IdNorma = @idN

	open @kursor

	declare @idPotrebno int
	declare @kolicinaPotrebno decimal(10,3) 
	declare @kolicinaDostupno decimal(10,3)

	fetch next from @kursor
	into @idPotrebno, @kolicinaPotrebno	

	declare @idMagacin int

	select @idMagacin = M.IdMagacin
	from Magacin M, Gradiliste G, Objekat O
	where M.IdGradiliste = G.IdGradiliste
	and G.IdGradiliste = O.IdGradiliste
	and O.IdObjekat = @idO

	if (@idMagacin is null)
	begin 
		print 'ne postoji magacin na gradilistu!'
		rollback transaction
		return
	end

	while @@FETCH_STATUS = 0
	begin
		select @kolicinaDostupno = Kolicina
		from Sadrzi
		where IdMagacin = @idMagacin 
		and IdRoba = @idPotrebno

		if (@kolicinaDostupno is null)
		begin
			print 'nema uopste resursa'
			print @idPotrebno
			rollback transaction
			return
		end

		if (@kolicinaDostupno<@kolicinaPotrebno)
		begin
			print 'nema dovoljno resursa'
			rollback transaction
			return
		end

		fetch next from @kursor
		into @idPotrebno, @kolicinaPotrebno

	end

	close @kursor
	deallocate @kursor
	/*ako smo dosli do ove linije, znaci da ima dovoljno svih resursa u skladistu!*/

	declare @kursor2 cursor

	set @kursor2 = cursor for
	select IdRoba, Kolicina 
	from PotrebanZa PZ, Norma N
	where N.IdNorma = PZ.IdNorma and
	N.IdNorma = @idN

	open @kursor2

	fetch next from @kursor2
	into @idPotrebno, @kolicinaPotrebno

	while @@FETCH_STATUS = 0
	begin
		update Sadrzi
		set Kolicina = Kolicina - @kolicinaPotrebno
		where IdMagacin = @idMagacin 
		and IdRoba = @idPotrebno

		fetch next from @kursor2
		into @idPotrebno, @kolicinaPotrebno

	end
	/*gotovo uzimanje resursa*/


	update [Posao]
	set [Status] = 'U'
	where IdPosao = @idP


end