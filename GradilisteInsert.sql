

create trigger GradilisteInsert
on Gradiliste
for insert
as
begin
	declare @IdGradiliste  int

	select @IdGradiliste = IdGradiliste from inserted

	update Gradiliste 
	set BrojObjekata = 0
	where IdGradiliste = @IdGradiliste

	return

end