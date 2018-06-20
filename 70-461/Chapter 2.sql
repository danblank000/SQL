--Date Time Formats
select GETDATE()
select CURRENT_TIMESTAMP
select SYSDATETIME()
select SYSDATETIMEOFFSET() --TimeZone
select GETUTCDATE()


--Show only date and not time
SELECT CAST(SYSDATETIME() AS date)

SELECT SUBSTRING(CAST(CAST(SYSDATETIME() AS DATE) AS varchar),6,2)

SELECT DATENAME(MONTH, (CAST(SYSDATETIME() AS varchar)))

SELECT DATEFROMPARTS(2017,9,17)

SELECT EOMONTH(SYSDATETIME())

SELECT DATEADD(DAY, 105, '20170917')

SELECT DATEDIFF(DAY, '19830921', '20170917')

--Timezone
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-00:00')
SELECT TODATETIMEOFFSET('20170917 13:00', '+04:00')

SELECT CAST(DATEADD(mm, - 3, GETDATE()) AS DATE)

SELECT YEAR(DATEADD(yy, -1, GETDATE()))








SELECT empid
	, country
	, region
	, city
	, country + N',' + region + N',' + city AS 'location'
FROM HR.Employees
---This returns NULL values in some rows


--Replacing NULLs
SELECT empid
	, country
	, region
	, city
	, country + COALESCE( N',' + region,  N'') + N',' + city AS 'coalesce' --Removing NULL with COALESCE
	, CONCAT (country, N',' + region, N',' + city) AS 'concat' --Removing NULL with CONCAT
FROM HR.Employees



--SUBSTRINGS
SELECT LEFT('abcdef' ,3) AS 'left'
	, RIGHT('abcdef' ,3) AS 'right'

--Find Strings
SELECT CHARINDEX('ef', 'abcdef')

--Combining the 2
SELECT LEFT('Daniel Blank', CHARINDEX(' ', 'Daniel Blank') -1)







--Strinng Length
SELECT LEN('Daniel Blank') AS 'len'
	, DATALENGTH(N'Daniel Blank') AS 'datalength'

--String legnth in bytes 
SELECT DATALENGTH('Daniel Blank') 


--String Alteration
SELECT REPLACE('Daniel.Blank','.',' ')  AS 'replace'
	, REPLICATE('a',10) + 'rgh!' AS 'replicate'
	, STUFF('abcdefghijklmnop', 5, 5, '12345') AS 'stuff'


--String formatting
SELECT UPPER('DAniEl bLANk') AS 'upper'
	, LOWER('DAniEl bLANk') AS 'lower'
	, LTRIM('              Daniel Blank') AS 'ltrim'
	, RTRIM('Daniel Blank              ') AS 'rtrim'
	, RTRIM(LTRIM('     DanielBlank     ')) AS 'l_and_r_trim'
	,FORMAT(123456,'000000000') AS 'format'







--Simple CASE Expression
SELECT productid
	, productname
	, unitprice
	, discontinued
	, CASE discontinued
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'Unknoown'
	END AS 'discontinued_desc'
FROM Production.Products


--Searched CASE Expression
SELECT productid
	, productname
	, unitprice
	, CASE
		WHEN unitprice < 20.00 THEN 'Low'
		WHEN unitprice < 40.00 THEN 'Medium'
		WHEN unitprice >= 40.00 THEN 'High'
		ELSE 'Unknown'
	END AS pricerange
FROM Production.Products

