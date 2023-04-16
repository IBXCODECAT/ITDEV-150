-------Set SQL Server Enviroment-------

--Use the master database so we can alter or drop the MyWebDB database later if needed
USE master
GO

-------Reset Test Database-------

--Drop the MyWebDB database if it already exists for testing purposes
IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'MyWebDB')
DROP DATABASE [MyWebDB]
GO --Wait for the database to be dropped

CREATE DATABASE MyWebDB --Create the MyWebDB Database
GO -- Wait for the database to be created

USE MyWebDB -- Set the current database
GO -- Wait for the database to be loaded

-------Setup Database Functions-------

IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'dbo.GetHomeFileName') OR object_id = OBJECT_ID(N'dbo.GetClydeFileName')
)
BEGIN
	DROP FUNCTION dbo.GetHomeFileName
	DROP FUNCTION dbo.GetClydeFileName 
END
GO

CREATE FUNCTION GetHomeFileName() --Gets the filename for Home V3
RETURNS varchar(max) AS
	BEGIN
		RETURN 'Home V3.dcext'
	END
GO

CREATE FUNCTION GetClydeFileName() --Gets the filename for ClydeAI
RETURNS varchar(max) AS
	BEGIN
		RETURN 'ClydeAI.dcext'
	END
GO

-------Create Database Tables-------

CREATE TABLE Users (
	UserID bigint PRIMARY KEY NOT NULL IDENTITY(1, 1), 
	EmailAddress varchar(max) NOT NULL,
	FirstName varchar(max) NOT NULL,
	LastName varchar(max) NOT NULL
)
CREATE TABLE Products (
	ProductID smallint PRIMARY KEY NOT NULL IDENTITY(1, 1),
	ProductName varchar(max) NOT NULL
)
CREATE TABLE Downloads (
	DownloadID bigint PRIMARY KEY NOT NULL IDENTITY(1, 1),
	DownloadDate date NOT NULL DEFAULT GetDate(),
	FileName varchar(max) NOT NULL,
	ProductID smallint FOREIGN KEY REFERENCES Products(ProductID) NOT NULL,
	UserID bigint FOREIGN KEY REFERENCES Users(UserID) NOT NULL,
)

-------Insert Test Data-------

INSERT INTO Users (EmailAddress, FirstName, LastName) 
VALUES 
	('test@discordapp.com', 'Test', 'User'),
	('test@discord.com', 'Test', 'User')

INSERT INTO Products (ProductName)
VALUES
	('ClydeAI'),
	('Home V3'),
	('Nitro-Onboarding V4')


INSERT INTO Downloads (DownloadDate, FileName, ProductID, UserID)
VALUES
	(GETDATE(), dbo.GetHomeFileName(), 2, 1),
	(GETDATE(), dbo.GetClydeFileName(), 1, 2),
	(GETDATE(), dbo.GetHomeFileName(), 2, 2)

-------SELECT AND JOIN DATA FOR EASY VIEWING-------

