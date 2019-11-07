--emp ���̺��� �μ���ȣ(deptno)�� ����.
--emp ���̺��� �μ����� ��ȸ�ϱ� ���ؼ��� 
--dept ���̺�� ������ ���� �μ��� ��ȸ

--���ι��� �����
--ansi : ���̺�� JOIN ���̺��2  ON(���̺�.COL = ���̺�2.COL)
--          emp JOIN dept ON (emp.deptno = dept.deptno)
-- oracle : FROM ���̺�, ���̺�2, WHERE ���̺�.col = ���̺�2.col
--             FROM emp, dept WHERE emp.deptno = dept.deptno

--�����ȣ, �����, �μ���ȣ, �μ���
SELECT empno, ename, dept.deptno, dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--oracle
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno  =  dept.deptno;

--������ ����(�ǽ� join0_2) ppt 182p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno) -- �ش� ������ �����ֵ鳢�� ���.
WHERE emp.sal > 2500;

--������ ����(�ǽ� join0_3) ppt 183p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno) 
WHERE emp.sal > 2500 
      AND emp.empno >7600;

--������ ����(�ǽ� join0_) ppt 184p
SELECT empno, ename, sal, dept.deptno,dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno)
WHERE emp.sal > 2500 
      AND emp.empno >7600
      AND dname = 'RESEARCH';

--������ ����(base_table.sql �ǽ� join1) ppt 185p
--ansi��Ÿ��.
SELECT lprod_gu, lprod_nm, prod.prod_id, prod_name
FROM lprod JOIN prod ON(lprod.lprod_gu = prod.prod_lgu);

--������ ����(base_table.sql �ǽ� join2) ppt 186p
--ansi ��Ÿ��
SELECT buyer_id,  buyer_name,  prod.prod_id,  prod.prod_name
FROM buyer JOIN prod ON(buyer_id = prod_buyer);


--oracle ��Ÿ��
SELECT buyer_id,  buyer_name,  prod.prod_id,  prod.prod_name
FROM buyer, prod 
WHERE buyer.buyer_id = prod.prod_buyer;


--������ ����(base_table.sql �ǽ� join3) ppt 187p
--ORACLE ��Ÿ��
SELECT member.mem_id, member.mem_name,prod.prod_name, cart.cart_qty
FROM member,  prod, cart 
WHERE mem_id  =  cart_member
        AND cart_prod = prod_id;

--ansi ��Ÿ��
SELECT member.mem_id,  member.mem_name,  prod.prod_name,  cart.cart_qty
FROM member JOIN cart ON( member.mem_id  =  cart.cart_member) 
    JOIN prod ON(cart.cart_prod = prod.prod_id);
--member_id  =  cart_member =  prod_id 

--������ ����(�ǽ� join4) ppt 189p
--customer, cycle ���̺��� �����Ͽ� ���� ������ǰ, ��������, ������ ppt���̺������ ��ȸ�Ǵ� ���� �ۼ��ϱ�.
--���� : brown, sally
SELECT customer.cid,  cnm,  pid,  day,  cnt
FROM customer JOIN cycle ON(customer.cid=cycle.cid)
WHERE customer.cnm IN('brown', 'sally'); 

--������ ����(�ǽ� join5) ppt 190p
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


--��, ��ǰ�� �����Ǽ�(���ϰ������)
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


--�ǽ� join7 cycle�� product���̺����̿���
 SELECT  cycle.pid, product.pnm ,  SUM(cycle.cnt) cnt                     
 FROM cycle JOIN product ON(cycle.pid = product.pid)
GROUP BY cycle.pid, pnm;

--cycle_pid, cnt
--product_pid, pnm


















