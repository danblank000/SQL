USE Partner
GO

SELECT MAX(M.FeeEarnerRef) AS 'FE'
	, MAX(U.FullName) AS 'Name'
	, MAX(D.Description) AS 'Department'
	, CAST(SUM(UnbilledTimeBalanceValue) AS Money) AS 'Unbilled WIP Value'
FROM Matters AS M
JOIN Users AS U ON M.FeeEarnerRef = U.Code
JOIN Departments AS D ON U.Department = D.Code
WHERE U.FullName NOT LIKE 'Z%'
	AND M.FeeEarnerRef NOT IN ('CZP', 'DAB', 'SCE', 'TRA')
GROUP BY M.FeeEarnerRef
ORDER BY MAX(D.Description)
	, MAX(U.FullName)
