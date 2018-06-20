SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, M.Number
	, M.CaseTypeRef
	, M.FeeType
	, M.WIPLimit
FROM Matters AS M
WHERE M.WIPLimit <= '0'
ORDER BY M.EntityRef



SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, M.Number
	, M.CaseTypeRef
	, M.FeeType
	, M.WIPLimit
FROM Matters AS M
WHERE M.WIPLimit > '0'
--AND M.FeeType = 3
ORDER BY M.EntityRef



SELECT 
	'Fee Type' = 
		CASE 
			WHEN M.FeeType = 0 THEN 'Chargeable Time'
			WHEN M.FeeType = 1 THEN 'Conditional Fee'
			WHEN M.FeeType = 2 THEN 'Gross Basic Fee'
			WHEN M.FeeType = 3 THEN 'Quoted Net'
			WHEN M.FeeType = 4 THEN 'Fixed Fee'
			ELSE 'Other (Unknown)'
		END
	, Count(*) AS 'Count'
FROM Matters AS M
WHERE M.WIPLimit > '0'
GROUP BY FeeType
ORDER BY Count(*) DESC



--0 - Chargeable time
--1 - Conditional fee
--2 - Gross basic fee
--3 - Quoted net 
--4 - Fixed Fee 

select * from matters