SELECT Users.UserStatus, Users.Code, Users.FullName, UserTypes.Description FROM Users 
INNER JOIN Workgroup ON Users.ProfitCostsCostCentre = Workgroup.Code 
INNER JOIN UserTypes ON Users.UserTypeRef = UserTypes.Code ORDER BY Users.Code 
