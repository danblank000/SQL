DECLARE @Number INT = 200;-- HOW MANY CLIENTS TO DISPLAY

WITH PivotData
AS (

SELECT E.Name AS 'Entity'
	, D.Description AS 'Department'
	, SUM(A.CostsNet) AS 'Value'
FROM DAB_MattersAll AS DAB
JOIN Users AS U ON DAB.FeeEarnerRef = U.Code
JOIN Departments AS D ON U.Department = D.Code
JOIN Ac_Billbook AS A ON DAB.Entityref = A.EntityRef
	AND DAB.Number = A.MatterRef
JOIN Entities AS E on DAB.Entityref = E.Code
WHERE A.BillDate > '2016-01-01 00:00:00'
	AND DAB.Entityref IN(
	SELECT TOP (200) E.Code AS 'Entity'
			FROM Departments AS D
			INNER JOIN Users AS U ON D.Code = U.Department
			INNER JOIN Ac_Billbook AS A ON U.Code = A.SubmittingFeeEarner
			INNER JOIN Entities AS E ON A.EntityRef = E.Code
			WHERE A.BillDate >= '2016-01-01 00:00:00'
				AND A.BillDate < GETDATE()
			GROUP BY E.Code
				,E.Name
			ORDER BY CAST(SUM(A.CostsNet) AS MONEY) DESC
	)
GROUP BY E.Name
	, D.Description

)
SELECT Entity
	,Banking
	,[Commercial and IP]
	,[Commercial Property]
	,Corporate
	,Employment
	,Family
	,[Intellectual Property]
	,Licensing
	,Litigation
	,Management
	,[Residential Property]
	,[Tax and Probate]
FROM PivotData
PIVOT(MAX(VALUE) FOR Department IN (
			[Banking]
			,[Commercial and IP]
			,[Commercial Property]
			,[Corporate]
			,[Employment]
			,[Family]
			,[Intellectual Property]
			,[Licensing]
			,[Litigation]
			,[Management]
			,[Residential Property]
			,[Tax and Probate]
			)) AS P
ORDER BY Entity
