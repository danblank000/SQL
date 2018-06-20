SELECT dbo.ContractEntityCode(M.entityref) AS 'Entity'
	, E.Name
	, CAST(M.Number AS varchar) AS 'Matter'
	, M. Description
	, L.Description AS 'Lock Name'
FROM Matters AS M
INNER JOIN Locks AS L on M.LockID = L.Code
JOIN Entities AS E ON M.EntityRef = E.Code
WHERE M.LockID > ''
UNION
SELECT E.ShortCode
	, '0 (Entire Entity)' AS 'Matter'
	, E.Name
	, L.Description
FROM Entities AS E
INNER JOIN Locks AS L ON E.LockID = L.Code
WHERE E.LockID > ''
ORDER BY [Lock Name]
