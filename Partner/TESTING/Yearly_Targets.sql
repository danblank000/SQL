select 
u.FullName
,dbo.hoursmins((sum(t.ChargeableTime))) as 'Year Target'
from Targets t
join users u
on t.feeearnerref = u.Code

where 
u.FullName not like 'Z%'and
t.year = CASE
	WHEN MONTH(GETDATE()) IN (1,2,3,4) 														
		THEN YEAR(GetDate()) - 1
	ELSE t.year			
		END
and u.Department = 'IP'
group by u.FullName


select 
u.FullName
,dbo.hoursmins((sum(a.chargeabletime))) as 'Current Chargeable Time'
from Analysis a
join users u
on a.feeearnerref = u.Code

where 
u.FullName not like 'Z%'and
a.year = CASE
	WHEN MONTH(GETDATE()) IN (1,2,3,4) 														
		THEN YEAR(GetDate()) - 1
	ELSE a.year			
		END
and u.Department = 'IP'
group by u.FullName