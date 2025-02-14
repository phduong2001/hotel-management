USE [master]
GO
/****** Object:  Database [ManageHotel]    Script Date: 11/11/2020 9:16:21 AM ******/
CREATE DATABASE [ManageHotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ManageHotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ManageHotel.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ManageHotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ManageHotel_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ManageHotel] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ManageHotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ManageHotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ManageHotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ManageHotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ManageHotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ManageHotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [ManageHotel] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ManageHotel] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ManageHotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ManageHotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ManageHotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ManageHotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ManageHotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ManageHotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ManageHotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ManageHotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ManageHotel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ManageHotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ManageHotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ManageHotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ManageHotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ManageHotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ManageHotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ManageHotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ManageHotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ManageHotel] SET  MULTI_USER 
GO
ALTER DATABASE [ManageHotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ManageHotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ManageHotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ManageHotel] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ManageHotel]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/11/2020 9:16:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[kind] [nvarchar](255) NULL,
	[identityNumber] [varchar](50) NULL,
	[address] [nvarchar](255) NULL,
	[rentedDay] [datetime] NULL,
	[roomName] [nvarchar](255) NULL,
	[ordinalNumber] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RoomCategories]    Script Date: 11/11/2020 9:16:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomCategories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[kind] [nvarchar](255) NULL,
	[note] [nvarchar](255) NULL,
	[price] [float] NULL,
	[roomStatus] [nvarchar](255) NULL,
	[countRented] [int] NULL,
	[rentedDay] [datetime] NULL,
	[total] [float] NULL,
	[ordinalNumber] [int] NULL,
 CONSTRAINT [pk_roomName] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoomHistory]    Script Date: 11/11/2020 9:16:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomHistory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[kind] [nvarchar](255) NULL,
	[countRented] [int] NULL,
	[rentedDay] [datetime] NULL,
	[total] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rules]    Script Date: 11/11/2020 9:16:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nRoomKind] [int] NOT NULL,
	[roomKindPrice] [nvarchar](255) NOT NULL,
	[nCustomerKind] [int] NOT NULL,
	[customerKindCoefficient] [nvarchar](255) NOT NULL,
	[maximumCustomer] [int] NOT NULL,
	[surchargeRatio] [float] NOT NULL,
	[surchargeBeginning] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [fk_room] FOREIGN KEY([roomName])
REFERENCES [dbo].[RoomCategories] ([name])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [fk_room]
GO
USE [master]
GO
ALTER DATABASE [ManageHotel] SET  READ_WRITE 
GO
