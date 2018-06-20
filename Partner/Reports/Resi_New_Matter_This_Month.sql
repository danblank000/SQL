SELECT M.FeeEarnerRef AS 'Initials'
	,CASE 
		WHEN U.FullName IS NULL
			THEN '-'
		WHEN U.FullName IS NOT NULL
			THEN U.FullName
		END AS 'Full Name'
	,CASE 
		WHEN dbo.ContractEntityCode(M.Entityref) IS NULL
			THEN '-'
		WHEN dbo.ContractEntityCode(M.Entityref) IS NOT NULL
			THEN dbo.ContractEntityCode(M.Entityref)
		END AS 'Entity'
	,CASE 
		WHEN M.Number IS NULL
			THEN CAST('-' as VARCHAR)
		WHEN M.Number IS NOT NULL
			THEN CAST(M.Number AS VARCHAR)
		END AS 'Matter'
	,CASE
		WHEN M.Description IS NULL
			THEN '-'
		WHEN M.Description IS NOT NULL
			THEN M.Description
		END AS 'Matter Name'
	,CASE
		WHEN M.Created IS NULL
			THEN CAST('-' AS VARCHAR)
		WHEN M.Created IS NOT NULL
			THEN CAST(YEAR(M.Created) AS VARCHAR) + CAST('-' AS VARCHAR) +  CAST(MONTH(M.created)AS VARCHAR)  + CAST('-' AS VARCHAR) + CAST(DAY(M.Created) AS VARCHAR)
		END AS 'Date Opened'
	,CASE 
		WHEN M.WIPLimit = 0.00
			THEN CAST ('' AS VARCHAR)
		WHEN M.WIPLimit IS NOT NULL
			THEN M.WIPLimit
		END AS 'Estimated Value'
	,CASE 
		WHEN ISNUMERIC(ISNULL(dbo.ContractEntityCode(M.Entityref), CAST(COUNT(m.Description) OVER (PARTITION BY M.feeearnerref) AS VARCHAR))) = 0
			THEN ' '
		WHEN ISNUMERIC(ISNULL(dbo.ContractEntityCode(M.Entityref), CAST(COUNT(m.Description) OVER (PARTITION BY M.feeearnerref) AS VARCHAR))) = 1
			THEN ISNULL(dbo.ContractEntityCode(M.Entityref), CAST(COUNT(m.Description) OVER (PARTITION BY M.feeearnerref) AS VARCHAR))
		END AS 'Total'
FROM Matters AS M
JOIN Users AS U ON M.FeeEarnerRef = U.Code
WHERE Created >= DATEADD(dd, 1 , (EOMONTH(DATEADD(mm,-1, getdate()))))
	AND U.Department = 'DM'
GROUP BY GROUPING SETS (
	(M.FeeEarnerRef ,M.EntityRef ,M.Number ,M.Created ,M.Description ,U.FullName, M.WIPLimit), 
	(M.FeeEarnerRef)
						)
ORDER BY M.FeeEarnerRef
	, U.FullName DESC
	, M.Created
	, M.EntityRef
	, M.Number