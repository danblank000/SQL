SELECT empid
	, firstname
	, lastname
	, country
	, region
	, city
FROM HR.Employees
WHERE region <> N'WA'
	OR region IS NULL;


select * from hr.Employees
where NOT region = 'wa'
	or region  IS NULL


SELECT * from HR.Employees
WHERE titleofcourtesy like N'%.%'





SELECT orderid
	, orderdate
	, empid
	, custid
FROM Sales.Orders
WHERE orderdate >= '20070201'
	AND orderdate < '20070301'



SELECT TOP (3) orderid
	, orderdate
	, custid
	, empid
FROM Sales.Orders
WHERE shippeddate IS NULL



SELECT TOP (3) orderid
	, shippeddate
FROM Sales.Orders
WHERE custid = 20
ORDER BY CASE 
	WHEN ShippedDate IS NULL THEN 1 
	ELSE 0 
	END, ShippedDate




DECLARE @pagesize AS BIGINT = 25, @pagenum AS BIGINT = 3

SELECT orderid
	, orderdate
	, custid
	, empid
FROM Sales.Orders
ORDER BY orderdate DESC
	, orderid DESC
OFFSET (@pagenum - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;
