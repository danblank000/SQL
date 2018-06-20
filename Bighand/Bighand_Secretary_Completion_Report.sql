select 
t.bh_AuthorName as Author,
b.LockedBy as Secretary,
t.bh_completiondate as 'Completed Date',
t.BH_Title as Title,
b.AuthorDepartment as Department,
b.state as State 

from BHV_HISTORIC_REPORT_TIMELINE as B
left join BH_Tasks as T
on  B.bh_taskguid = T.bh_taskguid

where b.lockedby like '%carolyn%'
and t.BH_CompletionDate >= '2017-05-01 00:00:00.000'

order by t.bh_completiondate

