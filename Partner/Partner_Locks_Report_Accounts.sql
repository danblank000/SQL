select 
m.FeeEarnerRef as 'Fee Earner',
u.Fullname as 'Fee Earner Name',
e.ShortCode as Entity,
m.Number as Matter,
e.Name as 'Client Name',
l.Description as 'Lock Name',
m.UnbilledTimeBalanceValue 'Unbilled Time Balance Value',
m.Office_Ac_Balance as 'Office Account Balance',
m.Client_Ac_Balance as 'Client Account Balance'
 
from Matters as M
left join Locks as L
on l.Code = m.LockID
left join Entities as E
on e.Code = m.EntityRef
left join Users as U
on u.code = m.FeeEarnerRef

where l.description is not null
order by 'Fee Earner'