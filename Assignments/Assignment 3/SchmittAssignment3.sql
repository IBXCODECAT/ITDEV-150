
--Step 1 (Create Table)
USE MyGuitarShop

--Step 2
SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM dbo.Products
ORDER BY ListPrice DESC

--Step 3
SELECT CONCAT(LastName, ', ', FirstName) AS FullName
FROM Customers
WHERE LastName >= 'M' AND LastName <= 'Z'
ORDER BY LastName ASC;


--Step 4
SELECT ProductName, ListPrice, DateAdded
FROM dbo.Products
WHERE ListPrice > 500 AND ListPrice < 2000
ORDER BY DateAdded DESC

--Step 5
SELECT 
    ProductName,
    ListPrice,
    DiscountPercent,
    ListPrice * (DiscountPercent * .01) AS DiscountAmount,
    ListPrice - (ListPrice * (DiscountPercent * .01)) AS DiscountPrice
FROM 
    Products
ORDER BY 
    DiscountPrice DESC;

--Step 6
SELECT 
    ItemID,
    ItemPrice,
    DiscountAmount,
    Quantity,
    ItemPrice * Quantity AS PriceTotal,
    DiscountAmount * Quantity AS DiscountTotal,
    (ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM OrderItems
WHERE (ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY ItemTotal DESC;


