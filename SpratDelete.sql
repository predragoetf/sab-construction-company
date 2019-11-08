
alter trigger SpratDelete
on Sprat
for delete
as
begin
	declare @idO int
	declare @brSprata int
	declare @cnt int

	select @idO = IdObjekat, @brSprata = Broj
	from deleted

	select @cnt = BrojSpratova
	from Objekat
	where IdObjekat = @idO

	if (@brSprata <> @cnt-1)
	begin
		rollback transaction
		return
	end

	update Objekat
	set BrojSpratova = BrojSpratova-1
	where IdObjekat = @idO


end