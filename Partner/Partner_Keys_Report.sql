SELECT K.UserRef AS 'Initials'
	, U.FullName as 'Name'
	, L.Description as 'Lock Name' 
FROM Keys AS K 
INNER JOIN Locks AS L ON K.LockRef = L.Code
INNER JOIN Users AS U ON K.UserRef = U.Code
ORDER BY L.Description




SELECT dbo.ContractEntityCode(M.entityref) AS 'Entity'
	, CAST(M.Number AS varchar) AS 'Matter'
	, M. Description
	, L.Description AS 'Lock Name'
FROM Matters AS M
INNER JOIN Locks AS L on M.LockID = L.Code
WHERE M.LockID > ''
UNION
SELECT E.ShortCode
	, '0 (Entire Entity)' AS 'Matter'
	, E.Name
	, L.Description
FROM Entities AS E
INNER JOIN Locks AS L ON E.LockID = L.Code
WHERE E.LockID > ''
ORDER BY [Lock Name], Entity, Matter
