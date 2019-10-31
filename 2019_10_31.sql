--���̺��� ������ ��ȸ
/*
        SELECT �÷�, | express(���ڿ����)
        FROM �����͸� ��ȸ�� ���̺�(VIEW)
        WHERE ���� (condition)




*/


DESC user_tables;
SELECT table_name, 

'SELECT * FROM ' || table_name || ';' AS select_query

FROM user_tables
WHERE TABLE_NAME != 'EMP'; --��ü�Ǽ����� -1�� ��(13��)���ð�.

SELECT *
FROM user_tables;

--���ں񱳿���
--�μ���ȣ�� 30������ ũ�ų� ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;

--�μ���ȣ�� 30������ ���� �μ��� ���� ���� ��ȸ

SELECT *
FROM emp
WHERE deptno < 30;

--�Ի� ���ڰ� 1928�� 1��1�� ������ ���� ��ȸ�ϱ�.
SELECT *
FROM emp
WHERE hiredate < TO_DATE('19820101', 'YYYYMMDD');


--col BETWEEN X AND Y����
--�÷��� ���� x���� ũ�ų� ����, y���� �۰ų� ���� ������
--�޿�(sal)�� 1000���� ũ�ų� ����, Y���� �۰ų� ���� �����͸� ��ȸ
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--���� BETWEEN AND �����ڴ� �Ʒ��� <=, >= ���հ� ����.
SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <=2000
  AND deptno = 30;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE ('1982/01/01', 'YYYY/MM/DD') AND TO_DATE ('1983/01/01', 'YYYY/MM/DD');

SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE ('1982/01/01', 'YYYY/MM/DD')  
  AND hiredate < TO_DATE ('1983/01/01', 'YYYY/MM/DD');

--IN ������
-- COL IN (values...)
-- �μ���ȣ�� 10 Ȥ�� 20�� ������ ��ȸ�ϱ�.
SELECT *
FROM emp 
WHERE deptno in(10,20);

--IN �����ڴ� OR�����ڷ� ǥ���Ҽ��ִ�.
SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 20;

SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid in ('brown', 'cony', 'sally');


--COL LIKE 'S%'
--COL�� ���� �빮�� S�� �����ϴ� ��� ��
--COL LIKE 'S____'
--COL�� ���� �빮�� S�� �����ϰ� �̾ 4���� ���ڿ��� �����ϴ� ��.

--emp ���̺��� �����̸��� s�� �����ϴ� ��� ���� ��ȸ�ϱ�.
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--LIKE �ǽ� where4
--member���̺��� ȸ���� ���� �ž��� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��ϱ�.

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE ('��%');

--LIKE �ǽ� where5
--member���̺��� ȸ���� ���� �̾��� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��ϱ�.

SELECT mem_id, mem_name
FROM member
 WHERE mem_name LIKE ('%��%');

--WHERE mem_name LIKE ('%��%'); --mem_name�� ���ڿ� �ȿ� �̰� �� ������.
--WHERE mem_name LIKE ('��%'); --mem_name�� �̷� �����ϴ� ������.

--NULL ��
--col IS NULL
--EMP���̺��� MGR ������ ���»��(NULL) ��ȸ
SELECT *
FROM emp 
WHERE mgr IS NULL;
--WHERE MGR !=null; --�񱳰� �����Ѵ�.

SELECT *
FROM emp
WHERE deptno !='10';
-- =, !=
-- is null // is not null

--���ǿ� �´� ������ ��ȸ�ϱ�. (IS NULL �ǽ�where6)
--emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ϴ� ���� �ۼ��ϱ�.

SELECT *
FROM emp
WHERE comm is not null;

--AND / OR
--������(mgr) ����� 7698�̰� �޿�(sal)�� 1000 �̻��� ���
SELECT *
FROM emp
WHERE mgr  = 7698
  AND sal >= 1000;

--emp���̺��� ������(mgr) ����� 7698�̰ų� �޿�(sal)�� 1000 �̻��� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr  = 7698
   OR sal >= 1000;
   
   
--emp���̺��� ������(mgr) ����� 7698�� �ƴϰ�, 7839�� �ƴ� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839); -- IN --> OR

--���� ������ AND/OR �����ڷ� ��ȯ
SELECT *
FROM emp
WHERE mgr != (7698)
   OR mgr !=(7839);

--IN, NOT IN �������� NULL ó��
--emp ���̺��� ������(mgr) ����� 7698, 7839 �Ǵ� null�� �ƴ� ���� ��ȸ�ϱ�.
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
  AND mgr IS NOT NULL;  --IN �����ڿ��� ������� NULL�� ���� ��� �ǵ����� ���� ������ �Ѵ�...!!

--������(AND, OR �ǽ�where7)
--emp���̺��� job��  SALESMAN�̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϱ�.
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM//DD');

--���� ���
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM//DD');

--������(AND, OR �ǽ� where8)
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ�,
--�Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϱ�.
--(IN, NOT IN ������ ��� ����!)

SELECT *
FROM emp
WHERE deptno !=10
AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--������(AND, OR �ǽ� where9)
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ�,
--�Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϱ�.
--(NOT IN ������ ���!)


SELECT *
FROM emp
WHERE deptno NOT IN ('10')
  AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--������(AND, OR �ǽ� where10)
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ�,
--�Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϱ�.
--(�μ��� 10, 20, 30�� �ִٴ� ���� �Ͽ� IN ������ ���.)

SELECT * 
FROM emp
WHERE deptno IN (20, 30)
  AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--������(AND, OR �ǽ� where11)
--emp ���̺��� job�� SALESMAN �̰ų�,
--�Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�ϱ�.

SELECT * 
FROM emp
WHERE job IN ('SALESMAN') --job = 'SALESMAN'
   OR HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--������(AND, OR �ǽ� where12)
--emp ���̺��� job��  SALESMAN �̰ų�,
--�����ȣ�� 78�� �����ϴ� ������ ������ ��ȸ�ϱ�.

SELECT *
FROM emp 
WHERE job = 'SALESMAN'
   OR empno LIKE ('78%');


















--�Ի� ���ڰ� 19


















