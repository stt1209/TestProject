SELECT
  tableName
  ,'SELECT * INTO ZTEST_BKUP_' + tableName + ' FROM ' + tableName + ';' N'�o�b�N�A�b�vSQL'
  -- IDENTITY_INSERT��1�Z�b�V������1�e�[�u������ON�ɂł���B�Z�b�V�����I�����OFF�ɂȂ�
  ,CASE WHEN isIdentity = 1 THEN 'SET IDENTITY_INSERT ' + tableName + ' ON;' + CHAR(13) + CHAR(10) ELSE '' END
    + 'INSERT INTO ' + tableName + ' (' + left(colnames, len(colnames) - 1) + ') SELECT ' + left(colnames, len(colnames) - 1) + ' FROM ZTEST_BKUP_' + tableName + ';'
    + CASE WHEN isIdentity = 1 THEN CHAR(13) + CHAR(10) + 'SET IDENTITY_INSERT ' + tableName + ' OFF;' ELSE '' END '����SQL'
  ,'DROP TABLE ZTEST_BKUP_' + tableName + ';' N'�o�b�N�A�b�v�e�[�u���폜SQL'
--  ,colnames
--  ,isIdentity
FROM (
	SELECT 
	  tb.Name tableName
	  ,(SELECT MAX(CAST(cl2.is_identity AS INTEGER)) FROM sys.columns cl2 WHERE tb.object_ID = cl2.object_id) isIdentity
	  ,(
			SELECT
				cl.name + ','
			FROM
				sys.columns cl
			WHERE
				cl.object_id = tb.object_id
			--	AND cl.is_identity = 0
			ORDER BY cl.column_id
			FOR XML PATH('')
	  ) colnames
	FROM sys.tables tb
	WHERE tb.type = 'U'
) TMP
WHERE tableName IN ('test3','test1','test4','TestFkeyTable1','TestFkeyTable2','TestFkeyTable3','TestFkeyTable4','PRT','test2')
