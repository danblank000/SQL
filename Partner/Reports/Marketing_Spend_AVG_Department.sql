SELECT D.Description AS 'Department'
	, AVG(A.CostsNet) AS 'Value'
FROM DAB_MattersAll AS DAB
JOIN Users AS U ON DAB.PartnerRef = U.Code
JOIN Departments AS D ON U.Department = D.Code
JOIN Ac_Billbook AS A ON DAB.Entityref = A.EntityRef
	AND DAB.Number = A.MatterRef
JOIN Entities AS E on DAB.Entityref = E.Code
WHERE A.BillDate > '2016-05-01 00:00:00'
	AND A.BillDate < '2017-04-30 00:00:00'
	AND DAB.Created > '2016-05-01 00:00:00'
	AND DAB.Created < '2017-04-30 00:00:00'
GROUP BY D.Description
ORDER BY D.Description