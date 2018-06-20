SELECT dbo.ContractEntityCode(M.EntityRef)
	, Number
	, WIPLimit
	, CreditLimit
FROM Matters AS M
WHERE Created > DATEADD(mm, -1, GETDATE())
