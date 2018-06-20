SELECT DISTINCT dbo.ContractEntityCode(M.EntityRef) AS 'Entity Ref'
	,E.Name
FROM Matters M
JOIN Entities E ON M.EntityRef = E.Code
WHERE M.CaseTypeRef IN (
		SELECT T.code
		FROM CaseTypes T
		WHERE T.CaseTypeGroupRef = 51
		)
	AND E.SubCategory <> 'PRI'