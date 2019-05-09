

CREATE FUNCTION ufnStudentNoGet (
    @StudentID INT
)  
RETURNS NVARCHAR(50)
AS
BEGIN
    
    DECLARE @StudentNo  NVARCHAR(50),
            @FirstName  NVARCHAR(50),
            @LastName   NVARCHAR(50),
            @Birthday   DATE;

    SELECT  @FirstName = FirstName,
            @LastName = LastName,
            @Birthday = Birthday
    FROM    Student
    WHERE   StudentID = @StudentID;

    IF ISNULL(YEAR(@Birthday), 0) <= 1979
    BEGIN

        SET @StudentNo = 'A' 
                         + ISNULL(UPPER(LEFT(@FirstName, 1)), '')
                         + '_'
                         + ISNULL(UPPER(@LastName), '')
                         + ISNULL(CAST(@StudentID AS NVARCHAR), '');

    END
    ELSE
    BEGIN

        SET @StudentNo = 'B'
                         + ISNULL(UPPER(LEFT(@FirstName, 1)), '')
                         + '_'
                         + ISNULL(UPPER(@LastName), '')
                         + ISNULL(CAST(@StudentID AS NVARCHAR), '');

    END

    RETURN @StudentNo;

END;
