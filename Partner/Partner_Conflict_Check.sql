USE Partner

SELECT
	Entities.Shortcode + '/' + CAST(Matters.Number AS VARCHAR(15)) AS FileRef,
	Entities.ShortCode AS ShortCode,
	Matters.EntityRef AS EntityRef,
	Matters.Number AS Number,
	Entities.LegalName AS LegalName,
	Matters.Description AS Description,
	Matters.Created AS Created,
	CaseTypes.Code AS Code,
	CaseTypes.Description AS "CaseType_Description",
	Users.Code AS FeeEarner,
	Users.FullName AS FullName,
	Matters.LockID AS LockID,
	"Usr_Conflict_Check"."Other_Parties" AS "Other_Parties",
	"Usr_Conflict_Check"."Conflict_Search_Email_Ready_to_Send" AS "Conflict_Search_Email_Ready_to_Send",
	"Usr_Conflict_Check"."Conflict_Search__Email_Sent" AS "Conflict_Search__Email_Sent",
	"Usr_Conflict_Check"."Other_Parties_Detail" AS "Other_Parties_Detail",
	Departments.Description AS Department
FROM
	Entities INNER JOIN (((Matters INNER JOIN CaseTypes ON Matters.CaseTypeRef = CaseTypes.Code) INNER JOIN Users ON Matters.FeeEarnerRef = Users.Code) INNER JOIN "Usr_Conflict_Check" ON Matters.EntityRef = "Usr_Conflict_Check".EntityRef
	AND Matters.Number = "Usr_Conflict_Check".MatterNo) ON Entities.Code = Matters.EntityRef INNER JOIN MattersHistory on Matters.EntityRef = MattersHistory.EntityRef and Matters.Number = MattersHistory.Number inner join Users U2 on MattersHistory.UserRef = U2.Code
	INNER JOIN Departments on Users.Department = Departments.code
WHERE
	Matters.LockID = 0
	AND "Usr_Conflict_Check"."Conflict_Search_Email_Ready_to_Send" = 'Y'
	--AND "Usr_Conflict_Check"."Conflict_Search__Email_Sent" IS NULL
	AND CaseTypes.Code <> 50
	AND MattersHistory.Action = 'Created'
ORDER BY
	Matters.Created DESC