--dictionary
--���ξ�    USER : ����� ���� ��ü.
--                  ALL  :  ����ڰ� ��� ������ ��ü
--                 DBA  :  ������ ������ ��ü ��ü(�Ϲݻ���ڴ� ��� �Ұ�.)
--                    V$  :  �ý��۰� ���õ� VIEW (�Ϲݻ���ڴ� ��� �Ұ�)

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN ('PC02', 'HR');

--����Ŭ���� ������ SQL�̶�?
--���ڰ� �ϳ��� Ʋ���� �ȵ�.
--���� sql���� ���� ����� ����� �� �� ���� DBMS������
--���� �ٸ�  SQL�� �νĵȴ�.
SELECT /*bind_test*/ * FROM emp;
Select /*bind_test*/* FROM emp;
select /*bind_test*/*  FROM emp;

select /*bind_test*/ * FROM emp WHERE empno = 7369;
select /*bind_test*/ * FROM emp WHERE empno = 7499;
select /*bind_test*/ * FROM emp WHERE empno = 7521;

select /*bind_test*/ * FROM emp WHERE empno =: empno; --�ý��ۿ� ���ʿ��� ���ϸ� ���� �ʱ����� ���.(bind)

SELECT * 
FROM V$SQL ; --system �������� ��ȸ ����.


--������ ��������.
-- (����ŷ���� + �Ƴ� ����+ KFC ����)  /  �Ե����� ����

--sido   ��⵵
--          ������
--          �뱸������
--          ��󳲵�
--          ���ϵ�
--          ���ֱ�����
--          �λ걤����        --�� 2145���� ������.
--          ����Ư����
--          ����������
--          ���󳲵�
--          ����ϵ�
--          ��걤����
--          ��õ������
--          ��û����
--          ��û�ϵ�
--          ����Ư����ġ��
-- �õ�, �ñ��� �� ������� �ʿ�.(����ŷ, �Ƶ�����, KFC) : 
-- �õ�, �ñ��� �� ������� �ʿ�.(�Ե�����) : 
SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu;

SELECT * FROM fastfood;

SELECT gb,sido,sigungu
FROM fastfood
WHERE sido IN('��⵵')
    AND gb IN('����ŷ');

--���� : �߱�, ���� ,����, ������, �����
SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb = '�Ե�����'
            AND sido IN('����')
    GROUP BY sido, sigungu;
















































































