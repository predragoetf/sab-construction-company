
create trigger ZaposleniUpdate
on Zaposleni
for update
as
begin
	declare @IdZaposleniS int
	declare @IdZaposleniN int
	declare @iznosS decimal
	declare @iznosN decimal

	select @IdZaposleniN = IdZaposleni, @iznosN = UkupnoIsplaceno
	from inserted
	select @IdZaposleniS = IdZaposleni, @iznosS = UkupnoIsplaceno
	from deleted
	
	begin
		print 'update zaposleni'
	end

	if (@iznosN < @iznosS)
	begin
		rollback transaction
		return
	end

end