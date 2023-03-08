USE AP
GO

--This is here because I acidentally inserted twice
DELETE FROM Invoices WHERE VendorID = 12;

GO

--Force insert new invoice per manager request
--/*
INSERT INTO Invoices (
	VendorID,
	InvoiceNumber,
	InvoiceDate,
	InvoiceTotal,
	TermsID,
	InvoiceDueDate
)
VALUES (
	12,
	'3289175',
	CAST(GETDATE() AS VARCHAR(max)),
	165,
	3,
	'3/18/2022'
);
--*/

GO

--Make sure I did it right lol
SELECT * FROM Invoices
WHERE VendorID = 12

--Update Legacy Non D-GG Sans Invoice
UPDATE Invoices
	SET 
		CreditTotal = 35.89,
		PaymentTotal = 3000,
		PaymentDate = '2023-03-07 14:52:55:01'
	WHERE InvoiceNumber = '367447'

GO

--Make sure i did it right lol
SELECT * FROM Invoices
WHERE InvoiceNumber = '367447'
