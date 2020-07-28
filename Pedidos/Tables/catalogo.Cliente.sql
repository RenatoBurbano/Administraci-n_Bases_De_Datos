CREATE TABLE [catalogo].[Cliente]
(
[NumCliente] [int] NOT NULL,
[NombreCliente] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL,
[DirecEnvio] [varchar] (50) COLLATE Modern_Spanish_CI_AS NULL,
[LimitCredito] [money] NULL,
[Descuento] [int] NULL,
[Ciudad] [varchar] (20) COLLATE Modern_Spanish_CI_AS NULL,
[CodigoGarante] [int] NOT NULL
) ON [Secundario]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE TRIGGER [catalogo].[ClienteIngresado] 

on [catalogo].[Cliente] for insert 

as 

declare @num_cli int, @cod_gar int 

select @num_cli = NumCliente, @cod_gar = CodigoGarante from inserted 

IF EXISTS (SELECT * FROM Deudor WHERE CodigoCliente = @cod_gar) 

BEGIN 

PRINT 'entro en el if' 

ROLLBACK TRANSACTION 

END 

ELSE 

BEGIN 

PRINT 'entro en el else' 

END 

GO
ALTER TABLE [catalogo].[Cliente] ADD CONSTRAINT [Unique_Identifier1] PRIMARY KEY CLUSTERED  ([NumCliente]) ON [Secundario]
GO
CREATE NONCLUSTERED INDEX [IX_Puede Ser] ON [catalogo].[Cliente] ([CodigoGarante]) ON [Secundario]
GO
ALTER TABLE [catalogo].[Cliente] ADD CONSTRAINT [Puede Ser] FOREIGN KEY ([CodigoGarante]) REFERENCES [catalogo].[Cliente] ([NumCliente])
GO
