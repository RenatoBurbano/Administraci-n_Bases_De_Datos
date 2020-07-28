CREATE TABLE [movimientos].[CuerpoPedido]
(
[PrecioUnitario] [money] NULL,
[Cantidad] [int] NULL,
[NumProducto] [int] NOT NULL,
[NumPedido] [int] NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TRIGGER [movimientos].[CK_CuerpoPedidoInsertado] 
on [movimientos].[CuerpoPedido] for insert 
as 
declare @pre_uni money, @cant int, @num_pro int, @num_ped int, @num_cli int, @lim_cred money, @sal_deu money 
select @pre_uni = PrecioUnitario, @cant = Cantidad, @num_pro = NumProducto, @num_ped = NumPedido from inserted 
select @num_cli = (select NumCliente from movimientos.CabeceraPedido where NumPedido = @num_ped) 
select @lim_cred = (select LimitCredito from catalogo.Cliente where NumCliente = @num_cli) 
select @sal_deu = (select SaldoDeudor from Deudor where CodigoCliente = @num_cli) 
update movimientos.CabeceraPedido set MontoTotal = MontoTotal + (@cant * @pre_uni) where NumPedido = @num_ped 
IF (@lim_cred - @sal_deu) >= @cant * @pre_uni 
BEGIN 
update Deudor set SaldoDeudor = SaldoDeudor + (@cant * @pre_uni) where CodigoCliente = @num_cli 
END 
ELSE 
BEGIN 
ROLLBACK TRANSACTION 
END 
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [movimientos].[TR_ProductoActualizado] 

on [movimientos].[CuerpoPedido] for update 

as 

declare @pre_uni money, @cant int, @num_pro int, @num_pedi int 

select @pre_uni = PrecioUnitario, @cant = Cantidad, @num_pro = NumProducto, @num_pedi = NumPedido from inserted 

update movimientos.CabezaCuerpoP set PrecioUnitario = @pre_uni, Cantidad = @cant where NumPedido = @num_pedi and NumProducto = @num_pro  

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [movimientos].[TR_ProductoEliminado] 

on [movimientos].[CuerpoPedido] for delete 

as 

declare @pre_uni money, @cant int, @num_pro int, @num_pedi int 

select @pre_uni = PrecioUnitario, @cant = Cantidad, @num_pro = NumProducto, @num_pedi = NumPedido from deleted 

delete from movimientos.CabezaCuerpoP where PrecioUnitario = @pre_uni and Cantidad = @cant and NumPedido = @num_pedi and NumProducto = @num_pro  

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [movimientos].[TR_ProductoInsertado] 

on [movimientos].[CuerpoPedido] for insert 

as 

declare @pre_uni money, @cant int, @num_pro int, @num_pedi int 

select @pre_uni = PrecioUnitario, @cant = Cantidad, @num_pro = NumProducto, @num_pedi = NumPedido from inserted 

update movimientos.CabezaCuerpoP set PrecioUnitario = @pre_uni, Cantidad = @cant, NumProducto = @num_pro where NumPedido = @num_pedi  

GO
ALTER TABLE [movimientos].[CuerpoPedido] ADD CONSTRAINT [Unique_Identifier3] PRIMARY KEY CLUSTERED  ([NumProducto], [NumPedido]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[CuerpoPedido] ADD CONSTRAINT [Contiene] FOREIGN KEY ([NumPedido]) REFERENCES [movimientos].[CabeceraPedido] ([NumPedido])
GO
ALTER TABLE [movimientos].[CuerpoPedido] ADD CONSTRAINT [Forma parte] FOREIGN KEY ([NumProducto]) REFERENCES [catalogo].[Producto] ([NumProducto])
GO
