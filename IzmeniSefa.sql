

create procedure IzmeniSefa 
	@idMagacin int,
	@idSefN int,
	@ret int output
as
begin
	
	declare @cntM int
	declare @cntP int
	declare @cntVecSef int
	
	select @cntM = count(*)
	from JeZaposlen 
	where IdZaposleni = @idSefN 

	select @cntP = count(*)
	from Posao P, RadiNa R
	where R.IdZaposleni = @idSefN and
	P.IdPosao = R.IdPosao and
	P.Status = 'U'

	select @cntVecSef = count(*)
	from JeSef
	where IdZaposleni = @idSefN

	print 'provera da li je vec zaposlen'
	print @cntM
	print @cntP
	if (@cntP > 0)
	begin
		print 'vec radi na nekom nezavrsenom poslu!'
		set @ret = 1
		return
	end
	
	if (@cntVecSef > 0) 
	begin
		print 'vec je sef u nekom magacinu!'
		set @ret = 1
		return
	end

	if (@cntM > 0)
	begin
		
		declare @trenM int
		
		select @trenM = IdMagacin
		from JeZaposlen
		where IdZaposleni = @idSefN

		if (@trenM <> @idMagacin)
		begin
			print 'vec radi u nekom magacinu!'
			set @ret = 1
			return
		end
		else
		begin
			/*zaposleni u magacinu postaje sef u tom magacinu*/
			delete from JeZaposlen
			where IdZaposleni = @idSefN and
			IdMagacin = @idMagacin

			delete from JeSef
			where IdMagacin = @idMagacin

			insert into JeSef (IdMagacin, IdZaposleni)
			values (@idMagacin, @idSefN)

			set @ret = 0
			return

		end
	end

	delete from JeSef
	where IdMagacin = @idMagacin

	insert into JeSef (IdMagacin, IdZaposleni)
	values (@idMagacin, @idSefN)

	set @ret = 0
	return

end