SELECT s.FileName
	, s.ItemID
	, e.ShortCode
	, a.MatterNo
	,CONCAT (
		'\\kslfs01\ptrdata\docs\'
		,substring(convert(VARCHAR(15), e.shortcode, 103), 1, 1)
		,'\'
		,substring(convert(VARCHAR(15), e.shortcode, 103), 2, 1)
		,'\'
		,substring(convert(VARCHAR(15), e.shortcode, 103), 3, 1)
		,'\'
		,e.shortcode
		,'\'
		,a.matterno
		,s.filename
		) AS NewFileName
FROM Cm_Steps s
INNER JOIN Cm_CaseItems c ON s.itemid = c.itemid
INNER JOIN Cm_Agendas a 
INNER JOIN Entities e ON a.EntityRef = e.code ON c.ParentID = a.itemid 
WHERE s.FileName not like '\\kslf%'
AND s.FileName not like 'U:%'
AND s.FileName > ''
AND s.FileName not like '__ks%'





select filename, * from Cm_Steps
where ItemID in (11678648,11678646)