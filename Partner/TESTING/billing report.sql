select 
users.fullname as [Name]
, dbo.HoursMins(max(targets.chargeabletime)) as [Target Chargeable Time]
, dbo.HoursMins(sum(analysis.chargeabletime)) as [Current Chargeable Time] 
, dbo.HoursMins(max(targets.chargeabletime) - sum(analysis.chargeabletime)) as [Shortfall if negative then over target]

from 
Analysis
join targets
on analysis.feeearnerref = targets.feeearnerref 
and Analysis.Period = Targets.period 
and analysis.year =targets.year
join users
on analysis.feeearnerref = users.Code

where 
users.Department = 'IP'
and users.FullName not like 'Z%'
and analysis.Period = CASE
		WHEN MONTH(GETDATE()) = 1
	THEN 9
		WHEN MONTH(GETDATE())= 2
	THEN 10
		WHEN MONTH(GETDATE()) = 3
	THEN 11
		WHEN MONTH(GETDATE())= 4								
	THEN 12
		WHEN MONTH(GETDATE())= 5								
	THEN 1
		WHEN MONTH(GETDATE())= 6								
	THEN 2
		WHEN MONTH(GETDATE())= 7								
	THEN 3
		WHEN MONTH(GETDATE())= 8								
	THEN 4
		WHEN MONTH(GETDATE())= 9								
	THEN 5
		WHEN MONTH(GETDATE())= 10								
	THEN 6
		WHEN MONTH(GETDATE())= 11								
	THEN 7
		WHEN MONTH(GETDATE())= 12								
	THEN 8
	END
and analysis.year = CASE
		WHEN MONTH(GETDATE()) IN (1,2,3,4) 														
	THEN YEAR(GetDate()) - 1
	ELSE analysis.year			
	END

GROUP BY users.fullname