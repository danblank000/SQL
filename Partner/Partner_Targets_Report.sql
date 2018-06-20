select 
MAX(users.fullname) as 'Name'
,MAX(targets.FeesBilled) as 'Billing Target'
,sum(analysis.CostsDelivered) as 'Actual Billed'
,sum(analysis.CostsReceived) as 'Actual Received'
from Analysis
join targets
on analysis.feeearnerref = targets.feeearnerref 
and Analysis.Period = Targets.period 
and analysis.year =targets.year
join users
on analysis.feeearnerref = users.Code
where analysis.FeeEarnerRef = 'yk' 
and analysis.Period = '9' 
and analysis.year = '2016'
group by Analysis.FeeEarnerRef



select 
analysis.FeeEarnerRef
,MAX(users.fullname) as 'Name'
,MAX(targets.FeesBilled) as 'Billing Target'
,sum(analysis.CostsDelivered) as 'Actual Billed'
,sum(analysis.CostsReceived) as 'Actual Received'
from Analysis
join targets
on analysis.feeearnerref = targets.feeearnerref 
and Analysis.Period = Targets.period 
and analysis.year =targets.year
join users
on analysis.feeearnerref = users.Code
where 
analysis.Period = '9' 
and analysis.year = '2016' 
and users.UsertypeRef != '10'
group by Analysis.FeeEarnerRef
order by FeeEarnerRef