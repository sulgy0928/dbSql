SELECT ename, sal
, ROUND(sal/1000) sal_quotient
,MOD(sal, 1000) sal_reminder
FROM emp;

SELECT ename, hiredate
FROM emp
WHERE ename = 'SMITH';

SELECT TO_DATE('2019/12/31', 'YY/MM/DD') LASTDAY,
                TO_DATE('2019/12/31', 'YY/MM/DD') -5 LASTDAY_BEFORE5,
                SYSDATE NOW,
                (SYSDATE)-3 NOW_BEFORE3
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')dt_dash,
               TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') dt_dash_with_time,
                TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;



SELECT NVL(comm, 0) --(얘가 null이면, 얘로변경.)
FROM emp;

SELECT comm
FROM emp;

SELECT NVL2(comm, 0) --(얘가 null이면, 얘로, 아니면 얘로.)
FROM emp;
SELECT ename, sal, comm, sal,
            NVL2(comm, comm, sal+comm) sal_p_com
FROM emp;

SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

SELECT COALESCE(null, null, 'Hello', null, 'World')
FROM dual;

SELECT empno, ename, mgr,
            NVL(mgr, 9999) mgr_n,
            NVL2(mgr,mgr,9999) mgr_n_1,
            COALESCE(mgr,9999) mgr_n_2
FROM emp;

SELECT userid, usernm, reg_dt,
                NVL(reg_dt, SYSDATE) n_reg_dt
FROM users;

SELECT ename, job, sal,
        DECODE (job, 'SALESMAN', sal * 1.05,
                            'MANAGER', sal * 1.10,
                            'PRESIDENT', sal * 1.20,
                            sal * 1) bonus
FROM emp;

SELECT ename, job, sal,
            CASE
                    WHEN job = 'SALESMAN' THEN sal *1.05
                    WHEN job = 'MANAGER' THEN sal * 1.10
                    WHEN job = 'PRESIDENT' THEN sal*1.20
            ELSE sal * 1
            END bonus
FROM emp;

SELECT empno, ename,
            DECODE(deptno, 10, 'ACCOUNTING',
                                           20, 'RESEARCH',
                                           30, 'SALES',
                                           40, 'OPERATIONS',
                                           'DDIT')dname
FROM emp;           
                        
                        
SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DDIT')DNAME
FROM emp;        
                                           
SELECT empno, ename, hiredate
FROM emp;

SELECT empno, ename, hiredate, 
        case
            when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            then '건강검진 대상'
        else    '건강검진 비대상'
        end contact_to_doctor
FROM emp;



































