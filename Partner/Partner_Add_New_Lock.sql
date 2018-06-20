insert into keys
(UserRef, LockRef)
Values
-- IT
('DAB' , '76'),
('JMH' , '76'),
('PZG' , '76'),
('WAS' , '76'),

-- STEVE
('SPE' , '76'),
('JAW' , '76'),

--ACCOUNTS
('JBC' , '76'),
('JU' , '76'),
('ARC' , '76'),
('JBM' , '76'),
('HBA' , '76'),
('SKB' , '76'),
('MFC' , '76'),
('AAB' , '76'),
('GJ' , '76'),
('TAM' , '76'),
('ACS' , '76'),

--RISK
('HJS' , '76'),
('VB2' , '76'),
('OZW' , '76'),

--OTHERS
('SCB' , '76'),
('KLB' , '76'),
('SZS' , '76'),
('RB' , '76'),
('NAC' , '76')





select * from locks where code = 54
select * from Keys where LockRef = 54