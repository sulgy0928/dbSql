-- GROUPING(cube, rollup ���� ���� �÷�)
--�ش� �÷��� �Ұ� ��꿡 ���� ���
--������ ���� ��� 0

--job �÷�
--case1. GROUPING (job) = 1 AND  GROUPING (deptno) = 1
--                                               job --> '�Ѱ�'
--case else
--                  job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND
                                        GROUPING(deptno) = 1 THEN '�Ѱ�'
                                       ELSE job
                        END job, deptno,
                         GROUPING (job), GROUPING (deptno), sum (sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);
                        
                        
SELECT job, deptno, 
            GROUPING (job), GROUPING (deptno), sum (sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

CASE WHEN GROUPING(job) = 0 AND
                        GROUPING(deptno) = 1 THEN job | | '�Ұ�'
                        ELSE TO_CHAR(deptno)
END deptno,
/*GROUPING (job), GROUPING (deptno), sum (sal) sal*/ sum(sal) sal
FROM emp


--GROUP BY
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno,job;

--CUBE(col, col2...)
--CUBE ���� ������ �÷��� ������ ��� ���տ� ���� ����׷����� ����.
--CUBE�� ������ �÷��� ���� ���⼺�� ����.(rollup���� ����)
--GROUP BY CUBE(job, deptno)
--00 : GROUP BY  job, detpno
--0X : GROUP BY  job
--X0 : GROUP BY deptno
--XX : GROUP BY  --��� ������

--GROUP BY CUBE(job, deptno,  mgr)
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);

SELECT deptno, MIN(ename), SUM(sal)
FROM emp
GROUP BY deptno;


--subquery�� ���� ������Ʈ
SELECT *
FROM emp_test;
DROP TABLE emp_test;

--emp���̺��� �����͸� �����ؼ� ��� �÷��� �̿��� emp_test ���̺�� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test ���̺��� dept ���̺��� �����ǰ��ִ� dname �÷���(VARCHAR2(14)) �߰�
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test ���̺��� dname �÷��� dept ���̺��� dname �÷� ������
--������Ʈ �ϴ� ���� �ۼ�.

UPDATE emp_test SET dname = (SELECT dname
                                                                FROM dept
                                                                WHERE dept.deptno = emp_test.deptno);
                                                                
commit;

DROP TABLE dept_test;

SELECT *
FROM dept_test;

--update �ǽ� sub_a1 // 42p
CREATE TABLE dept_test AS
SELECT *
FROM dept;
--empcnt(nuber(4)) �÷� �߰�.
ALTER TABLE dept_test ADD(empcnt NUMBER(4));

--subquery�� �̿��� update���� �ۼ��ϱ�.
UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                                                FROM emp
                                                                WHERE deptno = dept_test.deptno);


SELECT COUNT(*)
FROM emp
WHERE deptno = 20;


SELECT *
 FROM dept_test;
 INSERT INTO dept_test VALUES (98, 'it', 'daejeon', 0);
 INSERT INTO dept_test VALUES (99, 'it', 'daejeon', 0);
--44p 

DELETE dept_test  
WHERE NOT EXISTS (SELECT COUNT 'X'
                                                FROM emp
                                             WHERE emp.deptno = dept_deptno);


--45p

--�� ������ �޿��� 200�÷��ֱ⸦ ������Ʈ�ϴ� ���� �ۼ��ϱ�.
 SELECT *
 FROM emp_test;

SELECT  TRUNC(AVG(sal)) avg_sal
FROM  emp_test; --��ձ޿����ϱ� --2073

SELECT sal,ename
FROM emp_test
WHERE sal < 2073;  --��պ��� �����޿��޴� ���� ��ȸ

--�� ����
SELECT *
FROM emp_test a
AND sal < 
                        (SELECT AVG(sal)
                        FORM emp_test b
                        WHERE b.deptno = a.deptno);

UPDATE emp_test a SET sal = sal +200
WHERE sal < 
                        (SELECT AVG(sal)
                        FROM emp_test b
                        WHERE b.deptno = a.deptno);

--emp, emp_test empno �÷����� ���������� ��ȸ
--1. emp.empno, emp.ename, emp.sal, emp_test.sal
--2. emp.empno, emp.ename, emp.sal, emp_test.sal,
--      �ش� ���(emp���̺� ����)�� ���� �μ��� �޿����

SELECT emp.empno, emp.ename,  emp.sal, emp_test.sal, emp.deptno, AVG(emp.sal) sal_avg
FROM emp, emp_test;








