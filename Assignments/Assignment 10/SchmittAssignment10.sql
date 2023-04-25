--Use Database
USE MyGuitarShop

--1
GO
CREATE VIEW CustomerAddresses AS
	SELECT c.CustomerID, EmailAddress, LastName, FirstName, 
		ba.Line1 AS BillLine1, ba.Line2 AS BillLine2, 

		ba.City AS BillCity, ba.State AS BillState, ba.ZipCode AS BillZip, 
		sa.Line1 AS ShipLine1, sa.Line2 AS ShipLine2, 
		sa.City AS ShipCity, sa.State AS ShipState, sa.ZipCode AS ShipZip 
	FROM Customers AS c
		INNER JOIN Addresses ba ON c.BillingAddressID  = ba.AddressID
		INNER JOIN Addresses sa ON c.ShippingAddressID = sa.AddressID

GO
--2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses

SELECT o.OrderID, OrderDate, TaxAmount, ShipDate, 
       ProductName, ItemPrice, DiscountAmount, ItemPrice - DiscountAmount AS FinalPrice, Quantity, 
       (ItemPrice - DiscountAmount) * Quantity AS ItemTotal       
FROM Orders AS o
    JOIN OrderItems li ON o.OrderID = li.OrderID
    JOIN Products p ON li.ProductID = p.ProductID

--3
UPDATE CustomerAddresses
SET ShipLine1 = '1990 Westwood Blvd.'
WHERE CustomerID = 8

--4
GO
CREATE VIEW OrderItemProducts AS
	SELECT o.OrderID, OrderDate, TaxAmount, ShipDate, 
       ProductName, ItemPrice, DiscountAmount, ItemPrice - DiscountAmount AS FinalPrice, Quantity, 
       (ItemPrice - DiscountAmount) * Quantity AS ItemTotal       
	FROM Orders AS o
		INNER JOIN OrderItems li ON o.OrderID = li.OrderID
		INNER JOIN Products p ON li.ProductID = p.ProductID

--5
GO
CREATE VIEW ProductSummary AS
	SELECT ProductName, Quantity, FinalPrice AS OrderTotal
	FROM OrderItemProducts

--6
GO
SELECT TOP 5 ProductName, OrderTotal
FROM ProductSummary
ORDER BY OrderTotal DESC

--7
GO
CREATE PROCEDURE MyStoredProcedure
    @Param INT
AS
BEGIN
    PRINT @Param
END

--8
EXEC MyStoredProcedure @Param = 2
