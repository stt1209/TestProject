-- コマンド作成SQL
SELECT N'ALTER TABLE ' + OBJECT_NAME(parent_object_id) + ' NOCHECK CONSTRAINT ALL;'
       ,N'ALTER TABLE ' + OBJECT_NAME(parent_object_id) + '  WITH CHECK CHECK CONSTRAINT all;'
FROM sys.foreign_keys
WHERE OBJECT_NAME(parent_object_id) LIKE '%'
;

--OFF
-- ALTER TABLE TestTableName NOCHECK CONSTRAINT ALL;
--ON
-- ALTER TABLE TestTableName WITH CHECK CHECK CONSTRAINT all;


-- OFFの外部キー制約の数を確認
SELECT count(*)
 FROM sys.foreign_keys
where is_disabled = 1;


