WITH CTE (ID, FirstName, SurName, StartDate, Title, ROWNum)
AS (
	SELECT N.person_id
		, N.first_name
		, N.surname
		, E.date_start
		, J.job_title
		, ROW_NUMBER() OVER (PARTITION BY N.person_id ORDER BY N.Surname DESC)
	FROM Pers_Name AS N
	JOIN pers_employment AS E ON N.person_id = E.person_id
	JOIN pers_career AS C ON N.person_id = C.person_id
	JOIN perc_job_title AS J ON C.job_title_id = J.job_title_id
	WHERE E.date_left IS NULL
	GROUP BY N.person_id
		, N.surname
		, N.first_name
		, E.date_start
		, J.job_title
	)

SELECT FirstName
	, SurName
	, StartDate
	, Title
FROM CTE
WHERE ROWNum = 1