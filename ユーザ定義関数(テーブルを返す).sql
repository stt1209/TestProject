-- 呼び出し方法
SELECT  *
FROM    dbo.ufnStudentTestReportGet(1);

-- 定義方法
CREATE FUNCTION ufnStudentTestReportGet (
    @StudentID INT
)  
RETURNS @StudentTestReport TABLE (
    TestID          INT NOT NULL,
    TestName        NVARCHAR(50) NULL,
    Score           INT NULL,
    TestAvgScore    DECIMAL(5,2) NULL
)
AS
BEGIN
    
    INSERT INTO @StudentTestReport (
                TestID,
                TestName,
                Score
        )
        SELECT  T.TestID,
                T.TestNameEn,
                TR.Score
        FROM    TestResult AS TR
                    INNER JOIN Test AS T
                        ON TR.TestID = T.TestID
        WHERE   TR.StudentID = @StudentID;

    UPDATE  T
    SET     TestAvgScore = A.TestAvgScore
    FROM    @StudentTestReport AS T
                INNER JOIN 
                    (SELECT     TestID,
                                AVG(CAST(Score AS DECIMAL)) AS TestAvgScore
                     FROM       TestResult
                     WHERE      Score IS NOT NULL
                     GROUP BY   TestID) AS A
                ON T.TestID = A.TestID;

    RETURN;

END