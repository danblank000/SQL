SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name
	, M.Number
	, M.Description
	, M.Created
	, M.WIPLimit
	, M.CreditLimit
	, UF.FullName AS 'Fee-Earner'
	, UP.FullName AS 'Partner'
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
	AND (M.WIPLimit = 0.00
	OR M.CreditLimit = 0.00)