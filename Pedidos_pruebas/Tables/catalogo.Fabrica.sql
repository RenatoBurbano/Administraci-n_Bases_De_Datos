CREATE TABLE [catalogo].[Fabrica]
(
[NumFabrica] [int] NOT NULL,
[Contacto] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL,
[NombreFabrica] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL,
[Telefono1] [varchar] (10) COLLATE Modern_Spanish_CI_AS NULL,
[Telefono2] [varchar] (10) COLLATE Modern_Spanish_CI_AS NULL
) ON [Secundario]
GO
ALTER TABLE [catalogo].[Fabrica] ADD CONSTRAINT [Unique_Identifier5] PRIMARY KEY CLUSTERED  ([NumFabrica]) ON [Secundario]
GO
