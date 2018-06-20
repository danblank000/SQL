UPDATE Ac_Disbursements
SET BilledInd = 2
WHERE ClientCode LIKE 'LLo%158'
	AND MatterNo = 77
	AND TransactionNo IN (
		1028704
		,1028705
		)

UPDATE Ac_Disbursements_VAT
SET Billed_Ind = 1
	,Net_Billed = Net
WHERE Disbs_ID IN (
		1028704
		,1028705
		)

UPDATE Ac_Client_Ledger_Transactions
SET UnBilledDisbursement = 0
WHERE Transaction_No IN (
		1028704
		,1028705
		)

UPDATE Ac_Disbursements
SET BilledInd = 2
WHERE ClientCode LIKE 'LLo%158'
	AND MatterNo = 77
	AND TransactionNo IN (
		1025096
		,1030247
		)

UPDATE Ac_Disbursements_VAT
SET Billed_Ind = 1
	,Net_Billed = Net
WHERE Disbs_ID IN (
		1025096
		,1030247
		)

UPDATE Ac_Client_Ledger_Transactions
SET UnBilledDisbursement = 0
WHERE Transaction_No IN (
		1025096
		,1030247
		)

