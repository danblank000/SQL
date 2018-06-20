WITH LockData (Entity, Number, Description, Lock, FullName, Created)
AS(	
	SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
		, M.Number AS 'Number'
		, M.Description
		, L.Description AS 'Lock'
		, U.FullName
		, M.Created
	FROM Matters AS M
	JOIN Locks AS L ON M.LockID = L.Code
	JOIN Keys AS K ON L.Code = K.LockRef
	JOIN Users AS U ON K.UserRef = U.Code
	WHERE M. LockID <> 0
	--ORDER BY M.Created
		--, Entity
		--, Number
		--, FullName
)

SELECT DISTINCT FullName
FROM LockData
-- WHERE FullName like 'Z%'
ORDER BY FullName