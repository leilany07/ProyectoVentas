USE [master]
GO
/****** Object:  Database [Prueba]    Script Date: 1/10/2020 10:36:33 a. m. ******/
CREATE DATABASE [Prueba]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Prueba', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Prueba.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Prueba_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Prueba_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Prueba] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Prueba].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Prueba] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Prueba] SET ARITHABORT OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Prueba] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Prueba] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Prueba] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Prueba] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Prueba] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Prueba] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Prueba] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Prueba] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Prueba] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Prueba] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Prueba] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Prueba] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Prueba] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Prueba] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Prueba] SET  MULTI_USER 
GO
ALTER DATABASE [Prueba] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Prueba] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Prueba] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Prueba] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Prueba] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Prueba] SET QUERY_STORE = OFF
GO
USE [Prueba]
GO
/****** Object:  Table [dbo].[ESTADO]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NULL,
	[DESCRIPCION] [varchar](200) NULL,
 CONSTRAINT [PK_ESTADO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESULTADO]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESULTADO](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](100) NULL,
	[Respuesta] [int] NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_RESULTADO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[USUARIO] [varchar](250) NULL,
	[PASSWORD] [varchar](500) NULL,
	[ESTADO] [int] NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [FK_USUARIO_ESTADO] FOREIGN KEY([ESTADO])
REFERENCES [dbo].[ESTADO] ([ID])
GO
ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [FK_USUARIO_ESTADO]
GO
/****** Object:  StoredProcedure [dbo].[EliminarResultado]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[EliminarResultado]
@id int
as
delete from Resultado where Id=@id
GO
/****** Object:  StoredProcedure [dbo].[InsetarResultado]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------INSERTAR 
create proc [dbo].[InsetarResultado]
@usuario varchar (100),
@respuesta int 
as
insert into resultado values (@usuario,@respuesta,GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[MostrarResultado]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[MostrarResultado]

as
select 
id,
usuario,
respuesta,
fecha,
DATEDIFF(day, fecha,  getdate())dias
from Resultado 

GO
/****** Object:  StoredProcedure [dbo].[MostrarResultadoFiltro]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MostrarResultadoFiltro]
@usuario varchar (100),
@respMin int,
@respMax int
as

SELECT 
id,
usuario,
respuesta,
fecha,
DATEDIFF(day, fecha,  getdate())dias
FROM 
Resultado

WHERE ( upper(@usuario) IS NULL OR upper(@usuario) = USUARIO )   AND 

RESPUESTA BETWEEN  @respMin  AND @respMax

GO
/****** Object:  StoredProcedure [dbo].[MostrarResultadoFiltroUser]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MostrarResultadoFiltroUser]
@usuario varchar (100)
as

select *from Resultado 

WHERE ( upper(@usuario) IS NULL OR upper(@usuario) = USUARIO )   


GO
/****** Object:  StoredProcedure [dbo].[MostrarUsuarioNombre]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[MostrarUsuarioNombre]
@user varchar (500)
as
select *from Usuario 

where 
ESTADO=1

AND ( UPPER (@user) = USUARIO ) 


GO
/****** Object:  StoredProcedure [dbo].[MostrarUsuarios]    Script Date: 1/10/2020 10:36:33 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[MostrarUsuarios]

as
select *from Usuario 

where 
ESTADO=1


GO
USE [master]
GO
ALTER DATABASE [Prueba] SET  READ_WRITE 
GO


----datos de las tablas Resultado

USE [Prueba]
GO
SET IDENTITY_INSERT [dbo].[ESTADO] ON 

INSERT [dbo].[ESTADO] ([ID], [NOMBRE], [DESCRIPCION]) VALUES (1, N'activo', N'activo')
INSERT [dbo].[ESTADO] ([ID], [NOMBRE], [DESCRIPCION]) VALUES (2, N'anulado', N'anulado')
SET IDENTITY_INSERT [dbo].[ESTADO] OFF
SET IDENTITY_INSERT [dbo].[USUARIO] ON 

INSERT [dbo].[USUARIO] ([ID], [USUARIO], [PASSWORD], [ESTADO]) VALUES (1, N'Juliana', N'123', 1)
INSERT [dbo].[USUARIO] ([ID], [USUARIO], [PASSWORD], [ESTADO]) VALUES (2, N'Pedro', N'1234', 1)
INSERT [dbo].[USUARIO] ([ID], [USUARIO], [PASSWORD], [ESTADO]) VALUES (3, N'Juan', N'12345', 1)
INSERT [dbo].[USUARIO] ([ID], [USUARIO], [PASSWORD], [ESTADO]) VALUES (4, N'Lina', N'123456', 1)
SET IDENTITY_INSERT [dbo].[USUARIO] OFF
SET IDENTITY_INSERT [dbo].[RESULTADO] ON 

INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (1, N'Camilo', 168, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (2, N'Juliana', 0, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (3, N'Juan', 151585, CAST(N'2020-09-01T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (4, N'Juan', 117743, CAST(N'2020-08-01T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (5, N'Juan', 117743, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (6, N'Juan', 48839, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (7, N'Juan', 48839, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (8, N'Juan', 117743, CAST(N'2020-09-30T23:33:36.787' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (9, N'Juan', 105999495, CAST(N'2020-10-01T10:25:19.710' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (10, N'Juan', 117743, CAST(N'2020-10-01T10:26:02.577' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (11, N'Juan', 117743, CAST(N'2020-10-01T10:26:45.957' AS DateTime))
INSERT [dbo].[RESULTADO] ([Id], [Usuario], [Respuesta], [Fecha]) VALUES (12, N'Juan', 356092, CAST(N'2020-10-01T10:29:06.963' AS DateTime))
SET IDENTITY_INSERT [dbo].[RESULTADO] OFF








