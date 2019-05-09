BULK INSERT Students
FROM 'c:\NewStudents.txt'
WITH
(
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n'
);
