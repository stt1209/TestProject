SELECT	EmployeeID,
	EmployeeName,
	[201601], [201602], [201603]
FROM 
	(SELECT S.EmployeeID,
		E.EmployeeName,
		LEFT(CONVERT(NVARCHAR, S.SalesDate, 112), 6) AS YYYYMM,
		S.SalesAmount
	 FROM	Sales AS S
			INNER JOIN Employee AS E
				ON S.EmployeeID = E.EmployeeID
	 WHERE	S.SalesDate BETWEEN '2016-01-01' AND '2016-03-31') AS T
PIVOT
(
	SUM(SalesAmount)
	FOR YYYYMM IN
		([201601], [201602], [201603])
) AS PVT
ORDER BY EmployeeID;



