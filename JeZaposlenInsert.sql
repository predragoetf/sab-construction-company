

alter trigger JeZaposleniInsert
on JeZaposlen
for insert
as
begin
	declare @idS int
	declare @idM int
	declare @cntM int
	declare @cntP int 
	declare @cntVecSef int

	select @idS = IdZaposleni, @idM = IdMagacin
	from inserted

	select @cntM = count(*)
	from JeZaposlen 
	where IdZaposleni = @idS 

	select @cntVecSef = count(*)
	from JeSef
	where IdZaposleni = @idS 

	select @cntP = count(*)
	from Posao P, RadiNa R
	where R.IdZaposleni = @idS and
	P.IdPosao = R.IdPosao and
	P.Status = 'U'

	if (@cntVecSef > 0)
	begin
		print 'vec sef' 
		rollback transaction
		return
	end

	if (@cntP > 0)
	begin
		print 'vec radi na poslu'
		rollback transaction
		return
	end

	if (@cntM > 1)
	begin
		print 'vec radi u magacinu'
		rollback transaction
		return
	end
	
end