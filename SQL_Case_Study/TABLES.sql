
--Pedidos
CREATE TABLE [dbo].[PEDIDOS](
	[Codigo] [nvarchar](30) NOT NULL,
	[Tipo] [char](3) NOT NULL,
	[Numero] [int] NOT NULL,
	[Cliente] [nvarchar](20) NULL,
	[Fechaemi] [datetime] NOT NULL,
 CONSTRAINT [PK_VEN_CABEGRESO] PRIMARY KEY CLUSTERED ([Codigo] ASC)
) ON [PRIMARY];

--DETALLE PEDIDO 
CREATE TABLE [dbo].[DETALLEPEDIDO](
	[Codigo] [nvarchar](30) NOT NULL,
	[Producto] [int] NOT NULL,
	[Totalfun] [float] NOT NULL,
	[Precio] [float] NULL,
	[Subtotal] [money] NOT NULL,
	[Iva] [money] NOT NULL,
	[Neto] [money] NOT NULL,
) ON [PRIMARY]

--PRODUCTO
CREATE TABLE [dbo].[PRODUCTO](
	[Codigo] [int] NOT NULL,
	[Codigo_Producto] [nvarchar](30) NOT NULL,
	[Nombre] [nvarchar](300) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_INV_PRODUCTO] PRIMARY KEY CLUSTERED ([Codigo] ASC)
) ON [PRIMARY];


--CLIENTE
CREATE TABLE [dbo].[CLIENTE](
	[Codigo] [nvarchar](20) NOT NULL,
	[Razon_Social] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_CXC_CLIENTE] PRIMARY KEY CLUSTERED ([Codigo] ASC)
) ON [PRIMARY];



