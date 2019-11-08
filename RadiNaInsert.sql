

alter trigger RadiNaInsert
on RadiNa
for insert
as 
begin
	declare @dOd date
	declare @idZaposleni int
	declare @idPosao int

	select @dOd = DatumOd, @idZaposleni = IdZaposleni, @idPosao = IdPosao
	from inserted

	declare @dOdPosao date
	declare @Status char

	select @dOdPosao = DatumOd, @Status = [Status]
	from Posao
	where IdPosao = @idPosao

	if (@Status<>'U')
	begin
		print 'posao nije u toku'
		rollback transaction
		return
	end

	if (@dOd<@dOdPosao)
	begin
		print 'ne moze biti datum pocetka rada pre datuma zapocinjanja posla!'
		rollback transaction
		return
	end
	
	/*provera da li negde vec radi*/
	declare @brSef int
	declare @brZap int
	declare @brRad int

	select @brSef = count(*)
	from JeSef
	where IdZaposleni = @idZaposleni

	select @brZap = count(*)
	from JeZaposlen 
	where IdZaposleni = @idZaposleni

	select @brRad = count (*)
	from RadiNa R, Posao P
	where R.IdPosao = P.IdPosao
	and R.IdZaposleni = @idZaposleni
	and P.Status = 'U'

	if (@brSef<>0)
	begin
		print 'zaposleni je vec sef!'
		rollback transaction
		return
	end

	if (@brZap<>0)
	begin
		print 'zaposleni vec radi u magacinu!'
		rollback transaction
		return
	end

	if (@brRad>1)
	begin
		print 'zaposleni vec radi na nekom poslu!'
		rollback transaction
		return
	end

end