USE MyGuitarShop
GO

--1
SELECT 
	ListPrice,
	CAST(ListPrice AS decimal(10, 1)) AS ListPriceCast,
	CONVERT(int, ListPrice) AS ListPriceConvert,
	CAST(ListPrice AS int) AS ListPriceInt
FROM Products

--2
SELECT
	DateAdded,
	CAST(DateAdded AS Date) AS Date,
	CAST(DateAdded AS Time) AS Time,
	CAST(DateAdded AS char(7)) AS ReadableDate
FROM Products

--3
SELECT
	
	CONVERT(varchar(10), CAST(OrderDate AS date), 101) AS d
	
FROM Orders