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

--184p
SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno  = dept.deptno)
WHERE sal > 2500
    AND dname = 'RESEARCH'; 

--185p
SELECT lprod_gu, lprod_nm, prod_id, prod.prod_name
FROM lprod JOIN prod ON(lprod.lprod_gu = prod.prod_lgu);

SELECT *
FROM buyer; --buyer_id,buyer_name, buyer_gu 

SELECT *
FROM prod; --prod_id, prod_name

--186p  JOIN문 실습
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer JOIN prod ON (buyer_id = prod_buyer);

--187p
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON (mem_id = cart_member)
        JOIN prod ON(prod_id = cart_prod);
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON (mem_id = cart_member)
        JOIN prod ON(prod_id = cart_prod);
SELECT *
FROM cart;

--189p
SELECT customer.cid, customer.cnm, pid, day, cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
AND customer.cid < 3;

--190P
SELECT customer.cid, customer.cnm, product.pid, product.pnm,cycle.day, cycle.cnt
FROM cycle JOIN  product ON (cycle.pid = product.pid) 
 JOIN customer ON(customer.cid = cycle.cid) 
    AND customer.cnm IN('brown', 'sally');

SELECT *
FROM product; --제품. pid품번, pnm품명

SELECT *
FROM cycle; --애음주기. cid고객번호, pid품번, day요일, cnt수량

SELECT *
FROM customer; --고객. cid고객번호, cnm고객명


--cycle의 cid, + product의 pid, pnm  

--191p
SELECT customer.cid, cnm, cycle.pid, pnm, sum(cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
        AND cycle.pid = product.pid
GROUP BY customer.cid, cnm, cycle.pid, pnm;

SELECT cycle.pid,product.pnm, sum(cycle.cnt)cnt
FROM cycle JOIN product ON (cycle.pid = product.pid)
GROUP BY cycle.pid, product.pnm;

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT  cycle.pid, product.pnm ,  SUM(cycle.cnt) cnt                     
 FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

--194p
SELECT *--region_id, region_name, country_name
FROM countries, regions;


SELECT deptno --20
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;



--SALES
SELECT *
FROM emp 
WHERE sal > (SELECT AVG(sal)
                               FROM emp);

SELECT *
FROM emp
WHERE sal > 
                        (SELECT AVG(sal)
                        FROM emp);

SELECT *
FROM emp
 WHERE deptno IN(SELECT deptno
                                FROM emp
                                WHERE ename IN('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                                 FROM emp
                                 WHERE ename IN('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                                        FROM emp
                                        WHERE ename = 'SMITH'
                                                OR ename = 'WARD');
                                                
                                                
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                                                FROM emp);

SELECT deptno, ROUND(AVG(sal),2) avg_sal
FROM emp
GROUP BY deptno;














