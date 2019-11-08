
create trigger SadrziUpdate
on Sadrzi
for update 
as
begin
	declare @kursor cursor
	declare @idSadrzi int
	declare @Kolicina decimal

	set @kursor = cursor for
	select IdSadrzi, Kolicina 
	from inserted

	open @kursor

	fetch next from @kursor
	into @idSadrzi, @Kolicina

	while @@FETCH_STATUS = 0
	begin
		if (@Kolicina=0)
		begin
			delete from Sadrzi
			where IdSadrzi = @idSadrzi
		end

		fetch next from @kursor
		into @idSadrzi, @Kolicina
	end

	close @kursor
	deallocate @kursor

end