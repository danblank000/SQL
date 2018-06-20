SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name AS 'Entity Name'
	, M.Number AS 'Matter'
	, M.Description AS 'Matter Description'
	, U.FullName AS 'Fee-Earner'
	, U2.FullName AS 'Lead Partner'
	, M.UnbilledTimeBalanceValue AS 'Unbilled Time Balance Value'
	, M.Client_Ac_Balance AS 'Client Account Balance'
	, M.UnpaidBillBalance AS 'Unpaid Bill Balance'
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS U ON M.FeeEarnerRef = U.Code
JOIN Users AS U2 ON M.PartnerRef = U2.Code
WHERE M.FileNumber = 'CMR'