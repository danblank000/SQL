select distinct
e.shortcode as Client,
e.name as 'Client Name', 
r.description as 'Opening Risk Profile',
p.proof_Status as 'Money Laundering Proof Status',
e.clientAcBalances as 'Client Balance',
e.officeACBalances as 'Office Balance',
e.unbilledtimebalancevalue as WIP

from matters m
left join dbo.view_ML_proofs p
on m.entityref = p.code
left join entities e
on m.entityref = e.code
left join matters_riskprofiles r
on m.riskopening = r.id

where 
(p.proof_status != 'proven' and m.riskopening = '2')
or (p.proof_status != 'proven' and m.riskopening = '3')

order by client