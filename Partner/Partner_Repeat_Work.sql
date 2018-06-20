WITH DATA AS (
	SELECT e.ShortCode AS 'Entity'
		, COUNT(e.shortcode) AS 'Matter_Count'
	FROM Matters m
	JOIN Entities e ON m.EntityRef = e.Code
	WHERE e.Created >= '20160501'
	AND m.Created >= '20160501'
	GROUP BY e.ShortCode

	UNION ALL

	SELECT e.ShortCode  AS 'Entity'
		, COUNT(e.shortcode)  AS 'Matter_Count'
	FROM MattersArchive a
	JOIN Entities e ON a.EntityRef = e.Code
	WHERE e.Created >= '20160501'
	AND a.Created >= '20160501'
	GROUP BY e.ShortCode
	)


SELECT Entity
	, CASE SUM(Matter_Count) 
	WHEN 3 THEN '3' 
	WHEN 4 THEN '4' 
	ELSE '5+' 
	END AS 'Number_of_Matters'
FROM DATA 
GROUP BY Entity 
HAVING SUM(Matter_Count) >= 3
ORDER BY Number_of_Matters, Entity;
