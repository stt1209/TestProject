-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- ��������INSERT
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
INSERT INTO Student
        ( FirstName, LastName, Birthday, Gender )
    VALUES
        ('Sakura', 'Hata', '1980-07-07', 'F' ),
        ('Ayame', 'Hata', '1981-12-11', 'F' ),
        ('Shinji', 'Hata', '1983-05-06', 'M' );

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- SELECT����INSERT
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
INSERT INTO [�e�[�u��1] ( 
		[�J����1], 
		[�J����2],
		... 
	) 
	SELECT 	[�J����1], 
		[�J����2],
		... 
	FROM 	[�e�[�u��2]
	WHERE 	...
	-- JOIN �Ƃ����Ă��悢

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- JOIN��UPDATE
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
UPDATE  TR
SET     Score = Score + 1
FROM    TestResult AS TR
            INNER JOIN Test AS T
                ON TR.TestID = T.TestID
            INNER JOIN Student AS S
                ON TR.StudentID = S.StudentID
WHERE   T.TestNameJp = N'���w�P'
        AND YEAR(S.Birthday) >= 1980;


-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- JOIN��DELETE
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
DELETE  TR
FROM    TestResult AS TR
            INNER JOIN Student AS S
                ON TR.StudentID = S.StudentID
WHERE   S.LastName = 'Tanaka';

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- SELECT�Ńe�[�u���쐬
--  �L�[�␧��Ȃǂ̓R�s�[����Ȃ�
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
SELECT      T.TestID,
            T.TestNameEn,
            MIN(Score) AS MIN_Score,
            MAX(Score) AS MAX_Score,
            AVG(CAST(Score AS DECIMAL)) AS AVG_Score,
            COUNT(StudentID) AS COUNT_Student
INTO        #TestResultSummary2   --�u#�v�L�������Ĉꎞ�e�[�u���ɂ���(SQLSerevr�̈ꎞ�e�[�u��)�B
FROM        TestResult AS TR
                INNER JOIN Test AS T
                    ON TR.TestID = T.TestID
GROUP BY    T.TestID,
            T.TestNameEn;

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- �e�[�u��������΍폜
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
DROP TABLE IF EXISTS TestResult;

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- �悭�g����֐�
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
�悭�g���镶����֐� 1 - LEFT, RIGHT, SUBSTRING
�悭�g���镶����֐� 2 - LTRIM, RTRIM, UPPER, LOWER, LEN
�悭�g���镶����֐� 3 - REPLACE, CHARINDEX, CHAR
�悭�g������t�Ǝ����̊֐� 1 - GETDATE, YEAR, MONTH, DAY, DATEPART
�悭�g������t�Ǝ����̊֐� 2 - DATEADD, DATEDIFF, ISDATE
�悭�g���鏇�ʕt���֐� 1 - ROW_NUMBER
�悭�g���鏇�ʕt���֐� 2 - RANK, DENSE_RANK
	�֐���() OVER ( [ PARTITION BY [�p�e�B�V�����J���� 1 ], [�p�e�B�V�����J���� 2], ... ] ORDER BY [�\�[�g�J���� 1], [�\�[�g�J���� 2],
		���p�[�e�B�V�����J�����Ŏd�؂����͈͓��ŁA�\�[�g���A���ʂ�����
�悭�g���鏇�ʕt���֐� 3 - NTILE
�m���Ă����ƕ֗��Ȋ֐� - NULLIF�@�@�@��2�̒l����������΁ANULL��Ԃ�(����l��NULL���ȂǂɎg�p)
