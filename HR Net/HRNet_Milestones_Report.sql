SELECT P.full_name
	, CONVERT(DATE,P.date_of_birth ) AS 'DOB'
	, CAST((DATEDIFF(HOUR, P.date_of_birth, GETDATE())/8766.0) AS INT) AS 'Current Age'
	, CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))/8766.0) AS INT) 'Age on Next Birthday'
	, CONVERT(date,E.date_start) AS 'Start Date'
	, CAST((DATEDIFF(HOUR, E.date_start, GETDATE())/8766.0) AS INT) AS 'Current Years of Service'
	, CAST((DATEDIFF(HOUR, E.date_start, DATEADD(yy, 1, GETDATE()))/8766.0) AS INT) 'Years of Service on Next Anniversary'
FROM pers_name AS P
JOIN pers_employment AS E ON P.person_id = E.person_id
WHERE 
	(
		(
		datefromparts(YEAR(GetDate()), month(p.date_of_birth), day(p.date_of_birth)) BETWEEN GETDATE() AND DATEADD(MM, 1, GETDATE())
		AND
			(
			CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '18'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '21'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '40'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '50'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '60'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '65'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '70'
			OR CAST((DATEDIFF(HOUR, P.date_of_birth, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '75'
			)
		)
	OR
		(
		datefromparts(YEAR(GetDate()), month(e.date_start), day(e.date_start)) BETWEEN GETDATE() AND DATEADD(MM, 1, GETDATE())
		AND
			(
			CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '20'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '25'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '30'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '35'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '40'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '45'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '50'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '55'
			OR CAST((DATEDIFF(YEAR, E.date_start, DATEADD(yy, 1, GETDATE()))) /8766.0 AS INT)  = '60'
			)
		)
	)
AND E.date_left IS NULL	