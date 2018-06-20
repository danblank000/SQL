
UPDATE Users
SET StandardChargeRate = '130.00'
where FullName like '%Grace%'
OR FullName like '%Wallis%'
OR FullName like '%cla%Moran%'
OR FullName like '%Treac%'
OR FullName like '%Danielle%'



/*
 TARGETS ARE STORED IN SECONDS
*/
UPDATE Targets
SET FeesBilled = '8333.0000',
NonChargeableTime = '36000'
WHERE (FeeEarnerRef = 'GAE'
OR FeeEarnerRef = 'MAW'
OR FeeEarnerRef = 'CLM'
OR FeeEarnerRef = 'CAT'
OR FeeEarnerRef = 'DAW')
AND YEAR = '2017'
AND (Period = 7
OR Period = 8
OR Period = 9
OR Period = 10
OR Period = 11
OR Period = 12)