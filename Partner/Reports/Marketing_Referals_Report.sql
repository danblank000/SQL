WITH Ref_CTE (Entity, Matter, DateAdded, Level1ID, Department, Description, Level1Description, Level1Lookup, Level2ID, Level2Lookup)
AS

(
SELECT dbo.ContractEntityCode(rr.EntityRef)
	, rr.MatterNo
	, rr.DateAdded
	, rr.Level1ID
	, d.Description
	, rr.Description
	, rs.Description
	, dbo.ContractEntityCode(rr.Level1Lookup)
	, rr.Level2ID
	, dbo.ContractEntityCode(rr.Level2Lookup)
FROM ReferralRegister AS rr
JOIN ReferralsHierarchy AS rh ON rr.Level1ID = rh.ID
JOIN ReferralSources AS rs ON rh.RefSourceId = rs.ID
FULL JOIN Matters AS M ON rr.EntityRef = M.EntityRef 
	AND rr.MatterNo = M.Number
FULL JOIN Users AS U on M.FeeEarnerRef = U.Code
FULL JOIN Departments AS D ON U.Department = D.Code
WHERE rr.Level1ID = 262
AND rr.MatterNo = 1
) 

SELECT CTE.Entity
	, CTE.Matter
	, CTE.DateAdded AS 'Date Added'
	, CTE.Department
	, CTE.Description
	, CTE.Level1Description 'Level 1 Type'
	, CTE.Level1Lookup 'Level 1 Lookup'
	, rs2.Description
	, CTE.Level2Lookup 'Level 2 Lookup'
FROM Ref_CTE AS CTE
JOIN ReferralsHierarchy AS rh2 ON CTE.Level2ID = rh2.ID
JOIN ReferralSources AS rs2 ON rh2.RefSourceId = rs2.ID