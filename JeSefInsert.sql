
alter trigger JeSefInsert
on JeSef
for insert
as
begin
	declare @idS int
	declare @idM int
	declare @cntM int
	declare @cntP int 
	declare @trenM int
	declare @cntVecSef int

	select @idS = IdZaposleni, @idM = IdMagacin
	from inserted
	print @idS
	print @idM

	select @cntM = count(*)
	from JeZaposlen 
	where IdZaposleni = @idS 

	select @cntP = count(*)
	from Posao P, RadiNa R
	where R.IdZaposleni = @idS and
	P.IdPosao = R.IdPosao and
	P.Status = 'U'

	select @cntVecSef = count(*)
	from JeSef
	where IdZaposleni = @idS

	print 'provera da li je vec zaposlen'
	print @cntM
	print @cntP
	if (@cntP > 0)
	begin
		print 'vec radi na nekom nezavrsenom poslu!'
		rollback transaction
		return
	end
	
	if (@cntVecSef > 1) 
	begin
		print 'vec je sef u nekom magacinu!'
		rollback transaction
		return
	end

	if (@cntM > 0)
	begin
		select @trenM = IdMagacin
		from JeZaposlen
		where IdZaposleni = @idS

		if (@trenM <> @idM)
		begin
			print 'vec radi u nekom magacinu!'
			rollback transaction
			return
		end
		else
		begin
			
			delete from JeZaposlen
			where IdZaposleni = @idS and
			IdMagacin = @idM
		end
	end
	/*else
	begin
		print 'onaj random insert'
		insert into JeZaposlen (IdZaposleni, IdMagacin)
		values (@idS, @idM)
	end*/

end