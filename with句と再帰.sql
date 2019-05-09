
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- with句(CTE式)
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
WITH CTE_1 AS
(
    -- サブクエリの内容を記述
    SELECT ID FROM T_HOGE(NOLOCK)
    WHERE ID = 1
)
-- ","区切りで複数定義可能
, CTE_2 AS
(
    SELECT ID FROM T_HOGEHOGE(NOLOCK)
    WHERE ID = 2
)
SELECT * FROM T_HUGA (NOLOCK) AS HUGA
LEFT JOIN CTE_1 (NOLOCK) AS CTE
ON 
    HUGA.ID = CTE_1.ID
LEFT JOIN CTE_2 (NOLOCK) AS CTE
ON
    HUGA.ID = CTE_2.ID

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- @#テーブルとの違い
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
・宣言直後のクエリでのみ参照可能
	@テーブルの場合：宣言後、一連のクエリの処理が完了するまで参照可能
	#テーブルの場合：宣言後、明示的にテーブルを削除するか、クエリセッションが切れるまで参照可能
・あくまでサブクエリの外だしなので、メモリ上で処理
	@テーブルの場合、同じくメモリ上で処理
	注意事項：メモリで処理しきれない場合、実ファイルへの書き込みが発生
	#テーブルの場合、実ファイルへ書き込み、実ファイル上から処理
・インデックスは付けられない（サブクエリなので）
	@#テーブルの場合、インデックスを作成可能

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- 再帰SQL
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
再帰SQLを使うと、テーブルに一時的に名前を付けることで、再帰処理(ループ)を実現できます。
メインクエリの中で同じサブクエリを何度も呼び出している場合に使われるのがwith句です。with句を使うとサブクエリに名前をつけることができるので、メインクエリから何度でも呼び出すことができます。

例えば木構造のデータを格納しているテーブルで、根から葉までたどるような場合です。



テーブル
INSERT INTO tree (id, parent_id) VALUES
(1, null)
, (2, 1)
, (3, 1)
, (4, 1)
, (5, 2)
, (6, 2)
, (7, 3)
, (8, 7)


SQL
WITH r AS (
    SELECT * FROM tree WHERE id = 1     -- id=1を検索
    UNION ALL
    SELECT tree.* FROM tree, r WHERE tree.parent_id = r.id   -- 親IDがさっきのと一致するやつを検索、その結果のみに対して親IDが一致するやつを検索、その結果のみに・・・ とUNION ALL していく
)
SELECT * FROM r