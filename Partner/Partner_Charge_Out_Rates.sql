SELECT u.fullname as 'Fee-Earner'
	, u.StandardChargeRate as 'Charge Out Rate'
	, d.Description as Department
FROM users AS u 
JOIN departments AS d ON u.department = d.code
WHERE u.StandardChargeRate > 0 
AND u.FullName NOT LIKE 'z%'
ORDER BY fullname
	, description