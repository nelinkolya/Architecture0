USE [master]
GO
/****** Object:  Database [Task1]    Script Date: 12/20/2016 5:58:05 PM ******/
CREATE DATABASE [Task1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Task1', FILENAME = N'C:\Users\Nikolay\Task1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Task1_log', FILENAME = N'C:\Users\Nikolay\Task1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Task1] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Task1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Task1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Task1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Task1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Task1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Task1] SET ARITHABORT OFF 
GO
ALTER DATABASE [Task1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Task1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Task1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Task1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Task1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Task1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Task1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Task1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Task1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Task1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Task1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Task1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Task1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Task1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Task1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Task1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Task1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Task1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Task1] SET  MULTI_USER 
GO
ALTER DATABASE [Task1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Task1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Task1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Task1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Task1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Task1] SET QUERY_STORE = OFF
GO
USE [Task1]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Task1]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NULL,
	[PostId] [int] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedOn] [datetime] NULL,
	[UserId] [int] NOT NULL,
	[Likes] [int] NOT NULL,
	[Dislikes] [int] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Post]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[Likes] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DeletedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[Dislikes] [int] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Hometown] [nvarchar](max) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserClaim]    Script Date: 12/20/2016 5:58:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaim](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.UserClaim] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserLogin]    Script Date: 12/20/2016 5:58:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogin](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.UserLogin] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 12/20/2016 5:58:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.UserRole] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (5, N'asdf', 4, CAST(N'2016-12-16T01:59:00.000' AS DateTime), CAST(N'2016-12-20T14:08:10.427' AS DateTime), 1, CAST(N'2016-12-20T14:08:10.427' AS DateTime), 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (6, N'e', 16, CAST(N'2016-12-16T14:20:10.447' AS DateTime), CAST(N'2016-12-16T14:20:10.447' AS DateTime), 1, NULL, 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (7, N'comment 1.1', 16, CAST(N'2016-12-16T14:23:15.000' AS DateTime), CAST(N'2016-12-16T15:31:41.707' AS DateTime), 1, NULL, 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (8, N'comment 1', 16, CAST(N'2016-12-16T14:23:46.777' AS DateTime), CAST(N'2016-12-16T14:23:46.777' AS DateTime), 1, NULL, 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (9, N'comment 2', 16, CAST(N'2016-12-16T14:24:12.207' AS DateTime), CAST(N'2016-12-16T15:08:04.083' AS DateTime), 1, CAST(N'2016-12-16T15:08:04.083' AS DateTime), 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (10, N'comment 3', 16, CAST(N'2016-12-16T14:25:18.010' AS DateTime), CAST(N'2016-12-16T15:08:46.777' AS DateTime), 1, CAST(N'2016-12-16T15:08:46.777' AS DateTime), 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (11, N'comment 4.1.1', 16, CAST(N'2016-12-16T14:27:05.000' AS DateTime), CAST(N'2016-12-16T15:04:46.800' AS DateTime), 1, NULL, 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (12, N'comment 1 to post 2', 7, CAST(N'2016-12-16T14:31:21.337' AS DateTime), CAST(N'2016-12-16T14:31:21.337' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (13, N'd', 21, CAST(N'2016-12-16T17:09:15.090' AS DateTime), CAST(N'2016-12-16T17:09:49.113' AS DateTime), 1, CAST(N'2016-12-16T17:09:49.113' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (14, N'dd dd a', 21, CAST(N'2016-12-16T17:09:33.000' AS DateTime), CAST(N'2016-12-16T17:10:23.227' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (15, N'e', 21, CAST(N'2016-12-16T17:10:26.137' AS DateTime), CAST(N'2016-12-20T14:04:06.327' AS DateTime), 1, CAST(N'2016-12-20T14:04:06.327' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (17, N'dd 322', 21, CAST(N'2016-12-20T10:25:07.000' AS DateTime), CAST(N'2016-12-20T10:33:05.320' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1017, N'ecd', 3023, CAST(N'2016-12-20T12:56:28.537' AS DateTime), CAST(N'2016-12-20T14:00:55.303' AS DateTime), 1, CAST(N'2016-12-20T14:00:55.303' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1018, N'd1', 3024, CAST(N'2016-12-20T14:01:04.320' AS DateTime), CAST(N'2016-12-20T14:01:04.320' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1019, N'd2', 3024, CAST(N'2016-12-20T14:01:08.907' AS DateTime), CAST(N'2016-12-20T14:01:13.430' AS DateTime), 1, CAST(N'2016-12-20T14:01:13.430' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1020, N'f', 18, CAST(N'2016-12-20T14:04:50.477' AS DateTime), CAST(N'2016-12-20T14:04:51.843' AS DateTime), 1, CAST(N'2016-12-20T14:04:51.843' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1021, N'фыва1', 3025, CAST(N'2016-12-20T14:09:42.757' AS DateTime), CAST(N'2016-12-20T14:12:18.130' AS DateTime), 1, CAST(N'2016-12-20T14:12:18.130' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1022, N'фыва2', 3025, CAST(N'2016-12-20T14:09:45.387' AS DateTime), CAST(N'2016-12-20T14:09:50.857' AS DateTime), 1, CAST(N'2016-12-20T14:09:50.857' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1023, N'фыав3', 3025, CAST(N'2016-12-20T14:09:49.333' AS DateTime), CAST(N'2016-12-20T14:10:27.960' AS DateTime), 1, CAST(N'2016-12-20T14:10:27.960' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1024, N'adf3', 3025, CAST(N'2016-12-20T14:12:16.207' AS DateTime), CAST(N'2016-12-20T14:12:16.207' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1025, N'adsf1', 3026, CAST(N'2016-12-20T14:13:56.547' AS DateTime), CAST(N'2016-12-20T14:13:56.547' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1026, N'asdf2', 3026, CAST(N'2016-12-20T14:14:00.117' AS DateTime), CAST(N'2016-12-20T14:14:01.407' AS DateTime), 1, CAST(N'2016-12-20T14:14:01.407' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1027, N'asf1', 3027, CAST(N'2016-12-20T14:16:19.083' AS DateTime), CAST(N'2016-12-20T14:16:19.083' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1028, N'asdf2', 3027, CAST(N'2016-12-20T14:16:22.307' AS DateTime), CAST(N'2016-12-20T14:16:27.043' AS DateTime), 1, CAST(N'2016-12-20T14:16:27.043' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1029, N'asdf3', 3027, CAST(N'2016-12-20T14:16:25.090' AS DateTime), CAST(N'2016-12-20T14:16:25.090' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1030, N'asf1', 3028, CAST(N'2016-12-20T14:18:33.370' AS DateTime), CAST(N'2016-12-20T14:18:33.370' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1031, N'asdf2', 3028, CAST(N'2016-12-20T14:18:35.740' AS DateTime), CAST(N'2016-12-20T14:18:39.327' AS DateTime), 1, CAST(N'2016-12-20T14:18:39.327' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1032, N'asf3', 3028, CAST(N'2016-12-20T14:18:38.067' AS DateTime), CAST(N'2016-12-20T14:18:38.067' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1033, N'asdf', 3029, CAST(N'2016-12-20T14:19:00.560' AS DateTime), CAST(N'2016-12-20T14:19:00.560' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1034, N'asdf2', 3030, CAST(N'2016-12-20T14:45:02.473' AS DateTime), CAST(N'2016-12-20T14:45:02.473' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1035, N'asdf3', 3030, CAST(N'2016-12-20T14:45:04.817' AS DateTime), CAST(N'2016-12-20T14:45:07.077' AS DateTime), 1, CAST(N'2016-12-20T14:45:07.077' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1036, N'asdf3', 3031, CAST(N'2016-12-20T14:45:33.747' AS DateTime), CAST(N'2016-12-20T14:45:33.747' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1037, N'asdf3', 3031, CAST(N'2016-12-20T14:45:36.237' AS DateTime), CAST(N'2016-12-20T14:45:40.567' AS DateTime), 1, CAST(N'2016-12-20T14:45:40.567' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1038, N'asdf3', 3031, CAST(N'2016-12-20T14:45:39.073' AS DateTime), CAST(N'2016-12-20T14:45:39.073' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1039, N'asdf', 3032, CAST(N'2016-12-20T14:56:09.640' AS DateTime), CAST(N'2016-12-20T14:56:09.640' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1040, N'ew', 3032, CAST(N'2016-12-20T14:56:13.880' AS DateTime), CAST(N'2016-12-20T14:56:16.210' AS DateTime), 1, CAST(N'2016-12-20T14:56:16.210' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1041, N'asdf', 3035, CAST(N'2016-12-20T14:59:04.037' AS DateTime), CAST(N'2016-12-20T14:59:04.037' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1042, N'asdf', 3036, CAST(N'2016-12-20T15:01:27.380' AS DateTime), CAST(N'2016-12-20T15:01:27.380' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1043, N'asdfe', 3036, CAST(N'2016-12-20T15:01:30.000' AS DateTime), CAST(N'2016-12-20T15:01:32.383' AS DateTime), 1, CAST(N'2016-12-20T15:01:32.383' AS DateTime), 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1044, N'df', 3037, CAST(N'2016-12-20T15:06:10.233' AS DateTime), CAST(N'2016-12-20T15:06:10.233' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1045, N'asdf', 3037, CAST(N'2016-12-20T15:06:19.203' AS DateTime), CAST(N'2016-12-20T15:06:19.203' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1046, N'asdf', 3037, CAST(N'2016-12-20T15:06:23.533' AS DateTime), CAST(N'2016-12-20T15:06:23.533' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1047, N'd', 3037, CAST(N'2016-12-20T15:07:20.150' AS DateTime), CAST(N'2016-12-20T15:12:47.190' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1048, N'f', 3037, CAST(N'2016-12-20T15:12:55.763' AS DateTime), CAST(N'2016-12-20T15:12:55.763' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1049, N'asdf', 3038, CAST(N'2016-12-20T15:14:26.233' AS DateTime), CAST(N'2016-12-20T15:14:26.233' AS DateTime), 0, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1050, N'adf', 3039, CAST(N'2016-12-20T15:32:28.430' AS DateTime), CAST(N'2016-12-20T15:32:28.430' AS DateTime), 1, NULL, 3, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1051, N'd', 3039, CAST(N'2016-12-20T15:36:24.883' AS DateTime), CAST(N'2016-12-20T15:36:24.883' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1052, N'd', 3039, CAST(N'2016-12-20T15:36:28.623' AS DateTime), CAST(N'2016-12-20T15:36:28.623' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1053, N'a', 3039, CAST(N'2016-12-20T15:36:31.800' AS DateTime), CAST(N'2016-12-20T15:36:31.800' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1054, N'd', 3039, CAST(N'2016-12-20T15:36:34.583' AS DateTime), CAST(N'2016-12-20T15:36:34.583' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1055, N'asdf', 3039, CAST(N'2016-12-20T15:36:47.927' AS DateTime), CAST(N'2016-12-20T15:36:47.927' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1056, N'asdf', 3039, CAST(N'2016-12-20T15:36:49.660' AS DateTime), CAST(N'2016-12-20T15:36:49.660' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1057, N'asdf', 3039, CAST(N'2016-12-20T15:36:51.477' AS DateTime), CAST(N'2016-12-20T15:36:51.477' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1058, N'asdf', 3039, CAST(N'2016-12-20T15:36:53.093' AS DateTime), CAST(N'2016-12-20T15:36:53.093' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1059, N'asdf', 3039, CAST(N'2016-12-20T15:37:14.553' AS DateTime), CAST(N'2016-12-20T15:37:14.553' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1060, N'asdf', 3039, CAST(N'2016-12-20T15:37:16.187' AS DateTime), CAST(N'2016-12-20T15:37:16.187' AS DateTime), 1, NULL, 6, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1061, N'asdf', 3039, CAST(N'2016-12-20T15:37:38.653' AS DateTime), CAST(N'2016-12-20T15:37:38.653' AS DateTime), 1, NULL, 1, 0, 0)
INSERT [dbo].[Comment] ([Id], [Text], [PostId], [CreatedOn], [ModifiedOn], [IsDeleted], [DeletedOn], [UserId], [Likes], [Dislikes]) VALUES (1062, N'asdf ASSDSssdsd', 3039, CAST(N'2016-12-20T15:37:40.673' AS DateTime), CAST(N'2016-12-20T15:39:40.300' AS DateTime), 1, NULL, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (4, N'asdf', CAST(N'2016-12-16T01:36:00.000' AS DateTime), 1, 0, 1, CAST(N'2016-12-16T14:31:02.100' AS DateTime), CAST(N'2016-12-16T14:31:02.100' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (7, N'asdasdf2', CAST(N'2016-12-16T01:36:00.000' AS DateTime), 1, 0, 1, CAST(N'2016-12-20T14:09:22.367' AS DateTime), CAST(N'2016-12-20T14:09:22.367' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (8, N'asdf', CAST(N'2016-12-16T12:15:25.217' AS DateTime), 3, 0, 1, CAST(N'2016-12-16T14:31:00.163' AS DateTime), CAST(N'2016-12-16T14:31:00.163' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (10, N'asdf 54 21 22 23', CAST(N'2016-12-16T12:31:53.000' AS DateTime), 3, 0, 1, CAST(N'2016-12-16T14:30:55.553' AS DateTime), CAST(N'2016-12-16T14:30:55.553' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (16, N'd d d v', CAST(N'2016-12-16T13:17:08.000' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:05:02.130' AS DateTime), CAST(N'2016-12-20T14:05:02.130' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (17, N'sdfa', CAST(N'2016-12-16T14:50:51.307' AS DateTime), 3, 0, 1, CAST(N'2016-12-16T14:50:56.797' AS DateTime), CAST(N'2016-12-16T14:50:56.797' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (18, N'new post', CAST(N'2016-12-16T16:26:16.907' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:04:54.073' AS DateTime), CAST(N'2016-12-20T14:04:54.073' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (19, N'adsf', CAST(N'2016-12-16T16:44:08.450' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:04:46.473' AS DateTime), CAST(N'2016-12-20T14:04:46.473' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (20, N'asdf', CAST(N'2016-12-16T16:52:49.267' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:04:42.230' AS DateTime), CAST(N'2016-12-20T14:04:42.230' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (21, N'abcdefg 456', CAST(N'2016-12-16T17:00:37.000' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:04:18.490' AS DateTime), CAST(N'2016-12-20T14:04:18.490' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (22, N'd', CAST(N'2016-12-20T10:33:34.763' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T12:09:14.090' AS DateTime), CAST(N'2016-12-20T12:09:14.090' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (1022, N'f', CAST(N'2016-12-20T11:08:47.427' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T12:09:13.383' AS DateTime), CAST(N'2016-12-20T12:09:13.383' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (2022, N'f', CAST(N'2016-12-20T11:32:21.303' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T12:09:12.480' AS DateTime), CAST(N'2016-12-20T12:09:12.480' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (2023, N'd', CAST(N'2016-12-20T11:46:45.890' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T12:09:11.173' AS DateTime), CAST(N'2016-12-20T12:09:11.173' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (2024, N'd', CAST(N'2016-12-20T11:49:30.240' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T12:09:09.157' AS DateTime), CAST(N'2016-12-20T12:09:09.157' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3023, N'a', CAST(N'2016-12-20T12:17:02.380' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T13:52:07.483' AS DateTime), CAST(N'2016-12-20T13:52:07.483' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3024, N'd', CAST(N'2016-12-20T14:00:58.867' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:01:24.090' AS DateTime), CAST(N'2016-12-20T14:01:24.090' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3025, N'фыва', CAST(N'2016-12-20T14:09:38.287' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:12:21.490' AS DateTime), CAST(N'2016-12-20T14:12:21.490' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3026, N'asdf', CAST(N'2016-12-20T14:13:51.667' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:14:03.303' AS DateTime), CAST(N'2016-12-20T14:14:03.303' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3027, N'das', CAST(N'2016-12-20T14:16:16.073' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:16:29.253' AS DateTime), CAST(N'2016-12-20T14:16:29.253' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3028, N'asdf', CAST(N'2016-12-20T14:18:31.117' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:18:41.477' AS DateTime), CAST(N'2016-12-20T14:18:41.477' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3029, N'asdf', CAST(N'2016-12-20T14:18:57.180' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:19:01.927' AS DateTime), CAST(N'2016-12-20T14:19:01.927' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3030, N'sfg', CAST(N'2016-12-20T14:44:59.910' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:45:08.880' AS DateTime), CAST(N'2016-12-20T14:45:08.880' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3031, N'asdf asdf', CAST(N'2016-12-20T14:45:26.667' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:45:42.500' AS DateTime), CAST(N'2016-12-20T14:45:42.500' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3032, N'dsf', CAST(N'2016-12-20T14:56:07.273' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:56:18.473' AS DateTime), CAST(N'2016-12-20T14:56:18.473' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3033, N'fd', CAST(N'2016-12-20T14:56:23.317' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:58:05.087' AS DateTime), CAST(N'2016-12-20T14:58:05.087' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3034, N'afd', CAST(N'2016-12-20T14:58:18.067' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:58:19.860' AS DateTime), CAST(N'2016-12-20T14:58:19.860' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3035, N'asdf', CAST(N'2016-12-20T14:59:01.017' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T14:59:05.363' AS DateTime), CAST(N'2016-12-20T14:59:05.363' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3036, N'asdf', CAST(N'2016-12-20T15:01:25.257' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T15:01:34.680' AS DateTime), CAST(N'2016-12-20T15:01:34.680' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3037, N'asdf', CAST(N'2016-12-20T15:06:06.730' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T15:53:10.280' AS DateTime), CAST(N'2016-12-20T15:53:10.280' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3038, N'asdf', CAST(N'2016-12-20T15:09:00.063' AS DateTime), 3, 0, 0, NULL, CAST(N'2016-12-20T15:09:00.063' AS DateTime), 0)
INSERT [dbo].[Post] ([Id], [Text], [CreatedOn], [UserId], [Likes], [IsDeleted], [DeletedOn], [ModifiedOn], [Dislikes]) VALUES (3039, N'df', CAST(N'2016-12-20T15:32:26.100' AS DateTime), 3, 0, 1, CAST(N'2016-12-20T15:53:04.133' AS DateTime), CAST(N'2016-12-20T15:53:04.133' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Post] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Customer')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Hometown], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (1, NULL, N'nikolay.nelin@gmail.com', 0, N'APNTlHHLgLkiPH4yco2G33NGrolKaZn6ukDGOq94sykN35LnVREqccn5ZlvhfDHQlQ==', N'92c817dd-3796-4615-8b0d-b9b161f4e85f', NULL, 0, 0, NULL, 0, 0, N'Admin')
INSERT [dbo].[User] ([Id], [Hometown], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (3, NULL, N'nikolay.nelin@gmail.com', 0, N'APNTlHHLgLkiPH4yco2G33NGrolKaZn6ukDGOq94sykN35LnVREqccn5ZlvhfDHQlQ==', N'92c817dd-3796-4615-8b0d-b9b161f4e85f', NULL, 0, 0, NULL, 0, 0, N'AdminManager')
INSERT [dbo].[User] ([Id], [Hometown], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (4, NULL, N'nikolay.nelin@gmail.com', 0, N'APNTlHHLgLkiPH4yco2G33NGrolKaZn6ukDGOq94sykN35LnVREqccn5ZlvhfDHQlQ==', N'92c817dd-3796-4615-8b0d-b9b161f4e85f', NULL, 0, 0, NULL, 0, 0, N'Manager')
INSERT [dbo].[User] ([Id], [Hometown], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (6, NULL, N'nikolay.nelin@gmail.com', 0, N'APNTlHHLgLkiPH4yco2G33NGrolKaZn6ukDGOq94sykN35LnVREqccn5ZlvhfDHQlQ==', N'92c817dd-3796-4615-8b0d-b9b161f4e85f', NULL, 0, 0, NULL, 0, 0, N'User')
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 1)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 1)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 2)
INSERT [dbo].[UserRole] ([UserId], [RoleId]) VALUES (4, 2)
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_Likes]  DEFAULT ((0)) FOR [Likes]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_Dislikes]  DEFAULT ((0)) FOR [Dislikes]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_Likes]  DEFAULT ((0)) FOR [Likes]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [DF_Post_Dislikes]  DEFAULT ((0)) FOR [Dislikes]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Post] FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Post]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
GO
ALTER TABLE [dbo].[UserClaim]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserClaim_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaim] CHECK CONSTRAINT [FK_dbo.UserClaim_dbo.User_UserId]
GO
ALTER TABLE [dbo].[UserLogin]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserLogin_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogin] CHECK CONSTRAINT [FK_dbo.UserLogin_dbo.User_UserId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId]
GO
USE [master]
GO
ALTER DATABASE [Task1] SET  READ_WRITE 
GO
