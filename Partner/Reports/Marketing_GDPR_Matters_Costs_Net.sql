USE Partner
Go

WITH GDPR (EntityRef, EntityName, Matter, Description, FeeEarnerRef, Created, ReferralType, ReferralSource)
AS (
	SELECT M.EntityRef
		, E.Name
		, M.Number
		, M.Description
		, M.FeeEarnerRef
		, M.Created
		, RS.Description
		, R.Level1Lookup
	FROM Matters AS M
	JOIN Entities AS E 
		ON M.EntityRef = E.Code
	JOIN ReferralRegister AS R 
		ON M.EntityRef = R.EntityRef 
		AND M.Number = R.MatterNo
	JOIN ReferralsHierarchy AS RH 
		ON R.Level1ID = RH.ID
	JOIN ReferralSources AS RS 
		ON RH.RefSourceId = RS.ID
	WHERE M.Description LIKE '%GDPR%'
	)

SELECT dbo.ContractEntityCode(G.EntityRef) AS 'Entity Ref'
	, G.EntityName
	, G.Matter
	, G.Description
	, U.FullName
	, 'Cost' = 
		CASE
			WHEN SUM(AC.CostsNet) IS NULL THEN 0
			ELSE SUM(AC.CostsNet)
		END
	, G.ReferralType
	, G.ReferralSource
FROM GDPR AS G
LEFT JOIN Ac_Billbook AS AC 
	ON G.EntityRef = AC.EntityRef
	AND G.Matter = AC.MatterRef
JOIN Users AS U 
	ON G.FeeEarnerRef = U.Code
GROUP BY G.EntityRef
	, G.Matter
	, G.EntityName
	, G.Description
	, U.FullName
	, G.ReferralType
	, G.ReferralSource