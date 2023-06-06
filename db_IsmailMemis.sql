USE master
GO
/****** Veritabanýný Oluþturma ******/
CREATE DATABASE db_ÝsmailMemisssz
ON PRIMARY 
(NAME = 'db_ÝsmailMemisssz', FILENAME = 'd:\db_ÝsmailMemisssz.mdf', SIZE = 5120KB, FILEGROWTH = 1024KB)
 LOG ON 
(NAME = 'db_ÝsmailMemisssz_log', FILENAME = 'd:\db_ÝsmailMemisssz_log.ldf', SIZE = 1024KB , FILEGROWTH = 1024KB)
GO
ALTER DATABASE db_ÝsmailMemisssz SET COMPATIBILITY_LEVEL = 150
GO
USE db_ÝsmailMemisssz
GO
 
 
 --Bölümler Tablosunu Oluþturma--

 CREATE TABLE [dbo].[tbl_Departments](
	[Dept_ID] [int] NOT NULL,
	[Dept_Name] [nvarchar](50) NULL,
	[Dept_Phone] [nvarchar](50) NULL,
	[Manager_ID] [int] NULL,
 CONSTRAINT [PK_tbl_Departments] PRIMARY KEY CLUSTERED 
(
	[Dept_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

  --Personel Tablosunu Oluþturma--

  CREATE TABLE [dbo].[tbl_Employees](
	[Empl_ID] [int] IDENTITY(1,1) NOT NULL,
	[Empl_FName] [nvarchar](50) NULL,
	[Empl_LName] [nvarchar](50) NULL,
	[Empl_BDate] [smalldatetime] NULL,
	[Is_Empl_Active] [bit] NULL,
	[Empl_Start_Date] [smalldatetime] NULL,
	[Empl_Wage] [money] NULL,
	[Gender_ID] [int] NULL,
	[Title_ID] [int] NULL,
	[Empl_Email] [nvarchar](50) NULL,
	[Empl_Cell] [nchar](15) NULL,
	[Dept_ID] [int] NULL,
	[Empl_Address] [nvarchar](200) NULL,
	[Empl_Province] [nvarchar](50) NULL,
	[Empl_City] [nvarchar](50) NULL,
	[Empl_Name]  AS (([Empl_FName]+' ')+[Empl_LName]),
 CONSTRAINT [PK_dbo.tbl_Employees] PRIMARY KEY CLUSTERED 
(
	[Empl_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Maaslar Tablosunu Olusturma --

CREATE TABLE [dbo].[tbl_EmployeeWages](
	[Wage_ID] [int] IDENTITY(1,1) NOT NULL,
	[Empl_ID] [int] NULL,
	[Wage_Paid_Date] [smalldatetime] NULL,
	[Wage_Amount] [money] NULL,
	[Wage_Commission] [money] NULL,
	[Month_ID] [int] NULL,
	[Wage_Year]  AS (datepart(year,[Wage_Paid_Date])),
	[Wage_Total]  AS ([Wage_Amount]+[Wage_Commission]),
 CONSTRAINT [PK_tbl_EmployeeWages] PRIMARY KEY CLUSTERED 
(
	[Wage_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



--Kategoriler Tablosunu Olustuma --

CREATE TABLE [dbo].[tbl_Lookups](
	[LK_ID] [int] IDENTITY(1,1) NOT NULL,
	[Empl_Title] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Month_Name] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Province] [nvarchar](50) NULL,
	[User_Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Lookups] PRIMARY KEY CLUSTERED 
(
	[LK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

  -- Kullanýcýlar Tablosunu Olusturma --

  
CREATE TABLE [dbo].[tbl_Users](
	[User_ID] [int] IDENTITY(1,1) NOT NULL,
	[User_Name] [nvarchar](50) NULL,
	[User_Password] [nvarchar](50) NULL,
	[User_Type_ID] [int] NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



-- Verileri girme --
INSERT INTO tbl_Lookups(Empl_Title, Gender,
Month_Name, City,Province)
VALUES 
('Müdür','','Ocak','Çankaya','Ankara'),
('Ýþçi','','Þubat','Kasýmpasa','Ýstanbul'),
('Müdür Yardýmcýsý','','Mart','Beþiktaþ','Ýstanbul'),
('Sekreter','','Nisan','Etiler','Canakkale')

INSERT INTO tbl_Departments(Dept_ID, Dept_Name,
Dept_Phone, Manager_ID)
VALUES 

('1','Muhasebe','05537215404',11),
('2','Finans','05567894532',12),
('3','Eðitim','05548765432',13),
('4','Denetim','05547896521',14),
('5','Yönetim','05547836257',15),
('6','Temizlik','05315264578',16)



INSERT INTO tbl_Employees(Empl_FName, Empl_LName,
Empl_BDate, Is_Empl_Active, Empl_Start_Date, Empl_Wage, Gender_ID,
Title_ID,
Empl_Email,
Empl_Cell, Dept_ID, Empl_Address, Empl_Province, Empl_City)
VALUES 
('Esra', 'Kant', '03.03.2001', 'True', '10.07.2017', 1800,
'2', '1', 'mailleriokumuyorum@hotmail.com', '5578976545', '1','Ihlamur','Besiktas','Kars'),
('Ýsmail', 'Memis', '07.03.2002', 'True', '10.07.2020', 5900,
'1', '2', 'mailleriokumuyorum@hotmail.com', '5537215404', '2','Resitpasa','Sarýyer','Ýstanbul'),
('Rakim', 'Griffin', '07.03.1971', 'False', '10.07.2000', 10500,
'1', '4', 'mailleriokumuyorum@hotmail.com', '5537215404', '5','Nispetiye','Etiler','Los Angeles'),
('Cihat', 'Akbel', '05.01.1991', 'True', '07.10.2014', 8500,
'1', '2', 'mailleriiokumuyorum@gmail.com', '5586549848', '3','Mavivadi','Yesilvadi','Batman')


INSERT INTO tbl_EmployeeWages(Empl_ID, Wage_Paid_Date,
Wage_Amount, Wage_Commission,Month_ID)
VALUES 

('2','1.05.2009','5000','3500',5),
('4','1.05.2009','7500','3500',5),
('1','1.05.2009','7900','3500',5),
('3','1.05.2009','15000','35000',5)





 -- Ýliskileri Kurma -- 


ALTER TABLE [dbo].[tbl_Users]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Users_tbl_Lookups] FOREIGN KEY([User_Type_ID])
REFERENCES [dbo].[tbl_Lookups] ([LK_ID])
GO

ALTER TABLE [dbo].[tbl_Users] CHECK CONSTRAINT [FK_tbl_Users_tbl_Lookups]
GO


ALTER TABLE [dbo].[tbl_Employees] ADD  CONSTRAINT [DF_dbo.tbl_Employees_Is_Empl_Active]  DEFAULT ((1)) FOR [Is_Empl_Active]
GO

ALTER TABLE [dbo].[tbl_Employees] ADD  CONSTRAINT [DF_tbl_Employees_Empl_Start_Date]  DEFAULT (getdate()) FOR [Empl_Start_Date]
GO

ALTER TABLE [dbo].[tbl_Employees] ADD  CONSTRAINT [DF_tbl_Employees_Empl_Wage]  DEFAULT ((0)) FOR [Empl_Wage]
GO

ALTER TABLE [dbo].[tbl_Employees]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Employees_tbl_Departments_Dept_ID] FOREIGN KEY([Dept_ID])
REFERENCES [dbo].[tbl_Departments] ([Dept_ID])
GO

ALTER TABLE [dbo].[tbl_Employees] CHECK CONSTRAINT [FK_tbl_Employees_tbl_Departments_Dept_ID]
GO

ALTER TABLE [dbo].[tbl_Employees]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Employees_tbl_Lookups1] FOREIGN KEY([Title_ID])
REFERENCES [dbo].[tbl_Lookups] ([LK_ID])
GO

ALTER TABLE [dbo].[tbl_Employees] CHECK CONSTRAINT [FK_tbl_Employees_tbl_Lookups1]
GO

ALTER TABLE [dbo].[tbl_EmployeeWages] ADD  CONSTRAINT [DF_tbl_EmployeeWages_Wage_Date]  DEFAULT (getdate()) FOR [Wage_Paid_Date]
GO

ALTER TABLE [dbo].[tbl_EmployeeWages] ADD  CONSTRAINT [DF_tbl_EmployeeWages_Wage_Amount]  DEFAULT ((0)) FOR [Wage_Amount]
GO

ALTER TABLE [dbo].[tbl_EmployeeWages] ADD  CONSTRAINT [DF_tbl_EmployeeWages_Wage_Commision]  DEFAULT ((0)) FOR [Wage_Commission]
GO

ALTER TABLE [dbo].[tbl_EmployeeWages]  WITH CHECK ADD  CONSTRAINT [FK_tbl_EmployeeWages_tbl_Employees_Empl_ID] FOREIGN KEY([Empl_ID])
REFERENCES [dbo].[tbl_Employees] ([Empl_ID])
GO



SELECT * FROM tbl_Lookups
SELECT * FROM tbl_Departments
SELECT * FROM tbl_Employees
SELECT * FROM tbl_EmployeeWages
SELECT * FROM tbl_Users







