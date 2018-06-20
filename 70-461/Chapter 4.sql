/*

LESSON 1

*/


-- CROSS JOIN example
Select D.n AS theday
	, S.n AS shiftno
from dbo.Nums AS D
	CROSS JOIN dbo.Nums AS S
Where D.n <= 7
AND S.n <= 3
ORDER BY theday, shiftno;

--INNER JOIN example
SELECT S.companyname AS 'Supplier'
	, S.country
	, P.productid
	, P.productname
	, P.unitprice
FROM Production.Suppliers AS S
	INNER JOIN Production.Products AS P 
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'


-- OUTER JOINS
Select e.empid 
	, e.lastname + N' ' + e.lastname AS 'Employee'
	, m.firstname + N' ' + m.lastname AS 'Manager'
FROM HR.Employees AS E
	INNER JOIN HR.Employees AS M 
		ON E.mgrid = M.empid

SELECT e.empid 
	, e.firstname + ' ' + e.lastname as 'Employee'
	, m.firstname + ' ' + m.lastname as 'Manager'
FROM HR.Employees AS e
	LEFT JOIN HR.Employees as m 
		on e.mgrid = m.empid



SELECT S.companyname AS 'Supplier'
	, S.country
	, P.productid
	, P.productname
	, P.unitprice
FROM Production.Suppliers AS S
	LEFT OUTER JOIN Production.Products AS P
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'



select * from Production.Suppliers
select * from Production.Products
select * from Production.Categories


-- Multi Join Queries
SELECT S.companyname AS 'Supplier'
	, S.country
	, P.productid
	, P.productname
	, P.unitprice
	, C.categoryname
FROM Production.Suppliers AS S
	LEFT OUTER JOIN 
		(Production.Products AS P
			INNER JOIN Production.Categories AS C
				ON P.categoryid = C.categoryid)
		ON S.supplierid = P.supplierid
WHERE S.country = N'Japan'



--PRACTICE
SELECT C.custid
	, C.companyname
	, O.orderid
	, o.orderdate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O ON C.custid = O.custid
WHERE O.orderid IS NULL

SELECT C.custid
	, C.companyname
	, O.orderid
	, o.orderdate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O 
	ON C.custid = O.custid
	AND O.orderdate >= '20080201'
	AND O.orderdate <= '20080301'


/*

LESSON 2

*/


SELECT productid
	, productname
	, unitprice
FROM Production.Products
WHERE unitprice =
	(SELECT MIN(unitprice)
	 FROM Production.Products)


SELECT categoryid
	, productid
	, productname
	, unitprice
FROM Production.Products AS P1
WHERE unitprice =
	(SELECT MIN(unitprice)
	 FROM Production.Products AS P2
	 WHERE P2.categoryid = P1.categoryid
	)


SELECT C.custid
	, C.companyname
FROM Sales.Customers AS C
WHERE EXISTS
	(SELECT *
	 FROM Sales.Orders AS O 
	 WHERE O.custid = C.custid
	 AND O.orderdate = '20070212')



-- DERIVED TABLES
SELECT ROW_NUMBER() OVER
	(PARTITION BY categoryid
	 ORDER BY unitprice
		, productid)
	AS rownum
	, categoryid
	, productid
	, productname
	, unitprice
FROM Production.Products


SELECT categoryid
	, productid
	, productname
	, unitprice
FROM (
	SELECT ROW_NUMBER() OVER
		(PARTITION BY categoryid
		 ORDER BY unitprice
			, productid)
		AS rownum
		, categoryid
		, productid
		, productname
		, unitprice
	FROM Production.Products) AS D
WHERE rownum <= 2


-- CTEs (Common Table Expressions)
WITH C AS 
	(SELECT ROW_NUMBER() OVER(PARTITION BY categoryid
			  ORDER BY unitprice, productid) AS rownum
		, categoryid
		, productid
		, productname
		, unitprice
	FROM Production.Products)
SELECT categoryid
	, productid
	, productname
	, unitprice
FROM C
WHERE rownum <= 2







--Recurring CTE
WITH EmpsCTE AS 
(
	SELECT empid
		, mgrid
		, firstname
		, lastname
		, 0 AS distance
	FROM HR.Employees
	WHERE empid = 9

	UNION ALL

	SELECT M.empid
		, M.mgrid
		, M.firstname
		, M.lastname
		, S.distance + 1 AS distance
	FROM EmpsCTE AS S
		JOIN HR.Employees AS M
			ON S.mgrid = M.empid
)
SELECT empid
	, mgrid
	, firstname
	, lastname
	, distance
FROM EmpsCTE







-- VIEW
IF OBJECT_ID('Sales.RankedProducts', 'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
GO
CREATE VIEW Sales.RankedProducts
AS

SELECT
	ROW_NUMBER() OVER (PARTITION BY categoryid
					   ORDER BY unitprice, productid) AS rownum
	, categoryid
	, productid
	, productname
	, unitprice
FROM Production.Products
GO


SELECT categoryid
	, productid
	, productname
	, unitprice
FROM Sales.RankedProducts
WHERE rownum <= 2





-- Inline Table-Valued Function
IF OBJECT_ID('HR.etManagers', 'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;
GO
CREATE FUNCTION HR.GetManagers(@empid AS INT) RETURNS TABLE
AS

RETURN
	WITH EmpsCTE AS 
	(
		SELECT empid, mgrid, firstname, lastname, 0 AS distance
		FROM HR.Employees
		WHERE empid = @empid

		UNION ALL

		SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
		FROM EmpsCTE AS S
			JOIN HR.Employees AS M
				ON S.mgrid = M.empid
	)
SELECT empid, mgrid, firstname lastname, distance
FROM EmpsCTE
GO

SELECT *
FROM HR.GetManagers(9) AS M;




-- CROSS APPLY

-- 2 lowest priced product from specified supplier
SELECT productid
	, productname
	, unitprice
FROM Production.Products
WHERE supplierid = 1
ORDER BY unitprice
	, productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY

-- 2 lowest priced products from each supplier in Japan
SELECT S.supplierid
	, S.companyname AS supplier
	, A.*
FROM Production.Suppliers AS S
	CROSS APPLY (SELECT productid
					 , productname
					 , unitprice
				 FROM Production.Products AS P
				 WHERE P.supplierid = S.supplierid
				 ORDER BY unitprice
					 , productid
				 OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A
WHERE S.country = N'Japan'

--Outer Applpy
SELECT S.supplierid
	, S.companyname AS supplier
	, A.*
FROM Production.Suppliers AS S
	OUTER APPLY (SELECT productid
					 , productname
					 , unitprice
				 FROM Production.Products AS P
				 WHERE P.supplierid = S.supplierid
				 ORDER BY unitprice
					 , productid
				 OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A
WHERE S.country = N'Japan'


-- Exercise 1

SELECT categoryid
	, MIN(unitprice) AS mn
FROM Production.Products
GROUP BY categoryid


WITH Catmin AS 
(
	SELECT categoryid
		, MIN(unitprice) AS mn
	FROM Production.Products
	GROUP BY categoryid
)
SELECT P.categoryid
	, P.productid
	, P.productname
	, P.unitprice
FROM Production.Products AS P
	INNER JOIN CatMin AS M
		ON P.categoryid = M.categoryid
		AND P.unitprice = M.mn

-- Exercise 2
IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts;
GO
CREATE FUNCTION Production.GetTopProducts(@Supplierid AS INT, @n AS BIGINT)
RETURNS TABLE
AS

RETURN
	SELECT productid
		, productname
		, unitprice
	FROM Production.Products
	WHERE supplierid = @Supplierid
	ORDER BY unitprice
		, productid
	OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY;
GO

SELECT * 
FROM Production.GetTopProducts (3, 3) AS P;



SELECT S.supplierid
	, S.companyname AS 'supplier'
	, A.*
FROM Production.Suppliers AS S
	CROSS APPLY Production.GetTopProducts(S.supplierid, 2) AS A
WHERE S.country = N'Japan'



SELECT S.supplierid
	, S.companyname AS 'supplier'
	, A.*
FROM Production.Suppliers AS S
	OUTER APPLY Production.GetTopProducts(S.supplierid, 2) AS A
WHERE S.country = N'Japan'

IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts;




/*

LESSON 3

*/


--UNION EXAMPLE
SELECT country
	, region
	, city
FROM HR.Employees

UNION

SELECT country
	, region
	, city
FROM Sales.Customers

-- UNION ALL
SELECT country
	, region
	, city
FROM HR.Employees

UNION ALL

SELECT country
	, region
	, city
FROM Sales.Customers




--INTERSECT EXAMPLE
SELECT country
	, region
	, city
FROM HR.Employees

INTERSECT

SELECT country
	, region
	, city
FROM Sales.Customers



-- EXCEPT EXAMPLE
SELECT country
	, region
	, city
FROM HR.Employees

EXCEPT

SELECT country
	, region
	, city
FROM Sales.Customers





/*

CLEANUP

*/
DELETE FROM Production.Suppliers WHERE supplierid > 29;
IF OBJECT_ID('Sales.RankedProducts', 'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
IF OBJECT_ID('HR.GetManagers', 'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;