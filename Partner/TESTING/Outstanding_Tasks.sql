select * 
from Diary_Appointments 
where EntityRef like 'BIR%199' 
and MatterNoRef ='1' 
and DeleteThis = 0

select * 
from Diary_Tasks 
where EntityRef like 'BIR%199' 
and MatterNoRef ='1' 
and DeleteThis = 0

update Diary_Tasks
set DeleteThis = 1 
where EntityRef like 'BIR%199' 
and MatterNoRef ='1' 
and DeleteThis = 0




select * from KSL_ArchivedMatters
order by Archived

select * from User_Def_Reports

select * from Ac_Bank_Rec
where Transaction_No like '520%'
order by Transaction_No

where Client_Code like 'dav%02'
order by ChequeDate
order by ref

select * from Ac_Bank_Codes

select *from Ac_Client_Ledger_Transactions
where ref = '520961'

update ac_client_ledger_transactions
set safedate = posteddate, cleareddate= posteddate
where transaction_no = 259532

select * from Usr_Client_Questionnaire
where EntityRef like 'MOR%260'