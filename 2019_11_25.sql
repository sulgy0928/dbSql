--member���̺��� �̿��� member2 ���̺��� ����
--������ ȸ��(mem_id = 'a001') �� ����(mem_job)�� '����'���� ���� �� commit�ϰ� ��ȸ.

CREATE TABLE member2 AS
SELECT *
FROM member;

UPDATE member2 SET mem_job = '����'
WHERE mem_id = 'a001';
commit;

SELECT  mem_id,  mem_name,  mem_job 
FROM member2
WHERE mem_id = 'a001';


--��ǰ�� ��ǰ���� ���� (BUY_QTY) �հ�, ��ǰ���űݾ�(BUY_COST) �հ�
--��ǰ�ڵ�, ��ǰ��, �����հ�, �ݾ��հ�
SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod;


--��ǰ�ڵ�, ��ǰ��, �����հ�, �ݾ��հ�
SELECT buy_prod, b.prod_name,  sum_qty, sum_cost
FROM
(SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod) a, prod b
WHERE a.buy_prod = b.prod_id;

--view ����
CREATE OR REPLACE VIEW VW_PROD_BUY AS 
SELECT buy_prod, b.prod_name,  sum_qty, sum_cost
FROM
(SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod) a, prod b
WHERE a.buy_prod = b.prod_id;


SELECT *
FROM USER_VIEWS;

--�ڡ١ڡ�õ������ �����濬�ڡ١ڡ� (�ܹ��� ��)
--98p �м��Լ�(window�Լ�) �����ǽ�. (ana0)
--emp���̺��� ����ؼ� ����� �μ��� �޿�(sal)�� ���� ���ϱ�.

--�켱 �μ��� ��ŷ
SELECT a.ename, a.sal, a.deptno, b.rn
FROM
    (SELECT a.ename, a.sal, a.deptno, ROWNUM j_rn
     FROM
    (SELECT ename, sal, deptno
     FROM emp
     ORDER BY deptno, sal DESC) a ) a, 
(SELECT b.rn, ROWNUM j_rn
FROM 
(SELECT a.deptno, b.rn 
 FROM
    (SELECT deptno, COUNT(*) cnt --3, 5, 6
     FROM emp
     GROUP BY deptno )a,
    (SELECT ROWNUM rn --1~14
     FROM emp) b
WHERE  a.cnt >= b.rn
ORDER BY a.deptno, b.rn ) b ) b
WHERE a.j_rn = b.j_rn;


SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC)  rank
FROM emp; -- ���� ���� ����� ������ ���� ����. ������ ��� ���ɿ� ������ �־� �ʹ� �����ϸ� �ȵ�..























