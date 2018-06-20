select 
Entities.shortcode as Client,
Entities.name as 'Client Name',
Entities.salutation as Salutation,
Entities.Title as Title,
Entities.ContactName as Contact,
Entities.Forename + ' ' + Entities.Surname as 'Other Name on File',
Entities.EnvelopeName as 'Address Name',
Entities.Address1 + ' - ' + Entities.Address2 + ' - ' + Entities.Address3 + ' - ' + Entities.Address4 + ' - ' + Entities.postcode as 'Address',
Entities.corraddress1 + ' - ' + Entities.corraddress2 + ' - ' + Entities.corraddress3 + ' - ' + Entities.corraddress4 + ' - ' + Entities.CorrPostcode as 'Correspondence Address',
Entities.Tel_Day as 'Day Time Tel',
Entities.Tel_Eve as 'Evening Tel',
Entities.Tel_Mob as 'Mobile Tel',
Entities.EMail as Email,
Entities.WebSite as Website,
Entities.JobDescription as 'Job Title',
Entities.DoNotWrite as 'Do not Contact',
AT.Code as 'Source of Intro Entity',
AT.Forename + ' ' + AT.Surname as 'Source of Intro Name' 

from entities
Left join entitytypes 
on Entities.TypeRef = Entitytypes.Code 
left join Entities as AT 
on AT.SourceOfIntroRef = entities.Code 
left join CRM_JobRoles 
on Entities.JobRoleID = CRM_JobRoles.Code

order by 'Client'