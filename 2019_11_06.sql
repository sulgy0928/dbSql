--그룹함수
--multi row function : 여러개의 행을 입력으로 하나의 결과 행을 생성
--SUM, MAX, MIN, AVG, COUNT
--GRUOP BY col  |  express
--SELECT 절에는 GROUP BY 절에 기술된 COL, EXPRESS 표기 가능

--직원 중 가장 높은 급여를 조회하기.
-- 14개의 행이 입력으로 들어가 하나의 결과가 도출
SELECT MAX(sal) max_sal
FROM emp;

--부서별로 가장 높은 급여 조회
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
                'DDIT'); --이부분에 deptno만써도 됨.

--실습grp4 - ppt 162p
SELECT 
                TO_CHAR (hiredate,'YYYYMM')  hiredate_yyyymm, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

--실습grp5 163p
SELECT 
            TO_CHAR(hiredate, 'YYYY') hiredate_yyyy, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

--실습grp6 164p
SELECT COUNT(deptno) cnt
FROM dept;

SELECT distinct  deptno
FROM emp; --해당컬럼이 중복제거해서 보는 키워드.

--JOIN
--emp 테이블에는 dname컬럼이 없다. --> 부서번호(deptno)밖에 없음
desc emp;

--emp테이블에 부서 이름을 저장 할 수 있는 dname컬럼 추가.
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

--ansi natural join :  테이블의 컬럼명이 같은 컬럼을 기준으로 JOIN하는것.
SELECT  deptno, ename, dname
FROM emp NATURAL JOIN dept;

--ORACLE JOIN
SELECT  e.empno, e.ename, e.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;


--ANSI JOING WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from절에 조인 대상 테이블 나열.
--where절에 조인 조건 기술.
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
    AND emp.job = 'SALESMAN'; --job이 SALES 인 사람만 조회하기.
    --AND WHERE절의 위치를 바꿔도 상관이 없음. 그런부분의 순서는 신경쓰지않음.
    
--JOIN with ON(개발자가 조인 컬럼을 on절에 직접 기술)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno  =  dept.deptno);    


SELECT emp.empno, emp.ename, dept.dname
FROM  emp, dept
WHERE emp.deptno  =  dept.deptno;  

--SELF join : 같은 테이블끼리 조인
--emp테이블의 mgr정보를 참고하기 위해 emp테이블과 조인을 해야한다.
--a : 직원정보, b : 관리자
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b. empno)
WHERE a.empno between 7369 AND 7698;

--oracle문법으로 바꾸기.
SELECT a.emp, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b. empno
      AND  a.empno BETWEEN 7369 AND 7698;

--non-equi joing(등식조인이 아닌경우)
SELECT *
FROM SALGRADE;

--직원의 급여 등급은?
SELECT *
FROM emp;

--ORACLE문법
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--JOIN문법
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

--실습(JOIN 0) ppt 180p
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ); 

--실습(JOIN 0_1) ppt 181p

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ) 
WHERE emp.deptno = 10
           OR emp.deptno = 30;











