USE Partner

DECLARE @Entity VARCHAR(10);
DECLARE @Matter VARCHAR(10);
SET @Entity = 'par486'
SET @Matter = '1'

select * 
from Diary_Appointments 
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter 
and DeleteThis = 0

select * 
from Diary_Tasks 
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter
and DeleteThis = 0

select * 
from Diary_GroupAppointments
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter 
and DeleteThis = 0

select * 
from Diary_GroupTasks
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter 
and DeleteThis = 0

update Diary_Appointments
set DeleteThis = 1 
where dbo.contractentitycode(EntityRef) like @Entity
and MatterNoRef =@Matter 
and DeleteThis = 0

update Diary_Tasks
set DeleteThis = 1 
where dbo.contractentitycode(EntityRef) like @Entity
and MatterNoRef =@Matter 
and DeleteThis = 0

UPDATE Diary_GroupAppointments
SET DeleteThis = 1
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter 
and DeleteThis = 0

UPDATE Diary_GroupTasks
SET DeleteThis = 1
where dbo.contractentitycode(EntityRef) like @Entity 
and MatterNoRef = @Matter 
and DeleteThis = 0
