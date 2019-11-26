SELECT ename, sal, deptno, 
                RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
                DENSE_RANK () OVER (PARTITION BY deptno ORDER BY sal)  d_rank,
                ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp; --partition by deptno : �����μ���ȣ�� ���� row�� ���´�. 


--105p
SELECT empno, ename, sal, deptno, 
                RANK() OVER (ORDER BY sal DESC, empno) rank,
                DENSE_RANK () OVER (ORDER BY sal DESC, empno)  d_rank,
                ROW_NUMBER () OVER (ORDER BY sal DESC, empno) rown
FROM emp;

--106p no_ana2
SELECT ename, empno, emp.deptno, b.cnt
FROM emp, (deptno, COUNT(*)

GROUP BY deptno;

--�м��Լ��� ���� �μ��� ������  (COUNT)
SELECT ename, empno, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;


--�μ��� ����� �޿��հ�
--SUM �м��Լ�
SELECT ename, empno, deptno, sal,
                SUM(sal) OVER (PARTITION BY deptno) sum_sal
FROM emp;

--109p �ǽ� ana2
SELECT empno, ename, sal, deptno,
                ROUND(AVG(sal) OVER (PARTITION BY deptno) ,2)avg_sal--�μ��� �޿� ��� �Ҽ������ڸ�����.
FROM emp;

--110p �ǽ� ana3
--�μ��� �����ȣ�� ���� �������
--�μ��� �����ȣ�� ���� �������

SELECT empno, ename, deptno,
                FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) f_emp,
                LAST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) l_emp
FROM emp;

--LAG(������)
--������
--LEAD (������)
--�޿��� ���������� ���������� �ڱ⺸�� �Ѵܰ� �޿��� ��������� �޿�,
--                                                       �ڱ⺸�� �Ѵܰ� �޿��� ��������� �޿�

SELECT empno, ename, sal, LAG(sal) OVER(ORDER BY sal) lag_sal,
                LEAD(sal)  OVER(ORDER BY sal) lead_sal
FROM emp;

--115 �ǽ� ana5

--118p �ǽ� no_ana3


--WINDOWING
--UNBOUNDED PRECEDING : ���� �� �������� �����ϴ� ��� ��
--CURRENT ROW : ������
--UNBOUNDED FOLLOWING : ���� ���� �������� �����ϴ� ��� ��.
--N(����) PRECEDING : ���� ���� �������� �����ϴ� N���� ��.
--N(����) FOLLOWING : ���� ���� �������� �����ϴ� N���� ��.

SELECT empno, ename, sal,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) sum_sal2,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sum_sal3
FROM emp;

--126p �ǽ� ana7


SELECT empno, ename, deptno, sal, SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)row_sum,
SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING)row_sum2,

SUM(sal) OVER (ORDER BY sal RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)ran_sum,
SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) ran_sum2
FROM emp;









