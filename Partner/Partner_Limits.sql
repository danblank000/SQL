WITH Limits (Entity, Matter, CostsLimit, DisbursmentsLimit, TotalTimeLimit, WIPLimit, CreditLimit, EstimatedValue)
AS(
	SELECT dbo.ContractEntityCode(M.EntityRef)
		, CAST(M.Number AS VARCHAR)
		, M.CostsLimit
		, M.DisbursementsLimit
		, M.TotalTimeLimit
		, M.WIPLimit
		, M.CreditLimit
		, RR.EstimatedValue
	FROM Matters AS M
	JOIN ReferralRegister AS RR ON M.EntityRef = RR.EntityRef
		AND M.Number = RR.MatterNo
	)

SELECT *
FROM Limits
WHERE EstimatedValue <> CreditLimit

UNION ALL

SELECT 'ZV--------'
	, 'TOTALS :'
	, SUM(CASE
		WHEN
			CostsLimit > 0 THEN 1
			ELSE 0
		END)
	, SUM(CASE
		WHEN
			DisbursmentsLimit> 0 THEN 1
			ELSE 0
		END)
	, SUM(CASE
		WHEN
			TotalTimeLimit > 0 THEN 1
			ELSE 0
		END)
	, SUM(CASE
		WHEN
			WIPLimit> 0 THEN 1
			ELSE 0
		END)
	, SUM(CASE
		WHEN
			CreditLimit > 0 THEN 1
			ELSE 0
		END)
	, SUM(CASE
		WHEN
			EstimatedValue > 0 THEN 1
			ELSE 0
		END)
FROM Limits
ORDER BY Entity, Matter
