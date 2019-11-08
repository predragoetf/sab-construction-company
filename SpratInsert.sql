

alter trigger SpratInsert
on Sprat
for insert
as
begin
	declare @idO int
	declare @idS int
	declare @brSprata int
	declare @cnt int

	select @idO = IdObjekat, @brSprata = Broj, @idS = IdSprat
	from inserted

	select @cnt = BrojSpratova
	from Objekat
	where IdObjekat = @idO
	print @idO
	print @cnt

	if (@brSprata <> @cnt)
	begin
		rollback transaction
		return
	end

	update Objekat
	set BrojSpratova = BrojSpratova+1
	where IdObjekat = @idO
end