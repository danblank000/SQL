WITH LASTBILLED AS 
(
	SELECT MAX(dbo.ContractEntityCode(A.Entityref)) AS 'Entity'
		, MAX(E.Name) AS 'Name'
		, MAX(A.Actual_Posting_Date) AS 'Billed'
		, MAX(E.ResponsiblePartnerRef) AS 'Lead Partner on Entity'
	FROM  Ac_Billbook AS A 
	JOIN Entities AS E on A .EntityRef = E.Code
	WHERE A.Actual_Posting_Date < DATEADD(yy, - 1, GETDATE())
	AND A.Actual_Posting_Date > DATEADD(yy, - 2, GETDATE())
	AND Type = 'Posted'
	AND E.ResponsiblePartnerRef not in ('DMM', 'KM', 'AJH')
	GROUP BY dbo.ContractEntityCode(A.Entityref)
)

SELECT dbo.ContractEntityCode(M.entityref) AS 'Entity'
	, MAX(E.NAME) AS 'Name'
	, MAX(M.Number) AS 'Last_Matter_Number'
	, CAST(Max(M.Created) AS DATE) AS 'Last_Matter_Creation_Date'
	, MAX(u.FullName) AS 'Partner'
	, MAX(U.EMailExternal) AS 'Partner_Email'
	, MAX(L.billed) AS 'Billed in Last Year'
FROM Matters AS M
INNER JOIN Entities AS E ON M.EntityRef = E.Code
INNER JOIN Users AS U ON E.ResponsiblePartnerRef = U.Code
INNER JOIN LASTBILLED AS L on dbo.ContractEntityCode(M.entityref) = L.Entity
WHERE M.number > 4
GROUP BY EntityRef
HAVING MAX(M.Created) < DATEADD(mm, - 3, GETDATE())
	AND MAX(M.Created) > DATEADD(yy, - 1, GETDATE())
	AND MAX(E.Name) NOT LIKE 'Non%Chargeable%'

	ORDER BY Partner, Entity
	
UNION

SELECT dbo.ContractEntityCode(A.entityref) AS 'Entity'
	, MAX(E.NAME) AS 'Name'
	, MAX(A.Number) AS 'Last_Matter_Number'
	, CAST(Max(A.Created) AS DATE) AS 'Last_Matter_Creation_Date'
	, MAX(u.FullName) AS 'Partner'
	, MAX(U.EMailExternal) AS 'Partner_Email'
	, MAX(L.billed) AS 'Billed in Last Year'
FROM MattersArchive AS A
INNER JOIN Entities AS E ON A.EntityRef = E.Code
INNER JOIN Users AS U ON E.ResponsiblePartnerRef = U.Code
INNER JOIN LASTBILLED AS L on dbo.ContractEntityCode(A.entityref) = L.Entity
WHERE A.number > 3
GROUP BY EntityRef
HAVING MAX(A.Created) < DATEADD(mm, - 3, GETDATE())
	AND MAX(A.Created) > DATEADD(yy, - 1, GETDATE())
	AND MAX(E.Name) NOT LIKE 'Non%Chargeable%'
ORDER BY Partner, Entity