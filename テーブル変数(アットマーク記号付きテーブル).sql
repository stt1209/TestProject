テーブル変数は実行時のみメモリ上に存在する仮想テーブルです。

一般的なプログラミング言語に用意されている配列のように使用することもできます。

このテーブル変数は通常の変数と同様に処理完了時に自動的に廃棄されるため、データの削除処理やテーブル自体の削除処理は不要です。


DECLARE @MEMBERS TABLE(
      ID INT
    , NAME VARCHAR(20)
    , PRIMARY KEY (ID)
 ) 
 
 
 INSERT INTO @MEMBERS VALUES
   (1, 'TARO')
 , (2, 'JIRO')
 , (3, 'SABURO')
 , (4, 'SHIRO')
 , (5, 'GORO'); 
 
 
SELECT * FROM @MEMBERS 
 
DELETE FROM @MEMBERS
WHERE ID = '3' 