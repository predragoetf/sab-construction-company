
create procedure PlataMagacin
@idMagacin int,
@ret int output
as
begin
	if not exists(select * 
				  from Magacin
				  where IdMagacin = @idMagacin)
	begin
		set @ret = 1
		return
	end

	declare @plata decimal

	select @plata = Plata
	from Magacin
	where IdMagacin = @idMagacin

	if (@plata is null)
	begin
		set @ret = 1
		return
	end
	else
	begin
		update Zaposleni
		set UkupnoIsplaceno = UkupnoIsplaceno + @plata
		where IdZaposleni IN 
		(select IdZaposleni from JeZaposlen where IdMagacin = @idMagacin)

		update Zaposleni
		set UkupnoIsplaceno = UkupnoIsplaceno + @plata
		where IdZaposleni IN (select IdZaposleni from JeSef where IdMagacin = @idMagacin)

		set @ret = 0
		return
	end
end