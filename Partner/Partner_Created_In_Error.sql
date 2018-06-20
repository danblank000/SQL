DELETE FROM cm_caseitems
WHERE cm_caseitems.itemID IN 

	(
	SELECT dbo.Cm_CaseItems.ItemID
	FROM dbo.Cm_CaseItems
	INNER JOIN dbo.Cm_Agendas ON dbo.Cm_CaseItems.ItemID = dbo.Cm_Agendas.ItemID
	LEFT JOIN dbo.Cm_CaseItems AS Cm_CaseItems_1 ON dbo.Cm_CaseItems.ItemID = Cm_CaseItems_1.ParentID
	GROUP BY dbo.Cm_CaseItems.Description
			, dbo.Cm_CaseItems.ItemID
			, dbo.Cm_Agendas.EntityRef
			, dbo.Cm_Agendas.MatterNo
	HAVING (dbo.Cm_CaseItems.Description = 'created in error')
	AND (COUNT(Cm_CaseItems_1.ItemID) = 0)
	/*ORDER BY dbo.Cm_Agendas.EntityRef
			, dbo.Cm_Agendas.MatterNo
			, dbo.Cm_CaseItems.ItemID*/
	)