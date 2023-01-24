
--Select specifically the CustomerID and the Last Name from the customers table
SELECT CustomerID, LastName FROM dbo.Customers

--Select all records from the entire customers table
SELECT * FROM dbo.Customers

--Select all records which contain the last name Brown
SELECT * FROM dbo.Customers WHERE LastName = 'Brown'

--Select all customers' IDs and Last Names only if thier last names are between M and Z sorted aplphabetically
SELECT CustomerID, LastName FROM dbo.Customers WHERE LastName BETWEEN 'M' AND 'Z' ORDER BY LastName


--Select all entires from the orders table where the tax amount is greater than 100 and card type is VISA
--Return all columns, sort data by the Order ID Ascending least to greatest
SELECT * FROM dbo.Orders WHERE TaxAmount >= 100 AND CardType = 'VISA' ORDER BY OrderID ASC