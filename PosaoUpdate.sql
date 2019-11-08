
alter trigger PosaoUpdate
on Posao
for update
as
begin
	declare @StatusS char
	declare @StatusN char
	declare @dOdS date
	declare @dOdN date
	declare @dDoS date
	declare @dDoN date

	declare @idPosao int

	select @StatusS = [Status], @dOdS = DatumOd, @dDoS = DatumDo, @idPosao = IdPosao
	from deleted

	select @StatusN = [Status], @dOdN = DatumOd, @dDoN = DatumDo
	from inserted

	if (@StatusS = 'Z')
		begin
			print 'ne moze se menjati zavrsen posao!'
			rollback transaction
			return
		end
	
	declare @minDatumOdZaposleni date

	select @minDatumOdZaposleni = MIN(DatumOd)
	from RadiNa
	where IdPosao = @idPosao

	declare @minDatumDoZaposleni date

	select @minDatumOdZaposleni = MAX(DatumDo)
	from RadiNa
	where IdPosao = @idPosao

	declare @maxDatumOdZaposleni date

	select @maxDatumOdZaposleni = MAX(DatumOd)
	from RadiNa
	where IdPosao = @idPosao

	declare @maxDatumDoZaposleni date

	select @maxDatumDoZaposleni = MAX(DatumDo)
	from RadiNa
	where IdPosao = @idPosao

	/*provera da li je promenjen datum pocetka, datum kraja ili status*/
	if update(DatumOd)
	begin	
	
		if (@dOdN is null)
		begin
			print 'nije setovan datum pocetka posla!'
			rollback transaction
			return
		end
					
		if (@dOdN is not null and @dOdN>@minDatumOdZaposleni)
		begin
			print 'posao ne moze pocinjati posle datuma pocetka zaposlenja nekog od zaposlenih na njemu!'
			rollback transaction
			return
		end

		if (@dOdN is not null and @dOdN>@minDatumDoZaposleni)
		begin
			print 'posao sigurno ne moze pocinjati posle datum zavrsetka zaposlenja nekog od zaposlenih na njemu!'
			rollback transaction
			return
		end
	end

	if update(DatumDo)
	begin				
		if (@dDoN is not null and @dDoN<@maxDatumOdZaposleni)
		begin
			print 'posao ne moze da se zavrsi pre pocetka zaposlenja nekog od zaposlenih na njemu!'
			rollback transaction
			return
		end

		if (@dDoN is not null and @dDoN<@maxDatumDoZaposleni)
		begin
			print 'posao sigurno ne moze da se zavrsi pre datuma zavrsetka zaposlenja nekog od zaposlenih na njemu!'
			rollback transaction
			return
		end

		/*zavrsavanje posla! sad treba svim zaposlenim na poslu postaviti datum zavrsetka rada i isplatiti im platu*/

		/*racunanje broja dana koliko je trajao posao*/
		declare @trajanjePosla int

		set @trajanjePosla = DATEDIFF(day, @dOdN, @dDoN) + 1

		/*racunanje jedinicne plate*/
		declare @jedinicnaPlata decimal(10,3)

		select @jedinicnaPlata = JedinicnaPlata
		from Norma
		where IdNorma = (select IdNorma from Posao where IdPosao = @idPosao)

		declare @idRadnik int
		declare @dOdRadnik date
		declare @dDoRadnik date
		declare @kursor cursor

		set @kursor = cursor for
		select IdZaposleni, DatumOd, DatumDo 
		from RadiNa
		where IdPosao = @idPosao 

		open @kursor

		fetch next from @kursor
		into @idRadnik, @dOdRadnik, @dDoRadnik

		while @@FETCH_STATUS = 0
		begin
			if (@dDoRadnik is null)
			begin
				print 'postavljanje DatumDo za zaposlenog'
				print @idRadnik
				update RadiNa
				set DatumDo = @dDoN
				where IdZaposleni = @idRadnik
			end

			declare @brDanaZapNaPoslu int

			/*isplacivanje zaposlenog ako mu je set-ovan DatumOd*/
			if (@dOdRadnik is not null)
			begin
				set @brDanaZapNaPoslu = DATEDIFF(day, @dOdRadnik, @dDoRadnik)+1;

				declare @prosecnaOcena decimal(10,3)
				declare @plata decimal(10,3)

				select @prosecnaOcena = ProsecnaOcena
				from Zaposleni
				where IdZaposleni = @idRadnik

				/*
				set @plata = @prosecnaOcena * 1.0 * @brDanaZapNaPoslu / @trajanjePosla * @jedinicnaPlata
				*/

				update Zaposleni
				set UkupnoIsplaceno = UkupnoIsplaceno + @prosecnaOcena * 1.0 * @brDanaZapNaPoslu / @trajanjePosla * @jedinicnaPlata
				where IdZaposleni = @idRadnik

			end

			fetch next from @kursor
			into @idRadnik, @dOdRadnik, @dDoRadnik

		end /*end za petlju*/

			close @kursor
			deallocate @kursor

			/*Zavrsavanje posla!*/
			update Posao
			set Status = 'Z'
			where IdPosao = @idPosao
			

	end



end