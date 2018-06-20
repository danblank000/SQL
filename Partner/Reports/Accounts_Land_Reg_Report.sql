select * from Ac_Client_Ledger_Transactions
where Posting_Type = 'dso'
and Narrative1 like '%land reg%'
and Client_Code like 'SLG%1'
and Matter_No = 5
order by PostedDate


select * from Ac_Billbook
where EntityRef like 'SLG%1'
and MatterRef = 5




select * from Ac_Disbursements
WHERE ClientCode like 'SLG%1'
and MatterNo = 5






select B.BillDate
	, B.OutstandingTotal
	, B.Ref
	, D.Narrative1
FROM Ac_Billbook AS B 
RIGHT JOIN Ac_Disbursements AS D on B.BillBookNo = D.BillBookNo
WHERE D.Narrative1 like '%land reg%'
AND D.Narrative1 not like '%reverse%'
AND D.Narrative1 not like '%cancel%'
AND D.Type = 'Billed'
AND BillDate > '20180101'




SELECT B.Ref
	, B.BillDate
	, CLT.Disbursements
	,CLT.Narrative1
	, b.*
	, clt.*
FROM Ac_Client_Ledger_Transactions AS CLT
JOIN Ac_Billbook AS B ON CLT.Batch_No = B.BatchNo
WHERE CLT.Posting_Type = 'dso'
AND CLT.Narrative1 like '%land reg%'
order by B.BillDate