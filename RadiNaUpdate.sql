

alter trigger RadiNaUpdate
on RadiNa
for update
as
begin
	/*proveriti da li je promenjen datum od, datum do ili ocena*/
	declare @OcenaS int
	declare @dOdS date
	declare @dDoS date
	declare @OcenaN int
	declare @dOdN date
	declare @dDoN date

	declare @idZaposleni int
	declare @idPosao int
	declare @idRadiNa int

	

	select @OcenaS = Ocena, @dOdS = DatumOd, @dDoS = DatumDo, @idRadiNa = IdRadiNa
	from deleted

	select @OcenaN = Ocena, @dOdN = DatumOd, @dDoN = DatumDo, @idPosao = IdPosao, @idZaposleni = IdZaposleni
	from inserted

	declare @datumOdPosao date
	declare @datumDoPosao date

	select @datumOdPosao = DatumOd, @datumDoPosao = DatumDo
	from Posao where IdPosao = @idPosao

	if ( @OcenaN is null)
	begin
		if (@OcenaS is not null)
		begin
			/*Nije bila null, sad jeste, znaci brisanje ocene. Proveriti da li je poslednja ocena za tog radnika, ako jeste setovati prosek na 10.00!*/
			declare @cnt int
			declare @sum int

			select @cnt = count(*)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and Ocena is not null
			and IdRadiNa <> @idRadiNa

			select @sum = sum(Ocena)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and Ocena is not null
			and IdRadiNa <> @idRadiNa
			
			declare @prosek decimal(10,3)

			if (@cnt = 0)
			begin
				set @prosek = 10
			end
			else
			begin
				set @prosek =  @sum * 1.0 / @cnt
			end

			update Zaposleni
			set ProsecnaOcena = @prosek
			where IdZaposleni = @idZaposleni

			

		end
		/*Inace znaci da ocena nije menjana!*/
	end
	else /*Nova ocena nije null*/
	begin
		/*U svakom slucaju potrebno preracunati novu*/

		if ( @OcenaS is null or @OcenaN <> @OcenaS)
			begin
			select @cnt = count(*)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and	Ocena is not null
		
			select @sum = sum(Ocena)
			from RadiNa
			where IdZaposleni = @idZaposleni
			and Ocena is not null

			if (@cnt = 0)
			begin
				set @prosek = 10
			end
			else
			begin
				set @prosek =  @sum * 1.0 / @cnt
			end

			update Zaposleni
			set ProsecnaOcena = @prosek
			where IdZaposleni = @idZaposleni
		
		end		
	end

	if update(DatumOd)
	begin
		/*promenjen datum od, prvo proveriti da li to sme da se radi (da li je posao u toku)*/

		declare @posaoStatus char

		select @posaoStatus = [Status]
		from Posao
		where IdPosao = @idPosao

		if (@posaoStatus <> 'U' )
		begin
			rollback transaction
			return
		end

		if (@dOdN is not null)
		begin
			if ((@datumOdPosao is not null) and (@datumOdPosao>@dOdN))
			begin
				print 'novi datum ne sme biti pre pocetka posla!'
				rollback transaction
				return
			end
		end

	end

	if update(DatumDo)
	begin
		/*promenjen datum od, prvo proveriti da li to sme da se radi (da li je posao u toku)*/

		select @posaoStatus = [Status]
		from Posao
		where IdPosao = @idPosao

		if (@posaoStatus <> 'U' )
		begin
			rollback transaction
			return
		end

		if (@dDoN is not null)
		begin
			if ((@datumOdPosao is not null) and (@datumOdPosao>@dDoN))
			begin
				print 'novi datum ne sme biti pre pocetka posla!'
				rollback transaction
				return
			end
		end
	end

	if (@dOdN is not null and @dDoN is not null and @dDoN<@dOdN)
	begin
		print 'Ne moze datumOd da bude posle datumDo!'
		rollback transaction
		return
	end


end