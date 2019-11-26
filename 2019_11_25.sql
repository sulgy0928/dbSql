--member테이블을 이요해 member2 테이블을 생성
--김은대 회원(mem_id = 'a001') 의 직업(mem_job)을 '군인'으로 변경 후 commit하고 조회.

CREATE TABLE member2 AS
SELECT *
FROM member;

UPDATE member2 SET mem_job = '군인'
WHERE mem_id = 'a001';
commit;

SELECT  mem_id,  mem_name,  mem_job 
FROM member2
WHERE mem_id = 'a001';


--제품별 제품구매 수량 (BUY_QTY) 합계, 제품구매금액(BUY_COST) 합계
--제품코드, 제품명, 수량합계, 금액합계
SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod;


--제품코드, 제품명, 수량합계, 금액합계
SELECT buy_prod, b.prod_name,  sum_qty, sum_cost
FROM
(SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod) a, prod b
WHERE a.buy_prod = b.prod_id;

--view 생성
CREATE OR REPLACE VIEW VW_PROD_BUY AS 
SELECT buy_prod, b.prod_name,  sum_qty, sum_cost
FROM
(SELECT buy_prod, sum(buy_qty) sum_qty, sum(buy_cost) sum_cost
FROM buyprod
GROUP BY buy_prod) a, prod b
WHERE a.buy_prod = b.prod_id;


SELECT *
FROM USER_VIEWS;

--★☆★☆천하제일 쿼리경연★☆★☆ (햄버거 배)
--98p 분석함수(window함수) 도전실습. (ana0)
--emp테이블을 사용해서 사원의 부서별 급여(sal)별 순위 구하기.

--우선 부서별 랭킹
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
FROM emp; -- 위와 같은 결과를 가지는 축약된 쿼리. 강력한 대신 성능에 영향이 있어 너무 남발하면 안됨..























