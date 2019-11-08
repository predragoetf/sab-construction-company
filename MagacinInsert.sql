
alter trigger MagacinInsert
on Magacin
for insert
as
begin
	declare @brMag int
	declare @IdG int

	select @IdG = IdGradiliste
	from inserted

	select @brMag = count(*)
	from Magacin 
	where IdGradiliste = @IdG

	if (@brMag > 1 )
	begin
		rollback transaction
		return
	end


end