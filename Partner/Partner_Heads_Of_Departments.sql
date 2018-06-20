:connect kslsrv18
use [partner]

select 
d.Description as Department, 
u.FullName as 'Head of Department' 

from Usr_Heads_of_Departments h
left join Users u
on h.Staff_Member=u.Code
left join Departments d
on h.department=d.Code

order by Department
