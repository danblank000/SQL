use Partner

select * from TimeTransactions
where EntityRef like 'nic%141'
and MatterNoRef = 1
and Narratives like '%charity com%'