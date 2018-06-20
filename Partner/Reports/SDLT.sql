select ID
	, dbo.ContractEntityCode(A.Client_Code) AS 'Entity'
	, E.Name
	, A.Matter_No
	, A.Batch_No
	, A.PostedDate
	, A.Narrative1
	, A.PayeePayer
	, A.Period
	, A.Year
	, Client_Credit 
from Ac_Client_Ledger_Transactions AS A
join Entities AS E on A.Client_Code = E.Code
where (A.Narrative1 like '%sdlt%' 
		OR A.Narrative1 like '%stamp duty%'
		)
	and A.PostedDate > '20150101'
order by A.Client_Code

