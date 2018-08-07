SELECT sqltext.TEXT
	, req.session_id
	, req.status
	, req.command
	, req.cpu_time
	, req.total_elapsed_time
FROM sys.dm_exec_requests req
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
AS sqltext
ORDER BY req.total_elapsed_time


--Find who is responsible
EXEC sp_who '434'
EXEC sp_who '568'
EXEC sp_who '317'
EXEC sp_who '536'


--Stop query
KILL 434
KILL 452
KILL 288
KILL 248


--Create a temporary teable for SP_Who2 
CREATE TABLE #sp_who2 (SPID INT,Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255), 
      BlkBy  VARCHAR(255),DBName  VARCHAR(255), 
      Command VARCHAR(255),CPUTime INT, 
      DiskIO INT,LastBatch VARCHAR(255), 
      ProgramName VARCHAR(255),SPID2 INT, 
      REQUESTID INT) 
INSERT INTO #sp_who2 EXEC sp_who2




SELECT      * 
FROM        #sp_who2
-- Add any filtering of the results here :
WHERE       DBName = 'partner'--<> 'master' or DBName  <> 'HRNET'
--AND			Login like '%admin%'
-- Add any sorting of the results here :
ORDER BY    DBName ASC
 




DROP TABLE #sp_who2