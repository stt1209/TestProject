-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- Oracleとの違い
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
レコード型が存在しない。            → 列の数だけ変数が必要
カーソルFORループ構文が存在しない。 → FETCH ～ CLOSE ～ DEALLOCATE が必要
%TYPEの型指定ができない。           → 

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- カーソルのループ
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
DECLARE @TableName NVARCHAR(128),
        @TriggerName NVARCHAR(128),
        @TriggerNameList NVARCHAR(MAX) = '';

DECLARE crTriggerList CURSOR FOR
   SELECT O.name AS TableName,
          TR.name AS TriggerName
   FROM   sys.triggers AS TR
             INNER JOIN sys.objects AS O
                ON TR.parent_id = O.object_id
   WHERE  TR.is_disabled = 0
          AND O.type = 'U'
   ORDER BY TableName, TriggerName;

OPEN crTriggerList;

--フェッチ
FETCH NEXT FROM crTriggerList
INTO @TableName, @TriggerName;

-- 最後までループ
WHILE @@FETCH_STATUS = 0   --直前のFETCHのステータス
BEGIN

   SET @TriggerNameList = @TriggerNameList 
            + @TriggerName 
            + '[' + @TableName + ']' 
            + CHAR(13);
   
   -- フェッチ(基本的には、FETCH_STATUSの都合で同じFETCHを2回書かなければならない)
   FETCH NEXT FROM crTriggerList
   INTO @TableName, @TriggerName;

END

-- CLOSE と DEALLOCATEは忘れずに
CLOSE crTriggerList;
DEALLOCATE crTriggerList;

PRINT @TriggerNameList;


-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- FETCHを1回で済ませる小技
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
WHILE 1 = 1
BEGIN
    FETCH FROM cur_main INTO @rec_ITEM_ID,@rec_ITEM_CODE,@rec_RELEASE_DATE
    IF @@FETCH_STATUS <> 0
    BEGIN
        BREAK;
    END

    PRINT CONVERT(VARCHAR, @rec_ITEM_ID) + '  ' + ISNULL(@rec_ITEM_CODE, '');
END

