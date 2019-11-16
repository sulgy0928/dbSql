SELECT TO_CHAR(hiredate,'YYYYMM') hiredate_yyyymm,count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

SELECT DISTINCT TO_CHAR(hiredate,'YYYYMM') hiredate_yyyymm,count(*) cnt
FROM emp
GROUP BY  TO_CHAR(hiredate, 'YYYYMM');

SELECT 
            TO_CHAR(hiredate, 'YYYY') hiredate_yyyy, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');




SELECT *
FROM emp
ORDER BY empno;

SELECT COUNT(deptno) cnt
FROM dept;

SELECT dept.dname, emp.ename, emp.job
FROM emp NATURAL JOIN dept;

--oracle식 지원형식
SELECT dept.dname, emp.ename, emp.job
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT b.dname, a.ename, a.job
FROM emp a, dept b
WHERE a.deptno = b.deptno;

SELECT dept.dname, emp.ename, emp.job
FROM emp JOIN dept USING (deptno);

SELECT dept.dname, emp.ename, emp.job
FROM emp, dept
WHERE emp.deptno = dept.deptno;


SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--실습(JOIN 0) ppt 180p
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ); 

SELECT *
FROM emp; --empno, ename, job, mgr, hiredate, sal, comm, deptno

SELECT *
FROM dept; --deptno, dname, loc

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno IN (10, 30);

SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno ) 
WHERE emp.deptno = 10
           OR emp.deptno = 30;        

SELECT emp.empno, emp.ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE sal > 2500;

--183p
SELECT emp.empno, emp.ename, sal, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE sal > 2500
        AND empno > 7600;






























