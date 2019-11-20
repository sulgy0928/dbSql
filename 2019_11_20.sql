-- GROUPING(cube, rollup 절의 사용된 컬럼)
--해당 컬럼이 소계 계산에 사용된 경우
--사용되지 않은 경우 0

--job 컬럼
--case1. GROUPING (job) = 1 AND  GROUPING (deptno) = 1
--                                               job --> '총계'
--case else
--                  job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND
                                        GROUPING(deptno) = 1 THEN '총계'
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
                        GROUPING(deptno) = 1 THEN job | | '소계'
                        ELSE TO_CHAR(deptno)
END deptno,
/*GROUPING (job), GROUPING (deptno), sum (sal) sal*/ sum(sal) sal
FROM emp


--GROUP BY
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno,job;

--CUBE(col, col2...)
--CUBE 절에 나열된 컬럼의 가능한 모든 조합에 대해 서브그룹으로 생성.
--CUBE에 나열된 컬럼에 대해 방향성은 없다.(rollup과의 차이)
--GROUP BY CUBE(job, deptno)
--00 : GROUP BY  job, detpno
--0X : GROUP BY  job
--X0 : GROUP BY deptno
--XX : GROUP BY  --모든 데이터

--GROUP BY CUBE(job, deptno,  mgr)
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);

SELECT deptno, MIN(ename), SUM(sal)
FROM emp
GROUP BY deptno;


--subquery를 통한 업데이트
SELECT *
FROM emp_test;
DROP TABLE emp_test;

--emp테이블의 데이터를 포함해서 모든 컬럼을 이용해 emp_test 테이블로 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test 테이블의 dept 테이블에서 관리되고있는 dname 컬럼을(VARCHAR2(14)) 추가
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test 테이블의 dname 컬럼을 dept 테이블의 dname 컬럼 값으로
--업데이트 하는 쿼리 작성.

UPDATE emp_test SET dname = (SELECT dname
                                                                FROM dept
                                                                WHERE dept.deptno = emp_test.deptno);
                                                                
commit;

DROP TABLE dept_test;

SELECT *
FROM dept_test;

--update 실습 sub_a1 // 42p
CREATE TABLE dept_test AS
SELECT *
FROM dept;
--empcnt(nuber(4)) 컬럼 추가.
ALTER TABLE dept_test ADD(empcnt NUMBER(4));

--subquery를 이용해 update쿼리 작성하기.
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

--그 직원의 급여를 200올려주기를 업데이트하는 쿼리 작성하기.
 SELECT *
 FROM emp_test;

SELECT  TRUNC(AVG(sal)) avg_sal
FROM  emp_test; --평균급여구하기 --2073

SELECT sal,ename
FROM emp_test
WHERE sal < 2073;  --평균보다 작은급여받는 직원 조회

--쌤 설명
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

--emp, emp_test empno 컬럼으로 같은값끼리 조회
--1. emp.empno, emp.ename, emp.sal, emp_test.sal
--2. emp.empno, emp.ename, emp.sal, emp_test.sal,
--      해당 사원(emp테이블 기준)이 속한 부서의 급여평균

SELECT emp.empno, emp.ename,  emp.sal, emp_test.sal, emp.deptno, AVG(emp.sal) sal_avg
FROM emp, emp_test;








