select 

Keys.UserRef as 'Initials', 
users.FullName as 'Name', 
Locks.Code as 'Lock Code', 
Locks.Description as 'Lock Name'  

From Keys 
inner join Locks
on Keys.LockRef = Locks.Code
inner join users 
on keys.userref = users.code

order by 'lock code'