WITH TRANS (Entity, Matter, TDate)
AS(
	 SELECT EntityRef
		, MatterNoRef
		, MAX(TransactionDate)
	 FROM TimeTransactions WHERE
	 EntityRef IN (
		SELECT M.EntityRef
		FROM Matters AS M
		WHERE M.LockID <> 0
			AND M.EntityRef NOT LIKE '%NON%'
			)
	GROUP BY EntityRef
		, MatterNoRef
)

SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
 , E.Name
 , M.Number
 , M.Description
 , M.Created
 , T.TDate AS 'Last Time Rec Date'
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN TRANS AS T ON M.EntityRef = T.Entity 
	AND M.Number = T.Matter
WHERE M.LockID <> 0
	AND M.EntityRef NOT LIKE '%NON%'
ORDER BY M.EntityRef
	, M.Number