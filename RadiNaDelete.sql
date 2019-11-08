
alter trigger RadiNaDelete
on RadiNa
after delete
as
begin
	declare @idPosao int
	declare @idZaposleni int
	declare @ocena int
	declare @dOd date
	declare @dDo date

	select @idPosao = IdPosao
	from deleted


	/*provera da li je obrisan posao na kojem radi zaposleni, ako da, treba preracunati ponovo prosek*/
	declare @brP int

	select @brP = count(*)
	from Posao
	where IdPosao = @idPosao
	/*dohvatanje svih zaposlenih koji su izgubili ocene*/
	if (@brP = 0)
	begin
		/*novo racunanje proseka*/

		declare @kursor cursor

		set @kursor = cursor for
		select IdZaposleni
		from deleted

		open @kursor

		fetch next from @kursor 
		into @idZaposleni

		while @@FETCH_STATUS = 0
		begin

			declare @cnt int
			declare @sum int

			select @cnt = count(*)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and Ocena is not null		

			select @sum = sum(Ocena)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and Ocena is not null		
			
			declare @prosek decimal(10,3)

			if (@cnt = 0)
			begin
				set @prosek = 10
			end
			else
			begin
				set @prosek = @sum * 1.0 / @cnt
			end

			update Zaposleni
			set ProsecnaOcena = @prosek
			where IdZaposleni = @idZaposleni

			fetch next from @kursor 
			into @idZaposleni

		end

		close @kursor
		deallocate @kursor
	end

end