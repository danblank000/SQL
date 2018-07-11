--Financials
SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName AS 'Fee-Earner'
	, UP.FullName AS 'Partner'
	, D.Description
	, SUM(M.WIpLimit) OVER(PARTITION BY D.Description) AS total
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D ON UP.Department = D.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
	AND M.WIPLimit <> 0.00
ORDER BY UP.department







SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName AS 'Fee-Earner'
	, UP.FullName AS 'Partner'
	, D.Description
	--, SUM(M.WIpLimit) OVER(PARTITION BY D.Description) AS total
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D ON UP.Department = D.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
	AND M.WIPLimit <> 0.00
GROUP BY GROUPING SETS (
	(M.EntityRef
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName
	, UP.FullName
	, D.Description), 
	(D.Description))
ORDER BY D.Description



SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName AS 'Fee-Earner'
	, UP.FullName AS 'Partner'
	, D.Description
	, SUM(M.WIpLimit) OVER(PARTITION BY D.Description) AS total
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D ON UP.Department = D.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
	AND M.WIPLimit <> 0.00
GROUP BY ROLLUP (D.Description)
ORDER BY D.Description
	, M.EntityRef
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName
	, UP.FullName



GROUP BY GROUPING SETS (
	(M.EntityRef
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, UF.FullName
	, UP.FullName
	, D.Description), 
	(D.Description))
ORDER BY D.Description










SELECT MAX(dbo.ContractEntityCode(M.EntityRef)) AS 'Entity'
	, MAX(E.Name)
	, MAX(M.Number)
	, MAX(M.Description)
	, MAX(M.Created)
	, MAX(M.WIPLimit)
	, MAX(UF.FullName) AS 'Fee-Earner'
	, MAX(UP.FullName) AS 'Partner'
	, MAX(D.Description)
	--, SUM(M.WIpLimit) OVER(PARTITION BY D.Description) AS total
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D ON UP.Department = D.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
	AND M.WIPLimit <> 0.00
GROUP BY ROLLUP (D.Description)