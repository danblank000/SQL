update Ac_Billbook
set ReadytoApprove = 1
where ReadytoApprove = 255


select * from Ac_Billbook where ReadytoApprove = 255


select ReadytoApprove,* from Ac_Billbook
--where ReadytoApprove <> 1
--where EntityRef like 'SVE%3'
order by BillDate
AND MatterRef = 70

where ReadytoApprove = 255




--Locked Trime TRansactions
DELETE from TimeTransactionLocks
where EntityRef like 'mor%56'

select * from TimeTransactions