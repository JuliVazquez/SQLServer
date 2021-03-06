USE [SistemaDeFerias]
GO
/****** Object:  Table [dbo].[declaracion]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[declaracion](
	[id] [int] NOT NULL,
	[fechageneracion] [date] NOT NULL,
	[feria_id] [int] NOT NULL,
	[user_autor_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[declaracion_individual]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[declaracion_individual](
	[id] [int] NOT NULL,
	[producto_declarado_id] [int] NOT NULL,
	[declaracion_id] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[precio_por_bulto] [decimal](12, 2) NULL,
	[comercializado] [bit] NOT NULL,
	[peso_por_bulto] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feria]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feria](
	[id] [int] NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[cuit] [varchar](13) NOT NULL,
	[cantidad_puestos] [int] NULL,
	[localidad] [varchar](255) NULL,
	[domicilio] [varchar](255) NULL,
	[zona] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto](
	[id] [int] NOT NULL,
	[tipo_id] [int] NOT NULL,
	[especie] [varchar](255) NOT NULL,
	[variedad] [varchar](255) NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_tipo]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto_tipo](
	[id] [int] NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[descripcion] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_feria]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_feria](
	[user_id] [int] NOT NULL,
	[feria_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[feria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 29/12/2020 10:55:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] NOT NULL,
	[email] [varchar](180) NOT NULL,
	[password] [varchar](25) NOT NULL,
	[nombre] [varchar](255) NULL,
	[apellido] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[declaracion] ADD  DEFAULT (NULL) FOR [user_autor_id]
GO
ALTER TABLE [dbo].[declaracion_individual] ADD  DEFAULT (NULL) FOR [precio_por_bulto]
GO
ALTER TABLE [dbo].[declaracion_individual] ADD  DEFAULT ((1)) FOR [comercializado]
GO
ALTER TABLE [dbo].[declaracion_individual] ADD  DEFAULT (NULL) FOR [peso_por_bulto]
GO
ALTER TABLE [dbo].[feria] ADD  DEFAULT (NULL) FOR [cantidad_puestos]
GO
ALTER TABLE [dbo].[feria] ADD  DEFAULT (NULL) FOR [localidad]
GO
ALTER TABLE [dbo].[feria] ADD  DEFAULT (NULL) FOR [domicilio]
GO
ALTER TABLE [dbo].[producto] ADD  DEFAULT (NULL) FOR [variedad]
GO
ALTER TABLE [dbo].[producto_tipo] ADD  DEFAULT (NULL) FOR [descripcion]
GO
ALTER TABLE [dbo].[usuario] ADD  DEFAULT (NULL) FOR [nombre]
GO
ALTER TABLE [dbo].[usuario] ADD  DEFAULT (NULL) FOR [apellido]
GO
ALTER TABLE [dbo].[declaracion]  WITH CHECK ADD FOREIGN KEY([feria_id])
REFERENCES [dbo].[feria] ([id])
GO
ALTER TABLE [dbo].[declaracion]  WITH CHECK ADD FOREIGN KEY([user_autor_id])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[declaracion_individual]  WITH CHECK ADD FOREIGN KEY([declaracion_id])
REFERENCES [dbo].[declaracion] ([id])
GO
ALTER TABLE [dbo].[declaracion_individual]  WITH CHECK ADD FOREIGN KEY([producto_declarado_id])
REFERENCES [dbo].[producto] ([id])
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD FOREIGN KEY([tipo_id])
REFERENCES [dbo].[producto_tipo] ([id])
GO
ALTER TABLE [dbo].[user_feria]  WITH CHECK ADD FOREIGN KEY([feria_id])
REFERENCES [dbo].[feria] ([id])
GO
ALTER TABLE [dbo].[user_feria]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[usuario] ([id])
GO
