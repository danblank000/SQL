--New matter prev month
SELECT COUNT(Entityref) AS 'Total_New_Matters'
	,COUNT(CASE Number
			WHEN '1'
				THEN 1
			ELSE NULL
			END) AS 'Matter_1s'
FROM Matters
WHERE Created >= DATEFROMPARTS(YEAR(DATEADD(mm, - 1, GETDATE())), MONTH(DATEADD(mm, - 1, GETDATE())), 01)
AND Created <= EOMONTH(dateadd(mm, - 1, GETDATE()))

-- compliance email number sent previous month
SELECT COUNT(*) AS 'Number_of_Compliance_Confirmation_Emails_Run'
FROM Cm_CaseItems AS I
INNER JOIN Cm_Steps AS S ON I.ItemID = S.ItemID
INNER JOIN Dm_Documents AS D ON S.DocumentRef = D.Code
WHERE I.CreationDate >= DATEFROMPARTS(YEAR(DATEADD(mm, - 1, GETDATE())), MONTH(DATEADD(mm, - 1, GETDATE())), 01)
	AND I.CreationDate <= EOMONTH(dateadd(mm, - 1, GETDATE()))
	AND D.NAME LIKE 'Number_of_Compliance_Confirmation_Emails_Run%'


--Combined
SELECT CAST(DATENAME(MONTH, DATEADD(mm, -1, GETDATE())) AS VARCHAR) + ' ' + CAST(YEAR(DATEADD (mm, -1, GETDATE())) AS VARCHAR) AS 'Date'
	, COUNT(Entityref) AS 'Total_New_Matters'
	, COUNT(CASE Number
			WHEN '1'
				THEN 1
			ELSE NULL
			END) AS 'Matter_1s'
	, (
		SELECT COUNT(*) AS 'Number_of_Compliance_Confirmation_Emails_Run'
	FROM Cm_CaseItems AS I
	INNER JOIN Cm_Steps AS S ON I.ItemID = S.ItemID
	INNER JOIN Dm_Documents AS D ON S.DocumentRef = D.Code
	WHERE I.CreationDate >= DATEFROMPARTS(YEAR(DATEADD(mm, - 1, GETDATE())), MONTH(DATEADD(mm, - 1, GETDATE())), 01)
		AND I.CreationDate <= EOMONTH(dateadd(mm, - 1, GETDATE()))
		AND D.NAME LIKE 'AML Identity Check Confirmation Email%'
	) AS 'Number_of_Compliance_Confirmation_Emails_Run'
FROM Matters
WHERE Created >= DATEFROMPARTS(YEAR(DATEADD(mm, - 1, GETDATE())), MONTH(DATEADD(mm, - 1, GETDATE())), 01)
AND Created <= EOMONTH(dateadd(mm, - 1, GETDATE()))