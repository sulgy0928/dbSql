SELECT ename, sal, deptno, 
                RANK() OVER (PARTITION BY deptno ORDER BY sal) rank,
                DENSE_RANK () OVER (PARTITION BY deptno ORDER BY sal)  d_rank,
                ROW_NUMBER () OVER (PARTITION BY deptno ORDER BY sal) rown
FROM emp; --partition by deptno : 같은부서번호를 같은 row로 묶는다. 


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

--분석함수를 통한 부서별 직원수  (COUNT)
SELECT ename, empno, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;


--부서별 사원의 급여합계
--SUM 분석함수
SELECT ename, empno, deptno, sal,
                SUM(sal) OVER (PARTITION BY deptno) sum_sal
FROM emp;

--109p 실습 ana2
SELECT empno, ename, sal, deptno,
                ROUND(AVG(sal) OVER (PARTITION BY deptno) ,2)avg_sal--부서별 급여 평균 소숫점두자리까지.
FROM emp;

--110p 실습 ana3
--부서별 사원번호가 가장 빠른사람
--부서별 사원번호가 가장 느린사람

SELECT empno, ename, deptno,
                FIRST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) f_emp,
                LAST_VALUE(empno) OVER (PARTITION BY deptno ORDER BY empno) l_emp
FROM emp;

--LAG(이전행)
--현재행
--LEAD (다음행)
--급여가 높은순으로 정렬했을때 자기보다 한단계 급여가 낮은사람의 급여,
--                                                       자기보다 한단계 급여가 높은사람의 급여

SELECT empno, ename, sal, LAG(sal) OVER(ORDER BY sal) lag_sal,
                LEAD(sal)  OVER(ORDER BY sal) lead_sal
FROM emp;

--115 실습 ana5

--118p 실습 no_ana3


--WINDOWING
--UNBOUNDED PRECEDING : 현재 행 기준으로 선행하는 모든 행
--CURRENT ROW : 현재행
--UNBOUNDED FOLLOWING : 현재 행을 기준으로 후행하는 모든 행.
--N(정수) PRECEDING : 현재 행을 기준으로 선행하는 N개의 행.
--N(정수) FOLLOWING : 현재 행을 기준으로 후행하는 N개의 행.

SELECT empno, ename, sal,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_sal,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) sum_sal2,
                SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sum_sal3
FROM emp;

--126p 실습 ana7


SELECT empno, ename, deptno, sal, SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)row_sum,
SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING)row_sum2,

SUM(sal) OVER (ORDER BY sal RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)ran_sum,
SUM(sal) OVER (ORDER BY sal RANGE UNBOUNDED PRECEDING) ran_sum2
FROM emp;









