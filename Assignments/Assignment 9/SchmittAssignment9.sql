-------SET SQL SERVER ENV-------

--Use the master database so we can alter or drop the MyWebDB database later if needed
USE master
GO

-------RESET TEST DATABASE-------

--Drop the MyWebDB database if it already exists for testing purposes
IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'MyWebDB')
DROP DATABASE [MyWebDB]
GO --Wait for the database to be dropped

CREATE DATABASE MyWebDB --Create the MyWebDB Database
GO -- Wait for the database to be created

USE MyWebDB -- Set the current database
GO -- Wait for the database to be loaded

-------Setup Database Functions-------

IF EXISTS (
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

-------CREATE DATABASE TABLES-------

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

-------INSERT TEST DATA-------

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

SELECT 
	JOIN_U.EmailAddress,
	JOIN_U.FirstName,
	JOIN_U.LastName,
	BASE_D.DownloadDate,
	BASE_D.FileName,
	JOIN_P.ProductName
FROM Downloads AS BASE_D
INNER JOIN Products AS JOIN_P ON BASE_D.UserID=JOIN_P.ProductID
INNER JOIN Users AS JOIN_U ON BASE_D.UserID=JOIN_U.UserID
ORDER BY EmailAddress DESC

-------ALTER TABLES-------

--Add columns to products table
ALTER TABLE Products
ADD Price DECIMAL(5, 2) DEFAULT 9.99
ALTER TABLE Products
ADD DateAdded datetime

--Update the users table with a memory allocation limit
ALTER TABLE Users
ALTER COLUMN FirstName varchar(20) NOT NULL

-------ATTEMPT TO UPDATE WITH FAIL CONDITIONS-------

--Attempt to insert a null value into first name (THIS SHOULD FAIL)
UPDATE Users 
SET FirstName = NULL
WHERE Users.UserID = 1

--Attempt to insert a value greater than the 20 bytes allocated
UPDATE Users
Set FirstName = '01234567890123456789-OVERFLOW'
WHERE Users.UserID = 1