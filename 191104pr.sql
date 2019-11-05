--복습(실습 where11번)
--job이 SALESMAN이거나 입사일자가 1981년 6월1일 이후인 직원정보 조회하기.
-- ~이거나 --> OR
--1981년 6월1일 이후 --> 해당 일 포함

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');
    
desc emp;
--TO_CHAR : DATE타입을 문자열로 변환.
--날짜를 문자열로 변환시에 포맷(쿼리 형태)을 지정해줘야함

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

--년 월 파라미터가 주어졌을 때 해당 년 월의 일 수 구하기.


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
                    when MOD(TO_CHAR(hiredate,'YY'),2)=0  then'건강검진 비대상자'
                    when MOD(TO_CHAR(hiredate,'YY'),2)=1 then '건강검진 대상자'
        end see_a_doctor
FROM emp;

SELECT userid, usernm,alias, reg_dt,
                case
                            when MOD(TO_CHAR(reg_dt,'YY'),2)=0 then '건강검진 비대상자'
                            when MOD(TO_CHAR(reg_dt,'YY'),2)=1 then '건강검진 대상자'
                end
FROM users;

--그룹함수( AVG, MAX, MIN, SUM, COUNT)
--그룹함수는 NULL값을 계산대상에서 제외한다.
--SUM(comm), COUNT(*), COUNT(mgr)
--직원 중 가장 높은 급여를 받는 사람 조회하기.
--직원중에서 가장 낮은 급여를 받는 사람 조회.
--직원의 급여평균(소숫점 둘째자리까지만 나오게. 셋째자리에서 반올림)
--직원의 급여 전체 합
--직원의 수

--부서별 최대급여
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;

SELECT deptno, MAX(sal)max_sal
FROM emp
GROUP BY deptno
HAVING MAX(sal) > 3000;

--실습grp1 ppt 159p
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
    
              
              













































