-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- 複数同時INSERT
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
INSERT INTO Student
        ( FirstName, LastName, Birthday, Gender )
    VALUES
        ('Sakura', 'Hata', '1980-07-07', 'F' ),
        ('Ayame', 'Hata', '1981-12-11', 'F' ),
        ('Shinji', 'Hata', '1983-05-06', 'M' );

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- SELECTからINSERT
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
INSERT INTO [テーブル1] ( 
		[カラム1], 
		[カラム2],
		... 
	) 
	SELECT 	[カラム1], 
		[カラム2],
		... 
	FROM 	[テーブル2]
	WHERE 	...
	-- JOIN とかしてもよい

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- JOINでUPDATE
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
UPDATE  TR
SET     Score = Score + 1
FROM    TestResult AS TR
            INNER JOIN Test AS T
                ON TR.TestID = T.TestID
            INNER JOIN Student AS S
                ON TR.StudentID = S.StudentID
WHERE   T.TestNameJp = N'数学１'
        AND YEAR(S.Birthday) >= 1980;


-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- JOINでDELETE
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
DELETE  TR
FROM    TestResult AS TR
            INNER JOIN Student AS S
                ON TR.StudentID = S.StudentID
WHERE   S.LastName = 'Tanaka';

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- SELECTでテーブル作成
--  キーや制約などはコピーされない
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
SELECT      T.TestID,
            T.TestNameEn,
            MIN(Score) AS MIN_Score,
            MAX(Score) AS MAX_Score,
            AVG(CAST(Score AS DECIMAL)) AS AVG_Score,
            COUNT(StudentID) AS COUNT_Student
INTO        #TestResultSummary2   --「#」記号をつけて一時テーブルにする(SQLSerevrの一時テーブル)。
FROM        TestResult AS TR
                INNER JOIN Test AS T
                    ON TR.TestID = T.TestID
GROUP BY    T.TestID,
            T.TestNameEn;

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- テーブルがあれば削除
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
DROP TABLE IF EXISTS TestResult;

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- よく使われる関数
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
よく使われる文字列関数 1 - LEFT, RIGHT, SUBSTRING
よく使われる文字列関数 2 - LTRIM, RTRIM, UPPER, LOWER, LEN
よく使われる文字列関数 3 - REPLACE, CHARINDEX, CHAR
よく使われる日付と時刻の関数 1 - GETDATE, YEAR, MONTH, DAY, DATEPART
よく使われる日付と時刻の関数 2 - DATEADD, DATEDIFF, ISDATE
よく使われる順位付け関数 1 - ROW_NUMBER
よく使われる順位付け関数 2 - RANK, DENSE_RANK
	関数名() OVER ( [ PARTITION BY [パティションカラム 1 ], [パティションカラム 2], ... ] ORDER BY [ソートカラム 1], [ソートカラム 2],
		→パーティションカラムで仕切った範囲内で、ソートし、順位をつける
よく使われる順位付け関数 3 - NTILE
知っておくと便利な関数 - NULLIF　　　→2つの値が等しければ、NULLを返す(特殊値のNULL化などに使用)
