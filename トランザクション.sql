
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- �������������Ȃ�
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-
BEGIN TRY
    BEGIN TRANSACTION        --�g�����U�N�V�����̊J�n
        --���[�v
        �`�`�`�`�`�`
        end
    COMMIT TRANSACTION       --�g�����U�N�V�������m��
END TRY
--��O����
BEGIN CATCH
    ROLLBACK TRANSACTION     --�g�����U�N�V������������
    PRINT ERROR_MESSAGE()    --�G���[���e��߂�
    PRINT 'ROLLBACK TRANSACTION'
END CATCH
