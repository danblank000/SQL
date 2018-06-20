SELECT dbo.contractentitycode(dso.ClientCode) AS 'Client Code'
	,dso.MatterNo AS 'Matter Number'
	,dso.TransactionNo AS 'Disb Txn No.'
	,dso.DisbDate AS 'Date of Disb'
	,dso.Ref AS 'Reference'
	,dso.Narrative1 AS 'Narrative'
	,vat.net_billed AS 'Net Amount Billed'
	,vat.vat_billed AS 'VAT Amount Billed (Output)'
	,vat.Vat_Paid AS 'VAT Amount Incurred (Input)'
	,rates.Description AS 'VAT Output Rate Selected'
	,(
		CASE 
			WHEN xr.type = 'OCRD'
				THEN 'Paid Directly'
			ELSE 'Billed'
			END
		) AS 'Disbursement Paid/Billed?'
FROM Ac_Disbursements dso
JOIN Ac_Disbursements_VAT vat ON dso.TransactionNo = vat.Disbs_ID
	AND dso.AnticipatedNo = vat.AnticipatedNo
JOIN ac_xref xr ON xr.AllocTransaction = dso.TransactionNo
	AND xr.AllocIdentifier = dso.AnticipatedNo
JOIN Ac_VAT_Rates rates ON vat.Code = rates.ID
WHERE vat.VAT_Billed = 0.00
	AND xr.Type IN (
		'OCRD'
		,'BILL'
		)
	AND (CONVERT(DATETIME, dso.disbdate, 103) >= '2017-10-01'
	AND CONVERT(DATETIME, dso.disbdate, 103) <= '2017-12-31'
		 )
GROUP BY dso.ClientCode
	,dso.MatterNo
	,dso.TransactionNo
	,dso.DisbDate
	,dso.Ref
	,dso.Narrative1
	,vat.net_billed
	,vat.vat_billed
	,vat.Vat_Paid
	,rates.Description
	,xr.Type
ORDER BY dso.ClientCode
	,dso.MatterNo
	,dso.DisbDate
	