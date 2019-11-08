
create trigger MagacinDelete
on Magacin
for delete
as
begin
	declare @idM int
	declare @brzap int
	declare @brsef int
	declare @brrobe int

	select @idM = IdMagacin
	from deleted

	select @brzap = count(*)
	from JeZaposlen
	where IdMagacin = @idM

	select @brsef = count(*)
	from JeSef
	where IdMagacin = @idM

	select @brrobe = count(*)
	from Sadrzi
	where IdMagacin = @idM

	if (@brzap<>0 or @brsef<>0 or @brrobe<>0)
	begin
		rollback transaction
		return
	end

end