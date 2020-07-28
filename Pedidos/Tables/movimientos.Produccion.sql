CREATE TABLE [movimientos].[Produccion]
(
[CantidadProducto] [bigint] NULL,
[FechaProduccion] [date] NULL,
[NumProducto] [int] NOT NULL,
[NumFabrica] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[Produccion] ADD CONSTRAINT [Unique_Identifier6] PRIMARY KEY CLUSTERED  ([NumProducto], [NumFabrica]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[Produccion] ADD CONSTRAINT [Esta] FOREIGN KEY ([NumProducto]) REFERENCES [catalogo].[Producto] ([NumProducto])
GO
ALTER TABLE [movimientos].[Produccion] ADD CONSTRAINT [Tiene] FOREIGN KEY ([NumFabrica]) REFERENCES [catalogo].[Fabrica] ([NumFabrica])
GO
