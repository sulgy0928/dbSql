--�� �� �Ķ���Ͱ� �־����� ��, �ش� �� ���� �� ���� ���ϱ�.
--201911 --> 30 / 201912 --> 31

--�Ѵ� ���� ��, ���� ���� ���� = �� ��.
--������ ��¥�� ���� ��, DD�� �����ϴ� ����� ����.
SELECT :yyyymm as param,TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')), 'DD') day_count
FROM dual;

explain plan for
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY); 
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    37 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    37 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369) --�츮�� ������ ���ڿ��� �� 7369�� ���ڷ� �ν��� ���.


explain plan for
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    37 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    37 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369'); --�º��� ������������....

SELECT empno, ename, sal, TO_CHAR(sal, 'L000999,999.99') sal_fmt
FROM emp;

--function null
--nvl(coll, coll�� null�� ��� ��ü�� ��)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,
       sal + comm, sal + nvl(comm, 0),
       nvl(sal + comm, 0) --�̷���� �̹� ���� null�̵Ź���.
FROM emp;
    
--mvl2(coll, coll�� null�� �ƴ� ��� ǥ���Ǵ� ��, coll null�� ��� ǥ���Ǵ� ��)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 ������ null
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, exp3....)
--�Լ� ���� ��, null�� �ƴ� ù��° ����
SELECT empno, ename, sal, comm, coalesce(comm,sal)
FROM emp;

--null�ǽ� fn4 (ppt 137p)
SELECT empno, ename, mgr, 
        NVL(mgr ,9999) mgr_n,
        NVL2(mgr,mgr,9999) mgr_n,
        coalesce(mgr,9999) mgr_n2
FROM emp;

SELECT userid, usernm, reg_dt
FROM users;

--�ǽ�fn5(ppt 138p)
SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE)
FROM users;

--case when
SELECT empno, ename, job, sal,
        case
            when job = 'SALESMAN' then sal*1.05
            when job = 'MANAGER' then sal*1.10
            when job = 'PRESIDENT' then sal*1.20
            else sal
        end case_sal
FROM emp;

--decode(col, search1, return1, search2, return2..... default)
SELECT empno, ename, job, sal,
        DECODE
        (job, 'SALESMAN', sal*1.05,
        'MANAGER', sal*1.10,
        'PRESIDENT', sal*1.20, sal) decode_sal
                                    
FROM emp;

--condition �ǽ� cond1 (ppt 143p)
SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DDIT')DNAME
FROM emp;

--condition �ǽ� cond2 (ppt 144p)
SELECT  empno, ename, hiredate,
        case --case���� ,�� ������ �ȵ�.
            when MOD(TO_CHAR(hiredate, 'YY'),2)=0 then '�ǰ����� ������'
            when MOD(TO_CHAR(hiredate, 'YY'),2)=1  then '�ǰ����� �����'
        end contacttodoctor
FROM emp;

--�� ���. 
--���ش� ¦��?Ȧ��? �̰ź��� üũ.
--���� �⵵ ���ϱ�. (DATE --> TO_CHAR(DATE, FORMAT))
--���� �⵵�� ¦������ ���.
--� ���� 2�� ������ �������� �׻� 2���� �۴�.
--2�� ���� ���, �������� 0 �Ǵ� 1.
--MOD(���, ���� ��)
SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

-emp���̺��� �Ի����ڰ� Ȧ�������� ¦�������� Ȯ��.
SELECT empno, ename, hiredate, 
        case
            when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            then '�ǰ����� ���'
        else    '�ǰ����� ����'
        end contact_to_doctor
FROM emp;

--condition �ǽ� cond3 (ppt 145p)
SELECT userid, usernm, alias, reg_dt,
        case
            when MOD(TO_CHAR(SYSDATE, 'YYYY'),2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2)
            then '�ǰ����� ���'
            else '�ǰ����� ����'
        end contact_to_doctor
FROM users;


--�׷��Լ�( AVG, MAX, MIN, SUM, COUNT)
--�׷��Լ��� NULL���� ����󿡼� �����Ѵ�.
--SUM(comm), COUNT(*), COUNT(mgr)
--���� �� ���� ���� �޿��� �޴� ��� ��ȸ�ϱ�.
--�����߿��� ���� ���� �޿��� �޴� ��� ��ȸ.
--������ �޿����(�Ҽ��� ��°�ڸ������� ������. ��°�ڸ����� �ݿø�)
--������ �޿� ��ü ��
--������ ��
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--�μ��� ���� �����޿��� �޴� ����� �޿�
--GROUP BY ���� ����������� �÷��� SELECT���� ��� �� ��� ����.
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp
GROUP BY deptno;




SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

SELECT empno, ename, sal
FROM emp
ORDER BY sal;

--�μ��� �ִ�޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;

--�ǽ�grp1 ppt 159p
SELECT MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal),2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
FROM emp;
--GROUP BY deptno; 

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





