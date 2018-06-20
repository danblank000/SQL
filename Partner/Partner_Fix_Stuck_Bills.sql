select * from Ac_Billbook
where EntityRef like 'aps%7'
where ReadytoApprove = 255

update Ac_Billbook
set ReadytoApprove = 1
where ReadytoApprove = 255
