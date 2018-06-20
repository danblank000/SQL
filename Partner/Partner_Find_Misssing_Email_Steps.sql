select * from PPS_Email_Cache p
left join Cm_CaseItems c
on p.CaseItemRef = c.itemid 
inner join Cm_Agendas a
on c.ParentID = a.itemid 
where a.entityref like 'BJS%1' and MatterNo = 1
AND UserRef = 'azf'
order by creationdate desc

