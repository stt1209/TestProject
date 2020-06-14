-- テーブル
SELECT
 tb.name tableName
 FROM sys.tables tb
WHERE tb.type = 'U'
ORDER BY tb.object_id

-- 列
SELECT
 tb.name tableName
 ,cl.name columnName
 ,type_name(user_type_id) dataType
 ,cl.max_length
 ,cl.precision
 ,cl.scale
 ,cl.is_nullable
 ,cl.is_identity
 ,cl.collation_name
 ,cl.is_ansi_padded
 FROM sys.tables tb
 inner join sys.columns cl
 on cl.object_id = tb.object_id
WHERE tb.type = 'U'
ORDER BY tb.object_id, cl.column_id


-- テーブルごとの列