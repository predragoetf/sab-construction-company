
create trigger ObjekatInsert
on Objekat
for insert
as
begin
	
	declare @idO int
	declare @idG int

	select @idO = IdObjekat, @idG = IdGradiliste
	from inserted

	update Objekat
	set BrojSpratova = 0
	where IdObjekat = @idO

	update Gradiliste
	set BrojObjekata = BrojObjekata + 1
	where IdGradiliste = @idG

end