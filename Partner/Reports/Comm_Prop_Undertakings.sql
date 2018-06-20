-- Comm Prop Undertaking outstanding on live matters

USE Partner

SELECT dbo.ContractEntityCode(UR.EntityRef) AS 'Entity'
	, UR.MatterNo AS 'Matter'
	, U.FullName AS 'Originating User'
	, U2.FullName AS 'Responsible Fee-Earner'
	, UR.ID AS 'ID'
	, UR.UndertakingDescription AS 'Undertaking Description'
	, UR.UndertakingMadeDate AS 'Date'
FROM UndertakingsRegister AS UR
	JOIN Users AS U 
		ON UR.OriginatingUser = U.Code
	JOIN Users AS U2 
		ON UR.ResponsibleFERef = U2.Code
--WHERE U.Department = 'CM'
WHERE ResponsibleFERef = 'egn'
	AND UR.Status = 1
	AND 
		NOT EXISTS(
			SELECT * 
			FROM MattersArchive AS MA 
			WHERE UR.EntityRef = MA.EntityRef
				AND UR.MatterNo = MA.Number)
ORDER BY UR.EntityRef