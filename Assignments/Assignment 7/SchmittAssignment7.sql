USE MyGuitarShop
GO

--1
INSERT INTO Categories (CategoryName)
VALUES ('Brass');

--2
UPDATE Categories
SET CategoryName = 'Woodwinds'
WHERE CategoryID = (SELECT TOP 1 CategoryID FROM Categories WHERE CategoryName = 'Brass');

--3
DELETE FROM Categories
WHERE CategoryName = 'Woodwinds';

--4
INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
VALUES (4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, GETDATE());

--5
UPDATE Products
SET DiscountPercent = 35
WHERE ProductCode = 'dgx_640';

--6
DELETE FROM Products
WHERE CategoryID = 4;
DELETE FROM Categories
WHERE CategoryID = 4;

--7
INSERT INTO Customers (EmailAddress, Password, FirstName, LastName)
VALUES ('rick@raven.com', '', 'Rick', 'Raven');

--8
UPDATE Customers
SET Password = 'secret'
WHERE EmailAddress = 'rick@raven.com';

--9
UPDATE Customers
SET Password = 'reset'

--10
INSERT INTO Categories (CategoryName)
VALUES ('Acoustic Guitars');
INSERT INTO Categories (CategoryName)
VALUES ('Electric Guitars');
INSERT INTO Categories (CategoryName)
VALUES ('Bass Guitars');

INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DateAdded)
VALUES (1, 'acou_001', 'Acoustic Guitar', 'Beautiful sounding acoustic guitar', 999.99, GETDATE());
INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DateAdded)
VALUES (2, 'elec_001', 'Electric Guitar', 'Sleek electric guitar with a variety of tones', 1199.99, GETDATE());
INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DateAdded)
VALUES (3, 'bass_001', 'Bass Guitar', 'Solid and comfortable bass guitar', 799.99, GETDATE());

INSERT INTO Customers (EmailAddress, Password, FirstName, LastName)
VALUES ('john@example.com', 'password123', 'John', 'Doe');
INSERT INTO Customers (EmailAddress, Password, FirstName, LastName)
VALUES ('jane@example.com', 'qwerty123', 'Jane', 'Doe');

INSERT INTO Orders (CustomerID, OrderDate, ShipDate)
VALUES (1, '2022-05-01', '2022-05-05');
INSERT INTO Orders (CustomerID, OrderDate, ShipDate)
VALUES (2, '2022-06-01', NULL);

--SELECT * FROM Categories
--SELECT * FROM Products
--SELECT * FROM Customers