
create trigger ZaposleniInsert 
on Zaposleni
for insert
as
begin
	declare @IdZaposleni int

	select @IdZaposleni = IdZaposleni
	from inserted

	update Zaposleni
	set ProsecnaOcena = 10,
		BrojZaduzeneOpreme = 0,
		UkupnoIsplaceno = 0
	where IdZaposleni = @IdZaposleni

end

