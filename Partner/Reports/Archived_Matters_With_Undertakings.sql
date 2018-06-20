-- All archive matters with live undertakings

SELECT dbo.ContractEntityCode(UR.EntityRef) AS 'Entity'
	, UR.MatterNo AS 'Matter'
	, U.FullName AS 'Name'
	, UR.UndertakingDescription AS 'Undertaking Description'
FROM UndertakingsRegister AS UR
JOIN Users AS U ON UR.OriginatingUser = U.Code
WHERE 
	NOT EXISTS(
	SELECT * 
	FROM MattersArchive AS MA 
	WHERE UR.EntityRef = MA.EntityRef
	AND UR.MatterNo = MA.Number)

ORDER BY FullName, UR.EntityRef