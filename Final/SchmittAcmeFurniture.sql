
--Kill the connection if the database already exists so we can safely drop it
IF DB_ID('AcmeFurniture') IS NOT NULL
	USE [master];

	DECLARE @kill varchar(8000) = '';  
	SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
	FROM sys.dm_exec_sessions
	WHERE database_id  = db_id('MyDB')

	EXEC(@kill);

--Drop the database and create a new one if it already exists
DROP DATABASE IF EXISTS AcmeFurniture;
GO
CREATE DATABASE AcmeFurniture;
GO

USE AcmeFurniture;

CREATE TABLE Territory (
  TerritoryNumber INT,
  TerritoryName VARCHAR(50),
  Region VARCHAR(50),
  Quota DECIMAL(10,2),

  PRIMARY KEY(TerritoryNumber)
);

CREATE TABLE Employee (
  EmployeeID INT,
  EmpName VARCHAR(50),
  EmpAddress1 VARCHAR(50),
  EmpAddress2 VARCHAR(50),
  EmpCity VARCHAR(50),
  EmpState VARCHAR(2),
  EmpZip VARCHAR(10),
  EmpPhone VARCHAR(20),

  PRIMARY KEY(EmployeeID)
);

CREATE TABLE SalesRep (
  EmployeeID INT,
  MTDSales DECIMAL(10,2),
  YTDSales DECIMAL(10,2),
  MTDCommission DECIMAL(10,2),
  YTDSCommission DECIMAL(10,2),
  CommissionRate DECIMAL(4,2),
  TerritoryNumber INT,

  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (TerritoryNumber) REFERENCES Territory(TerritoryNumber)
);

CREATE TABLE Customer (
  CustomerNumber INT,
  FName VARCHAR(50),
  LName VARCHAR(50),
  Address1 VARCHAR(50),
  Address2 VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(2),
  ZipCode VARCHAR(10),
  PhoneNum VARCHAR(20),
  MTDSales DECIMAL(10,2),
  YTDSales DECIMAL(10,2),
  CurrentBalance DECIMAL(10,2),
  CreditLimit DECIMAL(10,2),
  ShipName VARCHAR(50),
  ShipAddress1 VARCHAR(50),
  ShipAddress2 VARCHAR(50),
  ShipCity VARCHAR(50),
  ShipState VARCHAR(2),
  ShipZipCode VARCHAR(10),
  CurrentInvoiceTotal DECIMAL(10,2),
  CurrentPaymentTotal DECIMAL(10,2),
  CurrentAmount DECIMAL(10,2),
  Over30 INT,
  Over60 INT,
  Over90 INT,
  PreviousBalance DECIMAL(10,2),
  EmployeeID INT,

  PRIMARY KEY (CustomerNumber),
  FOREIGN KEY (EmployeeID) REFERENCES SalesRep(EmployeeID)
);

CREATE TABLE Vendor (
  VendorNumber INT,
  Name VARCHAR(50),
  Address VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(2),
  ZipCode VARCHAR(10),
  Phonenum VARCHAR(20),
  Credit_limit DECIMAL(10,2),

  PRIMARY KEY (VendorNumber)
);

CREATE TABLE Part (
  PartNumber INT ,
  VendorNumber INT,
  PartDescription VARCHAR(50),
  UnitPrice DECIMAL(10,2),
  MTDSales DECIMAL(10,2),
  YTDSales DECIMAL(10,2),
  UnitsOnHand INT,
  UnitsAllocated INT,
  ReorderPoint INT,
  VendorPrice DECIMAL(10,2),
  MinimumOrderQuantity INT,
  ExpectedLeadTime INT,

  PRIMARY KEY (PartNumber, VendorNumber),
  FOREIGN KEY (VendorNumber) REFERENCES Vendor(VendorNumber)
);

CREATE TABLE Orders (
  OrderNumber INT,
  OrderDate DATE,
  CustomerNumber INT,
  CustomerPONumber VARCHAR(50),
  OrderTotal DECIMAL(10,2),
  OrderStatus VARCHAR(50),
  OrderSpecialCharges DECIMAL(10,2),
  OrderSpecialChargeDescription VARCHAR(50),
  ShipName VARCHAR(50),
  ShipAddress1 VARCHAR(50),
  ShipAddress2 VARCHAR(50),
  ShipCity VARCHAR(50),
  ShipState VARCHAR(2),
  ShipZip VARCHAR(10),

  PRIMARY KEY (OrderNumber),
  FOREIGN KEY (CustomerNumber) REFERENCES Customer(CustomerNumber)
);

CREATE TABLE OrderDetail (
  OrderNumber INT,
  SEQNumber INT,
  PartNumber INT,
  VendorNumber INT,
  NumberOrdered INT,
  QuotedPrice DECIMAL(10,2),
  LineTotal DECIMAL(10,2),
  Comments VARCHAR(50),
  PRIMARY KEY (OrderNumber, SEQNumber),
  FOREIGN KEY (OrderNumber) REFERENCES Orders(OrderNumber),
  FOREIGN KEY (PartNumber, VendorNumber) REFERENCES Part(PartNumber, VendorNumber)
);

CREATE TABLE Invoice (
  InvoiceNumber INT,
  ShipDate DATE,
  Freight DECIMAL(10,2),
  ShipStatus VARCHAR(20),

  PRIMARY KEY(InvoiceNumber)
);

CREATE TABLE InvoiceDetail (
  InvoiceNumber INT,
  OrderNumber INT,
  SEQNumber INT,
  QuantityShipped INT,

  PRIMARY KEY (InvoiceNumber, OrderNumber, SEQNumber),
  FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber),
  FOREIGN KEY (OrderNumber, SEQNumber) REFERENCES OrderDetail(OrderNumber, SEQNumber)
);

CREATE TABLE Payment (
  PaymentNumber INT,
  CustomerNumber INT,
  PaymentDate DATE,
  Amount DECIMAL(10,2),

  PRIMARY KEY(PaymentNumber),
  FOREIGN KEY (CustomerNumber) REFERENCES Customer(CustomerNumber),
);