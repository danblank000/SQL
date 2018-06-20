select u.FullName as Name, u.StandardChargeRate as 'Chargeout Rate', D.Description as Department

from Users as U
inner join Departments as D 
on u.department = d.code

where u.FeeEarner = '1'
and u.FullName not like 'Z%'
and u.FullName not like 'train%'
and u.EMailExternal != ''
and u.Code NOT IN  ('SCE', 'DAB', 'CZP')
and u.StandardChargeRate != '0.00'

order by FullName