SELECT BH_FirstName + BH_LastName + '@kuits.com' 
FROM BH_Users
WHERE BH_MobileUser = 1


UNION

SELECT U.BH_Firstname + U.BH_LastName + '@kuits.com'
FROM BH_AdditionalFeatureUsers AS AF
JOIN BH_Users AS U ON AF.BH_UserGuid = U.BH_UserGuid
WHERE  AF.BH_FeatureId = 4





