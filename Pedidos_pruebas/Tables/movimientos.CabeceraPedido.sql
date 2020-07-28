CREATE TABLE [movimientos].[CabeceraPedido]
(
[NumPedido] [int] NOT NULL,
[FechaPedido] [datetime] NOT NULL,
[NumCliente] [int] NOT NULL,
[TipoPed] [varchar] (10) COLLATE Modern_Spanish_CI_AS NULL,
[MontoTotal] [money] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   TRIGGER [movimientos].[CabeceraPedidoIngresado] 

on [movimientos].[CabeceraPedido] for insert 

as 

declare @num_pedi int, @fech_ped datetime, @tipo_ped varchar(10), @mont_total money, @num_cli int, @cod_gar int, @lim_cred money 

select @num_pedi = NumPedido, @fech_ped = FechaPedido, @tipo_ped = TipoPed, @mont_total = MontoTotal, @num_cli = NumCliente from inserted 

select @cod_gar = (select CodigoGarante from catalogo.Cliente where NumCliente = @num_cli), @lim_cred = (select LimitCredito from catalogo.Cliente where NumCliente = @num_cli) 

IF @tipo_ped = 'CREDITO' 

BEGIN 

IF NOT EXISTS (SELECT * FROM Deudor WHERE CodigoCliente = @num_cli)  

BEGIN 

insert into Deudor values (@num_cli, @cod_gar, @lim_cred, 0)  

END 

END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   TRIGGER [movimientos].[TR_PedidoActualizado] 

on [movimientos].[CabeceraPedido] for update 

as 

declare @num_pedi int, @fech_pedi datetime, @num_cli int 

select @num_pedi = NumPedido, @fech_pedi = FechaPedido, @num_cli = NumCliente from inserted 

update movimientos.CabezaCuerpoP set FechaPedido = @fech_pedi where NumPedido = @num_pedi and NumCliente = @num_cli
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   TRIGGER [movimientos].[TR_PedidoEliminado] 

on [movimientos].[CabeceraPedido] for delete 

as 

declare @num_pedi int, @fech_pedi datetime, @num_cli int 

select @num_pedi = NumPedido, @fech_pedi = FechaPedido, @num_cli = NumCliente from deleted 

delete from movimientos.CabezaCuerpoP where FechaPedido = @fech_pedi and  NumPedido = @num_pedi and NumCliente = @num_cli
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   TRIGGER [movimientos].[TR_PedidoInsertado] 

on [movimientos].[CabeceraPedido] for insert 

as 

declare @num_pedi int, @fech_pedi datetime, @num_cli int 

select @num_pedi = NumPedido, @fech_pedi = FechaPedido, @num_cli = NumCliente from inserted 

insert into movimientos.CabezaCuerpoP Values (@num_pedi,@fech_pedi,@num_cli,null,null,null)
GO
ALTER TABLE [movimientos].[CabeceraPedido] ADD CONSTRAINT [CK_CabeceraPedido] CHECK (([TipoPed]='CREDITO' OR [TipoPEd]='CONTADO'))
GO
ALTER TABLE [movimientos].[CabeceraPedido] ADD CONSTRAINT [Unique_Identifier2] PRIMARY KEY CLUSTERED  ([NumPedido]) ON [PRIMARY]
GO
ALTER TABLE [movimientos].[CabeceraPedido] ADD CONSTRAINT [Hace] FOREIGN KEY ([NumCliente]) REFERENCES [catalogo].[Cliente] ([NumCliente])
GO
