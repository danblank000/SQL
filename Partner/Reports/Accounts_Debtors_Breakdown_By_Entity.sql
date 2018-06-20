-- Client AC Balance
SELECT MAX(Status) AS 'Type'
	, MAX(Name) AS 'Name'
	, MAX(Code) AS 'Entity Ref'
	, MAX(ClientAcBalances) AS 'Client AC Balance'
FROM KSL_DebtorsBreakdown
GROUP BY Code
ORDER BY MAX(Status)
	, MAX(Code)



-- Unbilled Disbs
SELECT MAX(Status) AS 'Type'
	, MAX(Name) AS 'Name'
	, MAX(Code) AS 'Entity Ref'
	, MAX(UnbilledDisbBalances) AS 'Unbilled Disbs'
FROM KSL_DebtorsBreakdown
GROUP BY Code
ORDER BY MAX(Status)
	, MAX(Code)



-- Unpaid Bills
SELECT MAX(Status) AS 'Type'
	, MAX(Name) AS 'Name'
	, MAX(Code) AS 'Entity Ref'
	, MAX(UnpaidBillBalances) AS 'Client AC Balance'
FROM KSL_DebtorsBreakdown
GROUP BY Code
ORDER BY MAX(Status)
	, MAX(Code)


-- <=30 Days
SELECT agg.*
	, ISNULL(ksum.tot,0) AS 'OutstandingTotal'
FROM (
	SELECT MAX(kd.Status) AS 'Status'
		, MAX(kd.Name) AS 'Name'
		, kd.Code AS 'Code'
      FROM KSL_DebtorsBreakdown kd
	  GROUP BY kd.Code) AS agg
LEFT JOIN (
	  SELECT SUM(k.OutstandingTotal) tot
	    , Code
	  FROM KSL_DebtorsBreakdown k
      WHERE k.BillDate >= CAST(DATEADD(dd, -30, GETDATE()) AS DATE)
      GROUP BY Code) AS ksum ON agg.Code= ksum.Code
ORDER BY agg.status
	, agg.Code



-- 31 - 60 Days
SELECT agg.*
	, ISNULL(ksum.tot,0) AS 'OutstandingTotal'
FROM (
	SELECT MAX(kd.Status) AS 'Status'
		, MAX(kd.Name) AS 'Name'
		, kd.Code AS 'Code'
      FROM KSL_DebtorsBreakdown kd
	  GROUP BY kd.Code) AS agg
LEFT JOIN (
	  SELECT SUM(k.OutstandingTotal) tot
	    , Code
	  FROM KSL_DebtorsBreakdown k
      WHERE k.BillDate >= CAST(DATEADD(dd, -60, GETDATE()) AS DATE)
	  AND k.BillDate <= CAST(DATEADD(dd, -31, GETDATE()) AS DATE)
      GROUP BY Code) AS ksum ON agg.Code= ksum.Code
ORDER BY agg.status
	, agg.Code


-- 61 - 90 Days
SELECT agg.*
	, ISNULL(ksum.tot,0) AS 'OutstandingTotal'
FROM (
	SELECT MAX(kd.Status) AS 'Status'
		, MAX(kd.Name) AS 'Name'
		, kd.Code AS 'Code'
      FROM KSL_DebtorsBreakdown kd
	  GROUP BY kd.Code) AS agg
LEFT JOIN (
	  SELECT SUM(k.OutstandingTotal) tot
	    , Code
	  FROM KSL_DebtorsBreakdown k
      WHERE k.BillDate >= CAST(DATEADD(dd, -90, GETDATE()) AS DATE)
	  AND k.BillDate <= CAST(DATEADD(dd, -61, GETDATE()) AS DATE)
      GROUP BY Code) AS ksum ON agg.Code= ksum.Code
ORDER BY agg.status
	, agg.Code



-- 91 - 120 Days
SELECT agg.*
	, ISNULL(ksum.tot,0) AS 'OutstandingTotal'
FROM (
	SELECT MAX(kd.Status) AS 'Status'
		, MAX(kd.Name) AS 'Name'
		, kd.Code AS 'Code'
      FROM KSL_DebtorsBreakdown kd
	  GROUP BY kd.Code) AS agg
LEFT JOIN (
	  SELECT SUM(k.OutstandingTotal) tot
	    , Code
	  FROM KSL_DebtorsBreakdown k
      WHERE k.BillDate >= CAST(DATEADD(dd, -120, GETDATE()) AS DATE)
	  AND k.BillDate <= CAST(DATEADD(dd, -91, GETDATE()) AS DATE)
      GROUP BY Code) AS ksum ON agg.Code= ksum.Code
ORDER BY agg.status
	, agg.Code


-- <= 121 Days
SELECT agg.*
	, ISNULL(ksum.tot,0) AS 'OutstandingTotal'
FROM (
	SELECT MAX(kd.Status) AS 'Status'
		, MAX(kd.Name) AS 'Name'
		, kd.Code AS 'Code'
      FROM KSL_DebtorsBreakdown kd
	  GROUP BY kd.Code) AS agg
LEFT JOIN (
	  SELECT SUM(k.OutstandingTotal) tot
	    , Code
	  FROM KSL_DebtorsBreakdown k
      WHERE k.BillDate <= CAST(DATEADD(dd, -121, GETDATE()) AS DATE)
      GROUP BY Code) AS ksum ON agg.Code= ksum.Code
ORDER BY agg.status
	, agg.Code
