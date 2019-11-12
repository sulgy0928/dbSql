--�����Ҷ� �������� ȥ�� © �� �˾ƾ���....^��^

--�ǽ� sub7 ppt 249p
--1������ �Դ� ������ǰ
--2���� �� �Դ� ������ǰ
--����� ��ǰ�� �߰�.
SELECT cycle.cid, customer.cnm, product.pid,product.pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN(SELECT pid 
                    FROM cycle    
                    WHERE cid = 2);

--�ǽ� sub9 ppt 252p
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X' 
                                FROM cycle
                                WHERE cid = 1 
                                AND pid = product.pid);

--1������ ������ǰ
SELECT *
FROM cycle
WHERE cid = 1;

SELECT *
FROM DEPT;

-- DELETE DEPT WHERE DEPTNO = 99;  �̷��� �ϸ� �ش����sql���� �ٽ���ȸ�ϸ�
--�������ɷ� ��ȸ������ �ٸ��������� �ٽ���ȸ�ϸ� ������ ���������ʰ� �����ִ�.
-- commit�� ���� �ʾƼ� Ȯ������ �ʾ� �ݿ��� �ȵǴ� ���ε�, commit�� �ϸ� ����Ǿ� ����� ��������.


desc emp;

desc dept;

INSERT INTO emp ( ename, job)
VALUES( 'brown', null);

SELECT *
FROM emp
WHERE empno = 9999;

rollback;

desc emp;

SELECT *
FROM USER_TAB_COLUMNS
WHERE table_name = 'EMP'
ORDER BY column_id;
1. EMPNO
2. ENAME
3. JOB
4. MGR
5. HIREDATE
6. SAL
7. COMM
8. DEPTNO

INSERT INTO emp
VALUES (9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);

--SELECT ���(���� ��)�� INSERT �� ���� �ִ�.
INSERT INTO emp(empno, ename)
SELECT deptno, dname
FROM dept;

COMMIT;
SELECT *
FROM emp;

--UPDATE
--UPDATE ���̺� SET  �÷� = ��, �÷� = ��....
--WEHRE condition

SELECT *
FROM dept;

UPDATE dept SET dname = '���IT', loc='ym' --������Ʈ : ���� �����͸� ���״�� ������Ʈ �Ѵ�. WHERE �� �Ⱦ��� �Ǽ� ����.
                                                                          --                 �ѱ� �� �ڰ� 3byte. �뷮���� ���ڼ� ��������
WHERE deptno=99;


SELECT *
FROM emp;

--DELETE ���̺��
--WHERE condition

--�����ȣ�� 9999�� ������ emp���̺��� ����

DELETE emp
WHERE empno = 9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5��(4��)�� �����͸� ����
--10,20,30,40,99 --> empno < 100, Ȥ�� empno BETWEEN 10 AND 99 �̷��� �ؾ���.
DELETE emp
WHERE empno < 100;

SELECT*
FROM emp
WHERE empno < 100; --������� �ϴ� ������ �̸� Ȯ���غ��� �Ǽ� Ȯ���� �پ���� ^��^

ROLLBACK;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

SELECT *
FROM emp
WHERE empno BETWEEN 10 AND 99;

ROLLBACK;

DELETE emp
WHERE empno IN  (SELECT deptno 
                               FROM dept);

rollback;

SELECT *
FROM emp;

DELETE emp WHERE empno = 9999;
commit;

--LV1 --> LV3
SET TRANSACTION
isolation LEVEL SERIALIZABLE; --����Ŭ���� �������� �ٸ� DBMS���� �̷��� ������ ���Ƿ� �ߴٰ� ������ �� ��



SELECT *
FROM dept;

--DDL : AUTO COMMIT, rollback�� �ȵ�.
--CREATE
CREATE TABLE ranger_new(
        ranger_no NUMBER,   --Ÿ���� ���ڷ� ����.
        ranger_name VARCHAR2(50) ,--���� : [VARCHAR2](�������ĳ����. �Ϲ������� ���̾���) , CHAR(ĳ����. ������ ���� �����������)
        reg_dt DATE DEFAULT sysdate --DEFAUL : SYSDATE

);

desc ranger_new;
--DDL�� rollback�� ������� �ʴ´�.
rollback;


INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');

SELECT *
FROM ranger_new;

commit;

--��¥Ÿ�Կ��� Ư���ʵ尡������
--ex : sysdate ���� �⵵�� ��������
SELECT TO_CHAR(SYSDATE,'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, 
                TO_CHAR(reg_dt) mm,
                EXTRACT(MONTH FROM reg_dt) mm,
                EXTRACT(YEAR FROM reg_dt) year
FROM ranger_new;

--��������
--DEPT ����ؼ� DEPT_TEST �������.
CREATE TABLE dept_test(
        deptno number(2) PRIMARY KEY,  -- deptno �÷��� �ĺ��ڷ� ����.
        dname varchar2(14),                       -- �ĺ��ڷ� ������ �Ǹ� ���� �ߺ��� 
        loc varchar2(13)                              -- �� �� ����, null�ϼ�������.
);

desc dept_test;

--primary key ��������
--1. deptno �÷��� null�� �� �� ����
--2. deptno �÷��� �ߺ��� ���� �� �� ����.
desc dept_test;
INSERT INTO dept_test(deptno, dname, loc)
VALUES (null, 'ddit', 'daejeon');

INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');

rollback;

--����� ���� �������Ǹ��� �ο��� primary key
DROP TABLE dept_test;

CREATE TABLE dept_test(
            deptno NUMBER(2)  CONSTRAINT PK_DEPT_TEST PRIMARY KEY, --���������� �̸�
            dname VARCHAR2(14),
            loc VARCHAR2(13)
);

--TABLE CONSTRAINT
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST  PRIMARY KEY (deptno, dname)
    );

INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');

SELECT *
FROM dept_test;

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2)  PRIMARY KEY, 
        dname VARCHAR2(14)  NOT NULL,
        loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, null,'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2)  PRIMARY KEY, 
        dname VARCHAR2(14) UNIQUE,
        loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');
rollback























































