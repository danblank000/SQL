SELECT 
u1.FullName as Name, 
d.Description as Department,
u1.Jobtitle as Job,
u2.FullName as manager

from users u1 
LEFT JOIN users u2 
on u1.Manager=u2.Code 
LEFT JOIN Departments d
on u1.Department=d.Code


where u1.FullName not like 'z%' 
order by Department, manager