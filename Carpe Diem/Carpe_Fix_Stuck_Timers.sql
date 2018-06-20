USE CarpeDiem
DECLARE @Initials VARCHAR(4)
SET @Initials = 'RNS'


--Show currently running timers
SELECT *
FROM cdststop AS st
JOIN cdtime AS t ON st.timeid = t.id
WHERE st.starttime = st.stoptime
AND TKPRID = @Initials






-- To delete the stuck timer
-- MAKE SURE THE FEE-EARNER KNOWS DETAILS FOR TIME ENTRY, DELETE THE TIME AND TELL THEM TO MANULLAY ADD IT IN
DELETE cdststop
Where TIMEID = 'EbogrhGCJStBhkY6zgM6VGNpO'




-- Set stop time on timer
-- User will need to then edit the time entry before it picks up the time 
-- ONLY USE THIS IF THEY HAVE WRITTEN A VERY LONG NARRATIVE AND DON’T WANT TO LOSE THE WORK
UPDATE cdststop
SET stoptime = 'enter the relevant STOPTIME'
WHERE timeid = 'enter the relevant TIMEID'



select * from CDTIME