
create procedure PlataSviMagacini
@ret int output
as
begin

	declare @kursor cursor
	declare @idM int
	

	set @kursor = cursor for
	select IdMagacin 
	from Magacin

	open @kursor

	fetch next from @kursor
	into @idM

	set @ret = 0

	while @@FETCH_STATUS = 0
	begin

		execute PlataMagacin @idM, @ret
		
		if (@ret = 1)
		begin
			close @kursor
			deallocate @kursor
			return 1
		end

		fetch next from @kursor
		into @idM

	end

	close @kursor
	deallocate @kursor


end