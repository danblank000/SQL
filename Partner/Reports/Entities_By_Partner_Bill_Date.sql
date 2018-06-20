WITH CTE (Entity, Matter, Date, Fee, ROWNum, Name, Partner, EnvelopeName, Address1, Address2, Address3, Address4, Postcode, Tel_Day, Tel_Eve, Tel_mob, Fax, Email, DateOfBirth, DateOfDeath )
AS(

SELECT dbo.ContractEntityCode(A.EntityRef)
	, A.MatterRef
	, CONVERT( DATE, MAX(A.BillDate)) AS 'BillDate'
	, U2.FullName
	, ROW_NUMBER() OVER (PARTITION BY A.EntityRef ORDER BY MAX(A.BillDate) DESC) AS 'COL'
	, E.Name
	, U.FullName AS 'Partner'
	, E.EnvelopeName
	, E.Address1
	, E.Address2
	, E.Address3
	, E.Address4
	, E.Postcode
	, E.Tel_Day
	, E.Tel_Eve
	, E.Tel_Mob
	, E.Fax
	, E.EMail
	, CONVERT( DATE, E.DateOfBirth)
	, CONVERT( DATE, E.DateOfDeath)
FROM Ac_Billbook AS A
JOIN Entities AS E on A.EntityRef = E.Code
JOIN Users AS U ON E.ResponsiblePartnerRef = U.Code
JOIN Users AS U2 ON A.SubmittingFeeEarner = U2.Code
GROUP BY A.EntityRef
	, A.MatterRef
	, U2.FullName
	, E.Name
	, U.FullName
	, E.EnvelopeName
	, E.Address1
	, E.Address2
	, E.Address3
	, E.Address4
	, E.Postcode
	, E.Tel_Day
	, E.Tel_Eve
	, E.Tel_Mob
	, E.Fax
	, E.EMail
	, E.DateOfBirth
	, E.DateOfDeath
)
SELECT Entity
	, Matter
	, Partner AS 'Responsible Partner'
	, Date AS 'Last Bill Date'
	, Fee AS 'Submitting Fee-Earner'
	, Name
	, EnvelopeName
	, Address1
	, Address2
	, Address3
	, Address4
	, Postcode
	, Tel_Day
	, Tel_Eve
	, Tel_mob
	, Fax
	, Email
	, DateOfBirth
	, DateOfDeath
FROM CTE
WHERE ROWNum = 1