SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC02';

SELECT *
FROM PC02.V_EMP_DEPT;

--sem �������� ��ȸ������ ���� V_EMP_DEPT VIEW�� hr�������� ��ȸ�ϱ� ���ؼ��� 
--������.view�̸� �������� ��� �ؾ� �Ѵ�.
--�Ź� �������� ����ϱ� �������� �ó���� ���� �ٸ� ��Ī�� ����.

CREATE SYNONYM V_EMP_DEPT FOR PC02.V_EMP_DEPT;


--���� PC02.V_EMP_DEPT �̷��Ծ����� -->  V_EMP_DEPT �̷��Ը� ���ָ� �ȴ�.
SELECT *
FROM V_EMP_DEPT;

DROP SYNONYM V_EMP_DEPT;

--hr ���� ��й�ȣ : java
--hr ���� ��й�ȣ ���� : hr
ALTER USER hr identified BY hr; --���� hr�������� �������̶� ����!
--ALTER USER PC identified BY java; --���ΰ������� �����Ѱ� �ƴ϶� ���� ����






























