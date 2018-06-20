SELECT e.shortcode AS 'Entity'
	, CAST(e.Created AS DATE)AS 'Enity Created'
	, m.number AS 'Matter'
	, CAST(m.Created AS DATE)AS 'Matter Created'
	, DATEDIFF (DAY, CAST(m.Created as DATE), CAST(e.Created as DATE)) AS 'Difference In Days'
FROM entities e
JOIN matters m ON e.code = m.EntityRef
Where e.Created > m.Created
ORDER BY Entity ASC, [Difference In Days] DESC