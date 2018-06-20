SELECT TOP (100) PERCENT dbo.ContractEntityCode(dbo.ReferralRegister.EntityRef) AS EntityRef
	,dbo.ReferralRegister.MatterNo
	,dbo.ReferralRegister.Description
	,dbo.ReferralSources.Description AS DescLevel1
	,dbo.ContractEntityCode(dbo.ReferralRegister.Level1Lookup) AS Level1Lookup
	,Entities_3.NAME AS Level1Name
	,ReferralSources_2.Description AS DescLevel2
	,dbo.ReferralRegister.Level2Lookup
	,Entities_1.NAME AS Level2Name
	,ReferralSources_1.Description AS DescLevel3
	,dbo.ReferralRegister.Level3Lookup
	,Entities_2.NAME AS Level3Name
	,dbo.ReferralRegister.DateAdded
	,Users_1.EMailExternal
	,dbo.Users.EMailExternal AS Expr1
FROM dbo.Entities AS Entities_2
RIGHT JOIN dbo.Entities
LEFT JOIN dbo.Users ON dbo.Entities.ResponsiblePartnerRef = dbo.Users.Code
RIGHT JOIN dbo.ReferralRegister ON dbo.Entities.Code = dbo.ReferralRegister.EntityRef ON Entities_2.Code = dbo.ReferralRegister.Level3Lookup LEFT JOIN dbo.Entities AS Entities_1 ON dbo.ReferralRegister.Level2Lookup = Entities_1.Code LEFT JOIN dbo.Entities AS Entities_3 ON dbo.ReferralRegister.Level1Lookup = Entities_3.Code LEFT JOIN dbo.ReferralSources
INNER JOIN dbo.ReferralsHierarchy ON dbo.ReferralSources.ID = dbo.ReferralsHierarchy.RefSourceId ON dbo.ReferralRegister.Level1ID = dbo.ReferralsHierarchy.ID LEFT JOIN dbo.ReferralSources AS ReferralSources_1
INNER JOIN dbo.ReferralsHierarchy AS ReferralsHierarchy_1 ON ReferralSources_1.ID = ReferralsHierarchy_1.RefSourceId ON dbo.ReferralRegister.Level3ID = ReferralsHierarchy_1.ID LEFT JOIN dbo.ReferralsHierarchy AS ReferralsHierarchy_2
INNER JOIN dbo.ReferralSources AS ReferralSources_2 ON ReferralsHierarchy_2.RefSourceId = ReferralSources_2.ID ON dbo.ReferralRegister.Level2ID = ReferralsHierarchy_2.ID LEFT JOIN dbo.Users AS Users_1
RIGHT JOIN dbo.AllMatters ON Users_1.Code = dbo.AllMatters.FeeEarnerRef ON dbo.ReferralRegister.MatterNo = dbo.AllMatters.Number AND dbo.ReferralRegister.EntityRef = dbo.AllMatters.EntityRef 
WHERE (dbo.ReferralRegister.DateAdded > DATEADD(d, - 7, GETDATE()))
AND dbo.ReferralRegister.MatterNo = 0
ORDER BY Users.EMailExternal
	,DescLevel1
	,Level1Lookup
	,DescLevel2
	,dbo.ReferralRegister.Level2Lookup
	,DescLevel3
	,dbo.ReferralRegister.Level3Lookup
	,EntityRef
	,dbo.ReferralRegister.MatterNo
