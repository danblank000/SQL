USE Partner
GO 

WITH EstimatedValue (EstimatedValue, EntityRef, MatterNo, DateAdded, RowNum)
AS	(
	SELECT EstimatedValue
		, EntityRef
		, MatterNo
		, DateAdded
		, ROW_NUMBER() OVER (PARTITION BY EntityRef, MatterNo ORDER BY DATEADDED DESC)
	FROM ReferralRegister
	WHERE MatterNo <> 0
	)

SELECT D.Description AS 'Department' 
	, 'HoD' =
		CASE
			WHEN D.Description = 'Banking' THEN 'George MacMillan'
			WHEN D.Description = 'Commercial and IP' THEN 'Robert Buckley'
			WHEN D.Description = 'Commercial Property' THEN 'Nick Nyunt'
			WHEN D.Description = 'Corporate' THEN 'Robert Buckley'
			WHEN D.Description = 'Employment' THEN 'Kevin McKenna'
			WHEN D.Description = 'Family' THEN 'Graham Wood'
			WHEN D.Description = 'Intellectual Property' THEN 'Ian Morris'
			WHEN D.Description = 'Licensing' THEN 'Anthony Lyons'
			WHEN D.Description = 'Litigation' THEN 'Andrew Weinberg'
			WHEN D.Description = 'Residential Property' THEN 'Anthony Hardy'
			WHEN D.Description = 'Tax and Probate' THEN 'Graham Wood'
			WHEN U.FullName = 'Robert Levy' THEN 'Robert Levy'
			WHEN U.FullName = 'Steve Eccleston' THEN 'Steve Eccleston'
			ELSE 'HoD Not Defined'
		END
	, dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
	, E.Name AS 'Entity Name'
	, M.Number AS 'Matter'
	, M.Description AS 'Matter Description'
	, M.Created AS 'Matter Creation Date'
	, U2.FullName AS 'Fee-Earner'
	, U.FullName AS 'Lead Partner'
	, M.WIPLimit AS 'WIP Limit'
	--, M.CreditLimit AS 'Credit Limit'
	, EV.EstimatedValue AS 'Estimated Value'
	, 'HoD Email' =
		CASE
			WHEN D.Description = 'Banking' THEN 'GeorgeMacMillan@Kuits.com'
			WHEN D.Description = 'Commercial and IP' THEN 'RobertBuckley@Kuits.com'
			WHEN D.Description = 'Commercial Property' THEN 'NickNyunt@Kuits.com'
			WHEN D.Description = 'Corporate' THEN 'RobertBuckley@Kuits.com'
			WHEN D.Description = 'Employment' THEN 'KevinMcKenna@Kuits.com'
			WHEN D.Description = 'Family' THEN 'GrahamWood@Kuits.com'
			WHEN D.Description = 'Intellectual Property' THEN 'IanMorris@Kuits.com'
			WHEN D.Description = 'Licensing' THEN 'AnthonyLyons@Kuits.com'
			WHEN D.Description = 'Litigation' THEN 'AndrewWeinberg@Kuits.com'
			WHEN D.Description = 'Residential Property' THEN 'AnthonyHardy@Kuits.com'
			WHEN D.Description = 'Tax and Probate' THEN 'GrahamWood@Kuits.com'
			WHEN U.FullName = 'Robert Levy' THEN 'RobertLevy@Kuits.com'
			WHEN U.FullName = 'Steve Eccleston' THEN 'SteveEccleston@Kuits.com'
			ELSE 'Manager Not Defined'
		END
	, U.EMailExternal AS 'Partner Email'
	, U2.EMailExternal AS 'Fee-Earner Email'
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS U ON M.PartnerRef = U.Code
JOIN Users AS U2 ON M.FeeEarnerRef = U2.Code
JOIN Departments AS D ON U.Department = D.Code
JOIN EstimatedValue AS EV ON M.EntityRef = EV.EntityRef
	AND M.Number = EV.MatterNo
WHERE (M.WIPLimit = 0
	--OR M.CreditLimit = 0
	OR EV.EstimatedValue = 0)
	AND M.Created > DATEADD(mm, -1, GETDATE())
	AND M.EntityRef NOT LIKE 'NON%'
ORDER BY Department
	, [Lead Partner]
	, Entity
	, Matter
	, [Fee-Earner]
	, [Matter Creation Date]