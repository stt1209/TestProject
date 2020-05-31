
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- だいたいこうなる
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-
BEGIN TRY
    BEGIN TRANSACTION        --トランザクションの開始
        --ループ
        ～～～～～～
        end
    COMMIT TRANSACTION       --トランザクションを確定
END TRY
--例外処理
BEGIN CATCH
    ROLLBACK TRANSACTION     --トランザクションを取り消し
    PRINT ERROR_MESSAGE()    --エラー内容を戻す
    PRINT 'ROLLBACK TRANSACTION'
END CATCH


-- トランザクション数
SELECT @@TRANCOUNT 

-- トランザクションが開いていればロールバック
if @@TRANCOUNT > 0 rollback;
