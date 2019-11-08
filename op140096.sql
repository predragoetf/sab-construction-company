use gradjevina2
go


CREATE TYPE [Id]
	FROM INTEGER NULL
go

CREATE TYPE [max50chars]
	FROM VARCHAR(50) NULL
go

CREATE TYPE [nenegativanN]
	FROM INTEGER NULL
go

CREATE TYPE [nenegativanR]
	FROM DECIMAL(10,3) NULL
go

CREATE TYPE [Ocena]
	FROM INTEGER NULL
go

CREATE TABLE [Gradiliste]
( 
	[IdGradiliste]       [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Naziv]              [max50chars] ,
	[DatumOsnivanja]     datetime  NULL ,
	[BrojObjekata]       [nenegativanN] 
)
go

ALTER TABLE [Gradiliste]
	ADD CONSTRAINT [XPKGradiliste] PRIMARY KEY  CLUSTERED ([IdGradiliste] ASC)
go

CREATE TABLE [JeSef]
( 
	[IdZaposleni]        [Id]  NOT NULL ,
	[IdMagacin]          [Id]  NOT NULL 
)
go

ALTER TABLE [JeSef]
	ADD CONSTRAINT [XPKJeSef] PRIMARY KEY  CLUSTERED ([IdMagacin] ASC)
go

CREATE TABLE [JeZaposlen]
( 
	[IdMagacin]          [Id]  NOT NULL ,
	[IdZaposleni]        [Id]  NOT NULL 
)
go

ALTER TABLE [JeZaposlen]
	ADD CONSTRAINT [XPKJeZaposlen] PRIMARY KEY  CLUSTERED ([IdZaposleni] ASC)
go

CREATE TABLE [Magacin]
( 
	[IdMagacin]          [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Plata]              [nenegativanN] ,
	[IdGradiliste]       [Id]  NOT NULL 
)
go

ALTER TABLE [Magacin]
	ADD CONSTRAINT [XPKMagacin] PRIMARY KEY  CLUSTERED ([IdMagacin] ASC)
go

CREATE TABLE [Norma]
( 
	[IdNorma]            [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Naziv]              [max50chars] ,
	[Cena]               [nenegativanR] ,
	[JedinicnaPlata]     [nenegativanR] 
)
go

ALTER TABLE [Norma]
	ADD CONSTRAINT [XPKNorma] PRIMARY KEY  CLUSTERED ([IdNorma] ASC)
go

CREATE TABLE [Objekat]
( 
	[IdObjekat]          [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Naziv]              [max50chars] ,
	[BrojSpratova]       [nenegativanN] ,
	[IdGradiliste]       [Id]  NOT NULL 
)
go

ALTER TABLE [Objekat]
	ADD CONSTRAINT [XPKObjekat] PRIMARY KEY  CLUSTERED ([IdObjekat] ASC)
go

CREATE TABLE [Posao]
( 
	[IdPosao]            [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Status]             char(1)  NULL 
	CONSTRAINT [statusPoslaOk_2008314230]
		CHECK  ( [Status]='Z' OR [Status]='U' ),
	[DatumOd]            datetime  NULL ,
	[DatumDo]            datetime  NULL ,
	[IdNorma]            [Id]  NOT NULL ,
	[IdSprat]            [Id] 
)
go

ALTER TABLE [Posao]
	ADD CONSTRAINT [XPKPosao] PRIMARY KEY  CLUSTERED ([IdPosao] ASC)
go

CREATE TABLE [PotrebanZa]
( 
	[Kolicina]           [nenegativanR] ,
	[IdRoba]             [Id]  NOT NULL ,
	[IdNorma]            [Id]  NOT NULL ,
	[Tip]                char(1)  NULL 
	CONSTRAINT [ogranicenjeKolicinaBroj_952807354]
		CHECK  ( [Tip]='J' OR [Tip]='K' ),
	[IdPotrebanZa]       [Id]  NOT NULL  IDENTITY ( 1,1 ) 
)
go

ALTER TABLE [PotrebanZa]
	ADD CONSTRAINT [XPKPotrebanZa] PRIMARY KEY  CLUSTERED ([IdPotrebanZa] ASC)
go

ALTER TABLE [PotrebanZa]
	ADD CONSTRAINT [XAK1PotrebanZa] UNIQUE ([IdNorma]  ASC,[IdRoba]  ASC)
go

CREATE TABLE [RadiNa]
( 
	[DatumOd]            datetime  NULL ,
	[DatumDo]            datetime  NULL ,
	[IdPosao]            [Id]  NOT NULL ,
	[IdZaposleni]        [Id]  NOT NULL ,
	[Ocena]              [Ocena] ,
	[IdRadiNa]           [Id]  NOT NULL  IDENTITY ( 1,1 ) 
)
go

ALTER TABLE [RadiNa]
	ADD CONSTRAINT [XPKRadiNa] PRIMARY KEY  CLUSTERED ([IdRadiNa] ASC)
go

ALTER TABLE [RadiNa]
	ADD CONSTRAINT [XAK1RadiNa] UNIQUE ([IdPosao]  ASC,[IdZaposleni]  ASC)
go

CREATE TABLE [Roba]
( 
	[IdRoba]             [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Naziv]              [max50chars] ,
	[Kod]                [max50chars] ,
	[IdTip]              [Id] 
)
go

ALTER TABLE [Roba]
	ADD CONSTRAINT [XPKRoba] PRIMARY KEY  CLUSTERED ([IdRoba] ASC)
go

CREATE TABLE [Sadrzi]
( 
	[IdMagacin]          [Id]  NOT NULL ,
	[IdRoba]             [Id]  NOT NULL ,
	[Kolicina]           char(18)  NULL ,
	[Tip]                char(1)  NULL 
	CONSTRAINT [ogranicenjeKolicinaBroj_161333685]
		CHECK  ( [Tip]='J' OR [Tip]='K' ),
	[IdSadrzi]           [Id]  NOT NULL  IDENTITY ( 1,1 ) 
)
go

ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [XPKSadrzi] PRIMARY KEY  CLUSTERED ([IdSadrzi] ASC)
go

ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [XAK1Sadrzi] UNIQUE ([IdRoba]  ASC,[IdMagacin]  ASC)
go

CREATE TABLE [Sprat]
( 
	[Broj]               [nenegativanN] ,
	[IdObjekat]          [Id]  NOT NULL ,
	[IdSprat]            [Id]  NOT NULL  IDENTITY ( 1,1 ) 
)
go

ALTER TABLE [Sprat]
	ADD CONSTRAINT [XPKSprat] PRIMARY KEY  CLUSTERED ([IdSprat] ASC)
go

ALTER TABLE [Sprat]
	ADD CONSTRAINT [XAK1Sprat] UNIQUE ([Broj]  ASC,[IdObjekat]  ASC)
go

CREATE TABLE [Tip]
( 
	[IdTip]              [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Naziv]              char(18)  NULL 
	CONSTRAINT [proveraTipRobe_50374755]
		CHECK  ( [Naziv]='HTZ' OR [Naziv]='alat' OR [Naziv]='materijal' )
)
go

ALTER TABLE [Tip]
	ADD CONSTRAINT [XPKTip] PRIMARY KEY  CLUSTERED ([IdTip] ASC)
go

CREATE TABLE [Zaduzio]
( 
	[DatumOd]            datetime  NULL ,
	[DatumDo]            datetime  NULL ,
	[IdZaposleni]        [Id]  NOT NULL ,
	[Napomena]           [max50chars] ,
	[IdZaduzio]          [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[IdMagacin]          [Id] ,
	[IdRoba]             [Id] 
)
go

ALTER TABLE [Zaduzio]
	ADD CONSTRAINT [XPKZaduzio] PRIMARY KEY  CLUSTERED ([IdZaduzio] ASC)
go

CREATE TABLE [Zaposleni]
( 
	[IdZaposleni]        [Id]  NOT NULL  IDENTITY ( 1,1 ) ,
	[Ime]                [max50chars] ,
	[Prezime]            [max50chars] ,
	[JMBG]               [max50chars] ,
	[Pol]                char(1)  NULL 
	CONSTRAINT [dozvoljenPol_2034932114]
		CHECK  ( [Pol]='M' OR [Pol]='Z' ),
	[ZiroRacun]          [max50chars] ,
	[Email]              [max50chars] ,
	[BrojTelefona]       [max50chars] ,
	[ProsecnaOcena]      [nenegativanR] ,
	[BrojZaduzeneOpreme] [nenegativanN] ,
	[UkupnoIsplaceno]    [nenegativanR] 
)
go

ALTER TABLE [Zaposleni]
	ADD CONSTRAINT [XPKZaposleni] PRIMARY KEY  CLUSTERED ([IdZaposleni] ASC)
go


ALTER TABLE [JeSef]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([IdZaposleni]) REFERENCES [Zaposleni]([IdZaposleni])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [JeSef]
	ADD CONSTRAINT [R_21] FOREIGN KEY ([IdMagacin]) REFERENCES [Magacin]([IdMagacin])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [JeZaposlen]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([IdMagacin]) REFERENCES [Magacin]([IdMagacin])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [JeZaposlen]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([IdZaposleni]) REFERENCES [Zaposleni]([IdZaposleni])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Magacin]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([IdGradiliste]) REFERENCES [Gradiliste]([IdGradiliste])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Objekat]
	ADD CONSTRAINT [R_9] FOREIGN KEY ([IdGradiliste]) REFERENCES [Gradiliste]([IdGradiliste])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Posao]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([IdSprat]) REFERENCES [Sprat]([IdSprat])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Posao]
	ADD CONSTRAINT [R_16] FOREIGN KEY ([IdNorma]) REFERENCES [Norma]([IdNorma])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [PotrebanZa]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([IdRoba]) REFERENCES [Roba]([IdRoba])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [PotrebanZa]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([IdNorma]) REFERENCES [Norma]([IdNorma])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [RadiNa]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([IdPosao]) REFERENCES [Posao]([IdPosao])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [RadiNa]
	ADD CONSTRAINT [R_19] FOREIGN KEY ([IdZaposleni]) REFERENCES [Zaposleni]([IdZaposleni])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Roba]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdTip]) REFERENCES [Tip]([IdTip])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([IdMagacin]) REFERENCES [Magacin]([IdMagacin])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Sadrzi]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([IdRoba]) REFERENCES [Roba]([IdRoba])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Sprat]
	ADD CONSTRAINT [R_12] FOREIGN KEY ([IdObjekat]) REFERENCES [Objekat]([IdObjekat])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Zaduzio]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([IdZaposleni]) REFERENCES [Zaposleni]([IdZaposleni])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Zaduzio]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([IdMagacin]) REFERENCES [Magacin]([IdMagacin])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Zaduzio]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([IdRoba]) REFERENCES [Roba]([IdRoba])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go