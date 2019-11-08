
create trigger ObjekatDelete
on Objekat
after delete
as
begin
declare @idGradiliste ID

	select @idGradiliste = IdGradiliste from deleted

	update Gradiliste
	set BrojObjekata = BrojObjekata - 1
	where IdGradiliste = @idGradiliste

end