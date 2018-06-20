SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, M.Number AS 'Matter'
	, U.FullName AS 'Fee Earner'
	, D.Description AS 'Department'
	, M.UnbilledTimeBalanceValue AS 'Unbilled WIP Value'
	, M.UnpaidBillBalance AS 'Unpaid Bills Value'
	, M.Client_Ac_Balance AS 'Client Account Balance'
FROM (
	SELECT EntityRef
		, MatterNoRef
	FROM TimeTransactions
	WHERE TransactionDate > DATEADD(mm, -6, GetDate())
	GROUP BY EntityRef
		, MatterNoRef) AS Q1
INNER JOIN Matters AS M
	ON Q1.EntityRef = M.EntityRef
	AND Q1.MatterNoRef = M.Number
JOIN Users AS U
	ON U.Code = M.FeeEarnerRef
JOIN Users AS U2
	ON U2.code = M.PartnerRef
JOIN Departments AS D
	ON D.Code = U2.Department
ORDER BY M.EntityRef
	, M.Number
	, D.Description
	, U.FullName