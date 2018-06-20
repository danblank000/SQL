SET LANGUAGE british;

select
dbo.ContractEntityCode(dbo.matters.EntityRef ) AS 'Entity Code'
,dbo.entities.Name AS 'Entity Name'
,dbo.EntityTypes.Description as 'Entity Type'
,dbo.matters.Number AS 'Matter Number'
,dbo.CaseTypes.Description AS 'Matter Type'
,dbo.Matters.Created AS 'Matter Created Date'
,dbo.Users.FullName AS 'Lead Fee Earner'
,dbo.HoursMins(dbo.TimeTransactions.quantityoftime) AS 'Time Recorded'
,dbo.TimeTransactions.ValueOfTime AS 'Value of Time'
,Users2.FullName as 'Time Recorded By'
,dbo.TimeTransactions.BillRef AS 'Bill Reference'
,dbo.TimeTransactions.DateStamp 'Recorded Date'

from dbo.Matters
JOIN dbo.Entities on dbo.matters.EntityRef = dbo.Entities.Code
JOIN dbo.EntityTypes on dbo.Entities.TypeRef = dbo.EntityTypes.Code
JOIN dbo.CaseTypes on dbo.matters.CaseTypeRef = dbo.CaseTypes.code
JOIN dbo.Users on dbo.matters.FeeEarnerRef = dbo.users.Code
JOIN dbo.TimeTransactions on dbo.matters.EntityRef = dbo.TimeTransactions.EntityRef and dbo.matters.Number = dbo.TimeTransactions.MatterNoRef
JOIN dbo.Users AS Users2 on dbo.TimeTransactions.FeeEarnerRef = Users2.Code
where 
((dbo.matters.created >= Convert(datetime, '01/04/2014')) AND (dbo.matters.created <= Convert(datetime, '30/04/2017')))
AND(dbo.casetypes.code = '37' OR dbo.casetypes.code = '45' OR dbo.casetypes.code = '78')

UNION

select
dbo.ContractEntityCode(dbo.mattersarchive.EntityRef ) AS 'Entity Code'
,dbo.entities.Name AS 'Entity Name'
,dbo.EntityTypes.Description as 'Entity Type'
,dbo.mattersarchive.Number AS 'Matter Number'
,dbo.MattersArchive.CaseType AS 'Matter Type'
,dbo.mattersarchive.Created AS 'Matter Created Date'
,dbo.Users.FullName AS 'Fee Earner'
,dbo.HoursMins(dbo.TimeTransactions.quantityoftime) AS 'Time Recorded'
,dbo.TimeTransactions.ValueOfTime AS 'Value of Time'
,Users2.FullName as 'Time Recorded By'
,dbo.TimeTransactions.BillRef AS 'Bill Reference'
,dbo.TimeTransactions.DateStamp AS 'Recorded Date'

from dbo.mattersarchive
JOIN dbo.Entities on dbo.mattersarchive.EntityRef = dbo.Entities.Code
JOIN dbo.EntityTypes on dbo.Entities.TypeRef = dbo.EntityTypes.Code
JOIN dbo.Users on dbo.mattersarchive.FeeEarnerRef = dbo.users.Code
JOIN dbo.TimeTransactions on dbo.MattersArchive.EntityRef = dbo.TimeTransactions.EntityRef and dbo.MattersArchive.Number = dbo.TimeTransactions.MatterNoRef
JOIN dbo.Users AS Users2 on dbo.TimeTransactions.FeeEarnerRef = Users2.Code

WHERE
((dbo.MattersArchive.created >= Convert(datetime, '01/04/2014')) AND (dbo.mattersarchive.created <= Convert(datetime, '30/04/2017')))
AND dbo.MattersArchive.CaseType like  '%Employment%'
Order by 'Matter Created Date'