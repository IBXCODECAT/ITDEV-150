--IN Class Notes

USE AP

-- COUNT(Column)
SELECT COUNT(VendorID)
FROM Vendors

-- COUNT()
SELECT 
	COUNT(*) AS TotalInvoices, 
	SUM(InvoiceTotal - PaymentTotal - CreditTotal) AS AmountOutstanding
FROM
	Invoices
WHERE
	InvoiceTotal - PaymentTotal - CreditTotal > 0

SELECT SUM(CreditTotal), VendorID
FROM Invoices
GROUP BY VendorID
