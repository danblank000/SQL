/*

LESSON 1

*/


-- SINGLE GROUPING SETS
SELECT shipperid
	, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY shipperid;


SELECT shipperid
	, YEAR(shippeddate) as 'shippedyear'
	, COUNT(*) as numorders
FROM Sales.Orders
GROUP BY shipperid, YEAR(shippeddate)
ORDER BY YEAR(shippeddate), shipperid

SELECT shipperid
	, YEAR(shippeddate) as 'shippedyear'
	, COUNT(*) as numorders
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY shipperid
	, YEAR(shippeddate)
HAVING COUNT(*) < 100
ORDER BY YEAR(shippeddate), shipperid;

SELECT shipperid
	, COUNT(*) AS 'numorders'
	, COUNT(shippeddate) AS 'shippedorders'
	, MIN(shippeddate) AS 'firstshipdate'
	, MAX(shippeddate) AS 'lastshipdate'
	, SUM(val) AS 'totalvalue'
FROM Sales.OrderValues
GROUP BY shipperid


--ADDING DISTINT TO AGGREGATE FUNCTION
SELECT shipperid
	, COUNT(DISTINCT shippeddate) AS 'numshippingdates'
FROM Sales.Orders
GROUP BY shipperid


--INVALID, must be part of group by or aggregate
SELECT S.shipperid
	, S.companyname
	, COUNT(*) AS 'numorders'
FROM Sales.Shippers AS S
JOIN Sales.Orders AS O ON S.shipperid = O.shipperid
GROUP BY S.shipperid


--MULTIPLE GROUPING SETS
SELECT shipperid
	, YEAR(shippeddate) AS 'shipyear'
	, COUNT(*) AS 'numorders'
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY GROUPING SETS
(
	(shipperid, YEAR(shippeddate)),
	(shipperid					 ),
	(YEAR(shippeddate)			 ),
	(							 )
);


--CUBE
SELECT shipperid
	, YEAR(shippeddate) AS 'shipyear'
	, COUNT(*) AS 'numorders'
FROM Sales.Orders
GROUP BY CUBE (shipperid, YEAR(shippeddate))


--ROLLUP
SELECT shipcountry
	, shipregion
	, shipcity
	, COUNT(*) AS 'numorders'
FROM Sales.Orders
GROUP BY ROLLUP (shipcountry, shipregion, shipcity);



/*

LESSON 2

*/

WITH PivotData AS 
(
	SELECT custid -- grouping column 
		, shipperid -- spreading column
		, freight -- aggregation column
	FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
	PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3])) AS P;