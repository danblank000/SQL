SELECT dbo.ContractEntityCode(M.EntityRef) AS 'Entity'
    , E.Name
    , M.Number
    , M.Description
    , M.Created
    , M.WIPLimit
    , UF.FullName AS 'Fee-Earner'
    , UP.FullName AS 'Partner'
    , D.Description
    , SUM(M.WIpLimit) AS total
FROM Matters AS M
JOIN Entities AS E ON M.EntityRef = E.Code
JOIN Users AS UF ON M.FeeEarnerRef = UF.Code
JOIN Users AS UP ON M.PartnerRef = UP.Code
JOIN Departments AS D ON UP.Department = D.Code
WHERE M.Created > EOMONTH(DATEADD(mm, -1, GETDATE()))
    AND M.WIPLimit <> 0.00
GROUP BY 
        D.Description
    , rollup ((  dbo.ContractEntityCode(M.EntityRef)
                , E.Name
                , M.Number
                , M.Description
                , M.Created
                , M.WIPLimit
                , UF.FullName
                , UP.FullName
                ))