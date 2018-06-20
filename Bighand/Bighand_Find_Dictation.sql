DECLARE @username  nvarchar(50) = 'ray smith'

SELECT U.BH_UserName as 'Author'
	, T.bh_title as 'Title'
	, T.BH_CreationDate as 'CreationDate'
	, T.BH_CompletionDate as 'CompletionDate'
	, T.BH_TaskGuid as 'FileGuid'
	, L.BH_URL as 'ServerLocation'
	, FL.BH_Path as 'FolderLocation'
FROM BH_Tasks as T
LEFT JOIN BH_users as U on T.BH_author = U.BH_UserGuid
LEFT JOIN BH_FileLocations as FL on T.BH_TaskGuid = FL.BH_FileGuid
LEFT JOIN BH_Locations as L on FL.BH_Location = L.BH_Location
WHERE T.BH_AuthorName = @Username
	--and T.BH_CompletionDate is NULL
	AND T.BH_CreationDate BETWEEN '2017-12-01' AND '2018-01-04'
	--AND t.BH_Title like '%NOT12%'
ORDER BY T.BH_CreationDate








select * from bh_users where bh_lastname like '%rose%'

select * from BH_Tasks where BH_Author = 'F53BAB60-ABD0-4B88-B6FD-57F8CD66DDAB'
and bh_title like '%sco%'
order by bh_title

select * from BHV_HISTORIC_REPORT_TIMELINE where BH_TaskGuid = 'B54A7CF7-2372-44B7-AEE2-D7E72C3C7B2B'

select * from bh_filelocations where bh_fileguid = 'B54A7CF7-2372-44B7-AEE2-D7E72C3C7B2B'