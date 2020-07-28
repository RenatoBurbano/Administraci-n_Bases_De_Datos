CREATE TABLE [catalogo].[Producto]
(
[NumProducto] [int] NOT NULL,
[NombreProducto] [varchar] (30) COLLATE Modern_Spanish_CI_AS NULL,
[DescripProducto] [varchar] (60) COLLATE Modern_Spanish_CI_AS NULL,
[NumExistencias] [int] NULL
) ON [Secundario]
GO
ALTER TABLE [catalogo].[Producto] ADD CONSTRAINT [Unique_Identifier4] PRIMARY KEY CLUSTERED  ([NumProducto]) ON [Secundario]
GO
