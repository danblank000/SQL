SELECT OBJECT_SCHEMA_NAME (c.object_id) SchemaName,
        o.Name AS Table_Name, 
        c.Name AS Field_Name,
        t.Name AS Data_Type,
        t.max_length AS Length_Size,
        t.precision AS Precision
FROM sys.columns c 
     INNER JOIN sys.objects o ON o.object_id = c.object_id
     LEFT JOIN  sys.types t on t.user_type_id  = c.user_type_id   
WHERE o.type = 'U'
and o.Name = 'Entities'
ORDER BY o.Name, c.Name
