SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name
	, M.Number AS 'Matter'
	, M.Description
	, M.Created
	, M.WIPLimit
	, M.CreditLimit
	, UF.FullName AS 'Fee-Earner'
	, UP.FullName AS 'Partner'
	, UP.EMailExternal
	, D.Description AS 'Department'
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D On UP.Department = D.Code
WHERE M.Created > '2018-06-01 00:00:00.000'
	AND M.Created < DATEADD(dd, -30, GETDATE())
	AND M.WIPLimit = 0.00
ORDER BY D.Description
	, M.EntityRef
	, M.Number
	, UF.FullName