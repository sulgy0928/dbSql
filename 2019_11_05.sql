--년 월 파라미터가 주어졌을 때, 해당 년 월의 일 수를 구하기.
--201911 --> 30 / 201912 --> 31

--한달 더한 후, 원래 값을 빼면 = 일 수.
--마지막 날짜를 구한 후, DD만 추출하는 방법도 있음.
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
 
   1 - filter("EMPNO"=7369) --우리가 위에서 문자열로 준 7369를 숫자로 인식한 모습.


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
 
   1 - filter(TO_CHAR("EMPNO")='7369'); --좌변을 가공하지말라....

SELECT empno, ename, sal, TO_CHAR(sal, 'L000999,999.99') sal_fmt
FROM emp;

--function null
--nvl(coll, coll이 null일 경우 대체할 값)
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,
       sal + comm, sal + nvl(comm, 0),
       nvl(sal + comm, 0) --이런경우 이미 값이 null이돼버림.
FROM emp;
    
--mvl2(coll, coll이 null이 아닐 경우 표현되는 값, coll null일 경우 표현되는 값)
SELECT empno, ename, sal, comm, NVL2(comm, comm, 0) + sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 같으면 null
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--COALESCE(expr1, expr2, exp3....)
--함수 인자 중, null이 아닌 첫번째 인자
SELECT empno, ename, sal, comm, coalesce(comm,sal)
FROM emp;

--null실습 fn4 (ppt 137p)
SELECT empno, ename, mgr, 
        NVL(mgr ,9999) mgr_n,
        NVL2(mgr,mgr,9999) mgr_n,
        coalesce(mgr,9999) mgr_n2
FROM emp;

SELECT userid, usernm, reg_dt
FROM users;

--실습fn5(ppt 138p)
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

--condition 실습 cond1 (ppt 143p)
SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 
                20, 'RESEARCH',
                30, 'SALES',
                40, 'OPERATIONS',
                'DDIT')DNAME
FROM emp;

--condition 실습 cond2 (ppt 144p)
SELECT  empno, ename, hiredate,
        case --case문은 ,가 있으면 안됨.
            when MOD(TO_CHAR(hiredate, 'YY'),2)=0 then '건강검진 비대상자'
            when MOD(TO_CHAR(hiredate, 'YY'),2)=1  then '건강검진 대상자'
        end contacttodoctor
FROM emp;

--쌤 답안. 
--올해는 짝수?홀수? 이거부터 체크.
--올해 년도 구하기. (DATE --> TO_CHAR(DATE, FORMAT))
--올해 년도가 짝수인지 계산.
--어떤 수를 2로 나누면 나머지는 항상 2보다 작다.
--2로 나눌 경우, 나머지는 0 또는 1.
--MOD(대상, 나눌 값)
SELECT MOD(TO_CHAR(SYSDATE, 'YYYY'), 2)
FROM dual;

-emp테이블에서 입사일자가 홀수년인지 짝수년인지 확인.
SELECT empno, ename, hiredate, 
        case
            when MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2)
            then '건강검진 대상'
        else    '건강검진 비대상'
        end contact_to_doctor
FROM emp;

--condition 실습 cond3 (ppt 145p)
SELECT userid, usernm, alias, reg_dt,
        case
            when MOD(TO_CHAR(SYSDATE, 'YYYY'),2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2)
            then '건강검진 대상'
            else '건강검진 비대상'
        end contact_to_doctor
FROM users;


--그룹함수( AVG, MAX, MIN, SUM, COUNT)
--그룹함수는 NULL값을 계산대상에서 제외한다.
--SUM(comm), COUNT(*), COUNT(mgr)
--직원 중 가장 높은 급여를 받는 사람 조회하기.
--직원중에서 가장 낮은 급여를 받는 사람 조회.
--직원의 급여평균(소숫점 둘째자리까지만 나오게. 셋째자리에서 반올림)
--직원의 급여 전체 합
--직원의 수
SELECT MAX(sal) max_sal, MIN(sal) min_sal,
       ROUND(AVG(sal), 2) avg_sal,
       SUM(sal) sum_sal,
       COUNT(*) emp_cnt,
       COUNT(sal) sal_cnt,
       COUNT(mgr) mgr_cnt,
       SUM(comm) comm_sum
FROM emp;

--부서별 가장 높은급여를 받는 사람의 급여
--GROUP BY 절에 기술되지않은 컬럼이 SELECT절에 기술 될 경우 에러.
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

--부서별 최대급여
SELECT deptno, MAX(sal) max_sal
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





