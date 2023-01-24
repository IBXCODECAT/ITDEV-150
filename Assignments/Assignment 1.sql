
--USE STATEMENT (GLOBAL, MAY NEED TO COMMENT OUT WHEN GRADING)
USE MyGuitarShop

--Exercise One
SELECT ProductName, ListPrice, DateAdded 
FROM dbo.Products 
ORDER BY ProductName ASC

--Exercise Two
SELECT * 
FROM dbo.Categories 
ORDER BY CategoryID DESC

--Exercise Three
SELECT CustomerID, Line1, Line2, City, State, ZipCode 
FROM dbo.Addresses
WHERE State = 'NY'

--Exercise Four
SELECT OrderID, ShipAmount, CardType, CardNumber, CardExpires
FROM dbo.Orders
WHERE CardType = 'VISA'

--Exercise Five
SELECT ProductName, ListPrice
FROM dbo.Products

--Exercise Six
SELECT *
FROM dbo.OrderItems
WHERE DiscountAmount > 1000

--Exercise Seven
SELECT *
FROM Administrators
ORDER BY LastName ASC

--Exercise Eight
SELECT FirstName, LastName, emailAddress
FROM dbo.Customers
WHERE LastName >= 'M'
ORDER BY LastName

--Exercise Nine
SELECT *
FROM dbo.OrderItems
WHERE OrderID > 30