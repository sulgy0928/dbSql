--�׷��Լ�
--multi row function : �������� ���� �Է����� �ϳ��� ��� ���� ����
--SUM, MAX, MIN, AVG, COUNT
--GRUOP BY col  |  express
--SELECT ������ GROUP BY ���� ����� COL, EXPRESS ǥ�� ����

--���� �� ���� ���� �޿��� ��ȸ�ϱ�.
-- 14���� ���� �Է����� �� �ϳ��� ����� ����
SELECT MAX(sal) max_sal
FROM emp;

--�μ����� ���� ���� �޿� ��ȸ
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;


--grp2 ppt 160p
SELECT deptno,MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp
GROUP BY deptno;

--grp3 ppt 161p
SELECT  DECODE(deptno, 10, 'ACCOUNTING', 
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DDIT') dname,
                MAX(sal)max_sal,
                            MIN(sal) min_sal,
                            ROUND(AVG(sal),2) avg_sal,
                            SUM(sal) sum_sal,
                            COUNT(sal) count_sal,
                            COUNT(mgr) count_mgr,
                            COUNT(*) count_all
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING', 
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DDIT'); --�̺κп� deptno���ᵵ ��.

--�ǽ�grp4 - ppt 162p
SELECT 
                TO_CHAR (hiredate,'YYYYMM')  hiredate_yyyymm, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

--�ǽ�grp5 163p
SELECT 
            TO_CHAR(hiredate, 'YYYY') hiredate_yyyy, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

--�ǽ�grp6 164p
SELECT COUNT(deptno) cnt
FROM dept;

SELECT distinct  deptno
FROM emp; --�ش��÷��� �ߺ������ؼ� ���� Ű����.

--JOIN
--emp ���̺��� dname�÷��� ����. --> �μ���ȣ(deptno)�ۿ� ����
desc emp;

--emp���̺� �μ� �̸��� ���� �� �� �ִ� dname�÷� �߰�.
ALTER TABLE emp ADD (dname VARCHAR2(14));

SELECT *
FROM emp;

UPDATE emp SET dname = 'ACCOUNTING'  WHERE DEPTNO=10;
UPDATE emp SET dname = 'RESEARCH'  WHERE DEPTNO=20;
UPDATE emp SET dname = 'SALES'  WHERE DEPTNO=30;
COMMIT;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

ALTER TABLE emp DROP COLUMN DNAME;

SELECT *
FROM emp;

--ansi natural join :  ���̺��� �÷����� ���� �÷��� �������� JOIN�ϴ°�.
SELECT  deptno, ename, dname
FROM emp NATURAL JOIN dept;

--ORACLE JOIN
SELECT  e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;


--ANSI JOING WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from���� ���� ��� ���̺� ����.
--where���� ���� ���� ���.
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND emp.job = 'SALESMAN'; --job�� SALES �� ����� ��ȸ�ϱ�.
    --AND WHERE���� ��ġ�� �ٲ㵵 ����� ����. �׷��κ��� ������ �Ű澲������.
    
--JOIN with ON(�����ڰ� ���� �÷��� on���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno  =  dept.deptno);    


SELECT emp.empno, emp.ename, dept.dname
FROM  emp, dept
WHERE emp.deptno  =  dept.deptno;  

--SELF join : ���� ���̺��� ����
--emp���̺��� mgr������ �����ϱ� ���� emp���̺�� ������ �ؾ��Ѵ�.
--a : ��������, b : ������
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b. empno)
WHERE a.empno between 7369 AND 7698;

--oracle�������� �ٲٱ�.
SELECT a.emp, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b. empno
      AND  a.empno BETWEEN 7369 AND 7698;

--non-equi joing(��������� �ƴѰ��)
SELECT *
FROM SALGRADE;

--������ �޿� �����?
SELECT *
FROM emp;

--ORACLE����
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--JOIN����
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

--�ǽ�(JOIN 0) ppt 180p
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ); 

--�ǽ�(JOIN 0_1) ppt 181p

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ) 
WHERE emp.deptno = 10
           OR emp.deptno = 30;











