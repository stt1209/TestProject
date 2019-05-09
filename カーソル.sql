-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- Oracle�Ƃ̈Ⴂ
-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
���R�[�h�^�����݂��Ȃ��B            �� ��̐������ϐ����K�v
�J�[�\��FOR���[�v�\�������݂��Ȃ��B �� FETCH �` CLOSE �` DEALLOCATE ���K�v
%TYPE�̌^�w�肪�ł��Ȃ��B           �� 

-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- �J�[�\���̃��[�v
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

--�t�F�b�`
FETCH NEXT FROM crTriggerList
INTO @TableName, @TriggerName;

-- �Ō�܂Ń��[�v
WHILE @@FETCH_STATUS = 0   --���O��FETCH�̃X�e�[�^�X
BEGIN

   SET @TriggerNameList = @TriggerNameList 
            + @TriggerName 
            + '[' + @TableName + ']' 
            + CHAR(13);
   
   -- �t�F�b�`(��{�I�ɂ́AFETCH_STATUS�̓s���œ���FETCH��2�񏑂��Ȃ���΂Ȃ�Ȃ�)
   FETCH NEXT FROM crTriggerList
   INTO @TableName, @TriggerName;

END

-- CLOSE �� DEALLOCATE�͖Y�ꂸ��
CLOSE crTriggerList;
DEALLOCATE crTriggerList;

PRINT @TriggerNameList;


-- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
-- FETCH��1��ōς܂��鏬�Z
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

