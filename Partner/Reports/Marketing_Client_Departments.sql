DECLARE @Number INT = 200;-- HOW MANY CLIENTS TO DISPLAY

WITH PivotData
AS (
	SELECT E.Name AS 'Entity'
		,D.Description AS 'Dept'
		,COUNT(D.Description) AS 'DCount'
	FROM DAB_MattersALL AS M
	JOIN Users AS U ON M.FeeEarnerRef = U.Code
	JOIN Departments AS D ON U.Department = D.Code
	JOIN Entities AS E ON M.Entityref = E.Code
	WHERE M.EntityRef IN (
			SELECT TOP (@Number) E.Code AS 'Entity'
			FROM Departments AS D
			INNER JOIN Users AS U ON D.Code = U.Department
			INNER JOIN Ac_Billbook AS A ON U.Code = A.SubmittingFeeEarner
			INNER JOIN Entities AS E ON A.EntityRef = E.Code
			WHERE A.BillDate >= '2008-01-01 00:00:00'
				AND A.BillDate < GETDATE()
			GROUP BY E.Code
				,E.Name
			ORDER BY CAST(SUM(A.CostsNet) AS MONEY) DESC
			)
	GROUP BY E.Name
		,D.Description
	)
SELECT Entity
	,Banking
	,[Commercial and IP]
	,[Commercial Property]
	,Construction
	,Corporate
	,Employment
	,Family
	,[Intellectual Property]
	,Licensing
	,Litigation
	,Management
	,[Real Estate]
	,[Residential Property]
	,[Tax and Probate]
FROM PivotData
PIVOT(MAX(DCOUNT) FOR Dept IN (
			[Banking]
			,[Commercial and IP]
			,[Commercial Property]
			,[Construction]
			,[Corporate]
			,[Employment]
			,[Family]
			,[Intellectual Property]
			,[Licensing]
			,[Litigation]
			,[Management]
			,[Real Estate]
			,[Residential Property]
			,[Tax and Probate]
			)) AS P
ORDER BY Entity
