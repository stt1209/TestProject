�e�[�u���ϐ��͎��s���̂݃�������ɑ��݂��鉼�z�e�[�u���ł��B

��ʓI�ȃv���O���~���O����ɗp�ӂ���Ă���z��̂悤�Ɏg�p���邱�Ƃ��ł��܂��B

���̃e�[�u���ϐ��͒ʏ�̕ϐ��Ɠ��l�ɏ����������Ɏ����I�ɔp������邽�߁A�f�[�^�̍폜������e�[�u�����̂̍폜�����͕s�v�ł��B


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