--����(�ǽ� where11��)
--job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6��1�� ������ �������� ��ȸ�ϱ�.
-- ~�̰ų� --> OR
--1981�� 6��1�� ���� --> �ش� �� ����

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');
    
desc emp;
--TO_CHAR : DATEŸ���� ���ڿ��� ��ȯ.
--��¥�� ���ڿ��� ��ȯ�ÿ� ����(���� ����)�� �����������

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
        TO_CHAR(SYSDATE +5, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3
FROM dual;

--fn2
SELECT 
        TO_CHAR(SYSDATE,'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE,'DD-MM-YYYY') DT_DD_MM_YYYY    
FROM dual;


SELECT ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'), 5),
       ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'),-5)
FROM dual;


SELECT ROWNUM, a.*
    FROM(SELECT e.*
    FROM emp e
    ORDER BY ename)a;

--�� �� �Ķ���Ͱ� �־����� �� �ش� �� ���� �� �� ���ϱ�.


desc emp;

SELECT empno, ename, sal, comm, coalesce(comm,sal)
FROM emp;

SELECT empno, ename, job, sal, 
             case 
                    when job = 'SALESMAN' then sal *1.05
                    when job = 'MANAGER' then sal *1.10
                    when job = 'PRESIDENT' then sal *1.20
                    else sal
             end case_sal
FROM emp;

SELECT userid, usernm, reg_dt,
            NVL(reg_dt, SYSDATE) n_reg_dt
FROM users;

SELECT empno,ename,
               DECODE( deptno, 10, 'ACCOUNTING',
                                  20,  'RESEARCH',
                                 30, 'SALES',
                                40, 'OPERATIONS','DDIT')dname
FROM emp;

SELECT empno, ename, hiredate, 
        case
                    when MOD(TO_CHAR(hiredate,'YY'),2)=0  then'�ǰ����� ������'
                    when MOD(TO_CHAR(hiredate,'YY'),2)=1 then '�ǰ����� �����'
        end see_a_doctor
FROM emp;

SELECT userid, usernm,alias, reg_dt,
                case
                            when MOD(TO_CHAR(reg_dt,'YY'),2)=0 then '�ǰ����� ������'
                            when MOD(TO_CHAR(reg_dt,'YY'),2)=1 then '�ǰ����� �����'
                end
FROM users;

--�׷��Լ�( AVG, MAX, MIN, SUM, COUNT)
--�׷��Լ��� NULL���� ����󿡼� �����Ѵ�.
--SUM(comm), COUNT(*), COUNT(mgr)
--���� �� ���� ���� �޿��� �޴� ��� ��ȸ�ϱ�.
--�����߿��� ���� ���� �޿��� �޴� ��� ��ȸ.
--������ �޿����(�Ҽ��� ��°�ڸ������� ������. ��°�ڸ����� �ݿø�)
--������ �޿� ��ü ��
--������ ��

--�μ��� �ִ�޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;

SELECT deptno, MAX(sal)max_sal
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

SELECT MAX(sal) max_sal,
              MIN(sal),
              ROUND(AVG(sal),2),
              SUM(sal),
              COUNT(sal),
              COUNT(mgr),
              COUNT(*)
FROM emp;
    
              
              













































