--emp 테이블에는 부서번호(deptno)만 존재.
--emp 테이블에서 부서명을 조회하기 위해서는 
--dept 테이블과 조인을 통해 부서명 조회

--조인문법 생김새
--ansi : 테이블명 JOIN 테이블명2  ON(테이블.COL = 테이블2.COL)
--          emp JOIN dept ON (emp.deptno = dept.deptno)
-- oracle : FROM 테이블, 테이블2, WHERE 테이블.col = 테이블2.col
--             FROM emp, dept WHERE emp.deptno = dept.deptno

--사원번호, 사원명, 부서번호, 부서명
SELECT empno, ename, dept.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno  =  dept.deptno;

--데이터 결합(실습 join0_2) ppt 182p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno) -- 해당 내역이 같은애들끼리 출력.
WHERE emp.sal > 2500;

--데이터 결합(실습 join0_3) ppt 183p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno) 
WHERE emp.sal > 2500 
      AND emp.empno >7600;

--데이터 결합(실습 join0_) ppt 184p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500 
      AND emp.empno >7600
      AND dname = 'RESEARCH';

--데이터 결합(base_table.sql 실습 join1) ppt 185p
--ansi스타일.
SELECT lprod_gu, lprod_nm, prod.prod_id, prod_name
FROM lprod JOIN prod ON(lprod.lprod_gu = prod.prod_lgu);

--데이터 결합(base_table.sql 실습 join2) ppt 186p
--ansi 스타일
SELECT buyer_id,  buyer_name,  prod.prod_id,  prod.prod_name
FROM buyer JOIN prod ON(buyer_id = prod_buyer);


--oracle 스타일
SELECT buyer_id,  buyer_name,  prod.prod_id,  prod.prod_name
FROM buyer, prod 
WHERE buyer.buyer_id = prod.prod_buyer;


--데이터 결합(base_table.sql 실습 join3) ppt 187p
--ORACLE 스타일
SELECT member.mem_id, member.mem_name,prod.prod_name, cart.cart_qty
FROM member,  prod, cart 
WHERE mem_id  =  cart_member
        AND cart_prod = prod_id;

--ansi 스타일
SELECT member.mem_id,  member.mem_name,  prod.prod_name,  cart.cart_qty
FROM member JOIN cart ON( member.mem_id  =  cart.cart_member) 
    JOIN prod ON(cart.cart_prod = prod.prod_id);
--member_id  =  cart_member =  prod_id 

--데이터 결합(실습 join4) ppt 189p
--customer, cycle 테이블을 조인하여 고객별 애음제품, 애음요일, 개수를 ppt테이블과같이 조회되는 쿼리 작성하기.
--고객명 : brown, sally
SELECT customer.cid,  cnm,  pid,  day,  cnt
FROM customer JOIN cycle ON(customer.cid=cycle.cid)
WHERE customer.cnm IN('brown', 'sally'); 

--데이터 결합(실습 join5) ppt 190p
SELECT customer_cid,  customer_nm,  cycle_pid,  product_pnm,  cycle_day,  cycle_cnt
FROM customer JOIN cycle ON()
WHERE ;


SELECT customer.cid,  cnm,  cycle.pid, pnm, day,  cnt
FROM customer JOIN cycle ON(customer.cid=cycle.cid)
 JOIN product ON(cycle.pid = product.pid)
WHERE customer.cnm IN('brown', 'sally'); 

--customer_cid,  customer_nm,  cycle_pid,  product_pnm,  cycle_day,  cycle_cnt


--JOIN6  ppt 191p
SELECT customer.cid,  cnm,  cycle.pid, pnm, sum(cnt) cnt
FROM customer, cycle, product
 WHERE customer.cid = cycle.cid
      AND       cycle.pid = product.pid
 GROUP BY customer.cid, cnm, cycle.pid, pnm;


--고객, 제품별 애음건수(요일관계없이)
with cycle_groupby as (
    SELECT cid, pid, SUM(cnt) cnt
    FROM cycle
    GROUP BY cid, pid)
SELECT customer.cid, cnm, product.pid, pnm, cnt
FROM cycle_groupby, customer, product
WHERE cycle_groupby.cid = customer.cid
AND cycle_groupby.pid = product.pid;


SELECT  * 
FROM 
(SELECT cid, pid, SUM(cnt)
FROM cycle
GROUP BY cid, pid);

--customer_cid,  customer_nm,  cycle_pid,  product_pnm,  cycle_day,  cycle_cnt


--실습 join7 cycle과 product테이블을이용해
 SELECT  cycle.pid, product.pnm ,  SUM(cycle.cnt) cnt                     
 FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

--cycle_pid, cnt
--product_pid, pnm


















