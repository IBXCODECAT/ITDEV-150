USE MyGuitarShop
GO

--1

--SELECT DISTINCT CategoryName
--FROM Categories c JOIN Products p
--ON c.CategoryID = p.CategoryID
--ORDER BY CategoryName

SELECT CategoryName 
FROM Categories
WHERE CategoryID IN
	(SELECT DISTINCT CategoryID FROM Products)
ORDER BY CategoryName

SELECT * FROM Categories

--2

SELECT ProductName, ListPrice
	FROM Products
	WHERE ListPrice > (
		SELECT 
			AVG (
				ListPrice
			)
			FROM Products
		)
		ORDER BY ListPrice DESC
			

--3
-- Write a SELECT statement that reutrns category name from categories table
-- Return one row for each category that has never been assigned to a product in the products table
-- When doing this use a subquerry introduced with the NOT EXISTS operator

SELECT CategoryName
	FROM Categories AS c
	WHERE NOT EXISTS (
		SELECT *
		FROM Products
		WHERE CategoryID = c.CategoryID
		)