SELECT E.Name
	, dbo.ContractEntityCode(E.Code) AS 'Entity'
	, CAST (SUM(A.CostsNet) AS Money)
FROM Departments AS D 
INNER JOIN Users AS U ON D.Code = U.Department
INNER JOIN Ac_Billbook AS A ON U.Code = A.SubmittingFeeEarner
INNER JOIN Entities AS E ON A.EntityRef = E.Code
WHERE A.BillDate >= '2008-01-01 00:00:00'
	AND A.BillDate < GETDATE()
GROUP BY E.Code
	, E.Name
ORDER BY SUM(A.CostsNet) DESC