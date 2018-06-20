USE partner
GO

SELECT dbo.ContractEntityCode(Code) AS 'Entity'
	, Name
	, Created
	, ResponsiblePartnerRef AS 'Lead Partner'
FROM Entities
WHERE Code IN (
		SELECT EntityRef
		FROM TimeTransactions
		WHERE TransactionDate > DATEADD(yy, -3, GETDATE())
			AND FeeEarnerRef IN(SELECT code
			FROM Users
			WHERE Department = 'CM')) 
	AND ResponsiblePartnerRef IN (
		SELECT code
			FROM Users
			WHERE Department = 'CM')
ORDER BY Code