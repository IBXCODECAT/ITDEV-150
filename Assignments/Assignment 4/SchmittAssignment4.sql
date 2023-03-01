USE MyGuitarShop

--Query 1
SELECT Categories.CategoryName, Products.ProductName, Products.ListPrice
FROM Categories
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID
ORDER BY Categories.CategoryName ASC, Products.ProductName ASC;

--Query 2
SELECT Customers.FirstName, Customers.LastName, Addresses.Line1, Addresses.City, Addresses.State, Addresses.ZipCode
FROM Customers
INNER JOIN Addresses
ON Customers.CustomerID = Addresses.AddressID
WHERE Customers.EmailAddress = 'allan.sherwood@yahoo.com'

--Query 3
SELECT Customers.FirstName, Customers.LastName, Addresses.Line1, Addresses.City, Addresses.State, Addresses.ZipCode
FROM Customers
INNER JOIN Addresses
ON Customers.CustomerID = Addresses.CustomerID
AND Customers.ShippingAddressID = Addresses.AddressID;

--Query 4
SELECT c.LastName, c.FirstName, o.OrderDate, p.ProductName, oi.ItemPrice, oi.DiscountAmount, oi.Quantity
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID
JOIN OrderItems AS oi
ON o.OrderID = oi.OrderID
JOIN Products AS p
ON oi.ProductID = p.ProductID
ORDER BY c.LastName ASC, o.OrderDate ASC, p.ProductName ASC;

--Query 5
SELECT C.CategoryName, P.ProductName
FROM Categories AS C
LEFT OUTER JOIN Products AS P
ON C.CategoryID = P.CategoryID
WHERE P.ProductID IS NULL

--Query 6
SELECT 'SHIPPED' AS ShipStatus, OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NOT NULL
UNION 
SELECT 'NOT SHIPPED' AS ShipStatus, OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NULL
ORDER BY OrderDate;