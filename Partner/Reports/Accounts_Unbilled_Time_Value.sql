USE Partner
GO

CREATE PROCEDURE dbo.UnbilledTimeTransactionsValue
AS


		WITH CTE (EntityRef, Name, Matter, Description, UnbilledTime)
		AS (
			SELECT dbo.ContractEntityCode(M.EntityRef)
				, E.Name
				, M.Number
				, M.Description
				, M.UnbilledTimeBalanceValue
			FROM Matters AS M
			JOIN Entities AS E ON M.EntityRef = E.Code
			WHERE M.UnbilledTimeBalanceValue <> 0
		)

		SELECT EntityRef
			, Name
			, Matter
			, Description
			, UnbilledTime
		FROM CTE

		UNION ALL

		SELECT '__Total'
			, ''
			, ''
			, ''
			, SUM(UnbilledTimE)
		FROM CTE
		ORDER BY EntityRef
			, Matter
			, UnbilledTime

GO

