--대전지역 한정
--버거킹, 맥도날드, KFC 갯수
SELECT a.sido, a.sigun, a.cnt kmb, b.cnt l,
                ROUND(a.cnt/b.cnt, 2) point
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN ('버거킹', '맥도날드', 'KFC')
GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE SIDO = '대전광역시'
    AND gb IN ('롯데리아') )
GROUP BY sido, sigungu);
---------------------------------------------------------------------------
---------------------------------------------------------------------------
SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE  gb IN ('롯데리아')
GROUP BY sido, sigungu, gb; --전국단위의 롯데리아 카운트.



SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE  gb IN ('버거킹', '맥도날드', 'KFC')
GROUP BY sido, sigungu; 

SELECT SIDO, SIGUNGU, ROUND(SAL/PEOPLE,2) point
FROM tax
ORDER BY point desc;

--시도, 시군구, 버거지수 
--시도, 시군구, 연말정산 납입액
--서울시 중구 5.7 , 경기도 수원시 18623591

SELECT a.*, b.*
FROM 
    (SELECT a.*, ROWNUM RN 
     FROM
        (SELECT a.sido, a.sigungu, a.cnt kmb, b.cnt l,
               round(a.cnt/b.cnt, 2) point
        FROM 
            --140건
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('KFC', '버거킹', '맥도날드')
            GROUP BY SIDO, SIGUNGU) a,
            
            --188건
            (SELECT SIDO, SIGUNGU, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('롯데리아')
            GROUP BY SIDO, SIGUNGU) b
            WHERE a.sido = b.sido
            AND a.sigungu = b.sigungu
        ORDER BY point DESC )a ) a,
    
    (SELECT b.*, rownum rn
    FROM 
    (SELECT sido, sigungu
    FROM TAX
    ORDER BY sal DESC) b ) b
WHERE b.rn = a.rn(+)
ORDER BY b.rn;

SELECT m.ename, s.ename
FROM emp m LEFT OUTER JOIN emp s
ON (m.mgr = s.empno);

SELECT m.ename mname, m.mgr, s.ename sname, s.deptno
FROM emp m LEFT OUTER JOIN emp s
ON (m.mgr = s.empno AND s.deptno = 10);

SELECT a.*, rownum rn
FROM
(SELECT emp.*
    FROM emp
    ORDER BY empno desc) a;


SELECT *
FROM emp_test;
DROP TABLE emp_test;

--multiple insert 를 위한 테스트 테이블 생성
--empno, ename 두개의 컬럼을 갖는 emp_test, emp_test2 테이블을 
--emp 테이블로 부터 생성한다. (CTAS)
--데이터는 복제하지않는다.

CREATE TABLE emp_test AS;
CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp
WHERE 1 = 2;

--INSERT ALL
--하나의 INSERT SQL 문장으로 여러 테이블에 데이터를 입력
INSERT ALL
        INTO emp_test
        INTO emp_test2
SELECT 1, 'brown'  FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;


--INSERT 데이터 확인
SELECT *
FROM emp_test2;

--INSERT ALL 컬럼 정의
ROLLBACK;

INSERT ALL
        INTO emp_test (empno) VALUES (empno)
        INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally'  ename FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


--multiple insert (conditional insert)
ROLLBACK;
INSERT ALL
        WHEN empno < 10 THEN
                INTO emp_test (empno) VALUES (empno)
        ELSE    --조건을 통과하지 못할때만 실행
                INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally'  ename FROM dual;



--INSERT FIRST
--조건에 만족하는 첫번째 INSERT 구문만 실행
rollback;
INSERT FIRST
        WHEN empno > 10 THEN
                INTO emp_test (empno) VALUES (empno)
        WHEN empno > 5 THEN
                INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual;

SELECT *
FROM emp_test;


ROLLBACK;


--MERGE : 조건에 만족하는 데이터가 있으면 UPDATE
--                   조건에 만족하는 데이터가 없으면 INSERT

--empno가 7369인 데이터를 emp 테이블로부터 emp_test 테이블에 복사(insert)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE EMPNO = 7369;

SELECT *
FROM emp_test;

--emp테이블의 데이터 중에 emp_test 테이블의 empno와 같은 값을 갖는 데이터가 있을 경우, 
--emp_test.ename  = ename | |  '_merge' 값으로 update
--데이터가 없을 경우, emp_test 테이블에 insert


ALTER TABLE emp_test MODIFY (ename VARCHAR2(20));

MERGE INTO emp_test
USING emp
      ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
        UPDATE SET ename = emp.ename | |  '_merge'
WHEN NOT MATCHED THEN
        INSERT VALUES (emp.empno, emp.ename);

SELECT *
FROM emp_test;


--다른테이블을 통하지 않고 테이블 자체의 데이터 존재 유무로
--merge 하는 경우.

ROLLBACK;

--empno = 1, ename = 'brown'
-- empno가 같은 값이 있으면 ename을 'brown'으로 업데이트
--empno가 같은값이 없으면 신규 insert

SELECT *
FROM emp_test;


MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 1)
WHEN MATCHED THEN
        UPDATE set ename = 'brown' | |  '_merge'
WHEN NOT MATCHED THEN
        INSERT VALUES (1, 'brown');

--merge 안하면..?
--아래와 같이 총 세번을 작업해야함.
SELECT 'X'
FROM emp_test
WHERE empno = 1;

UPDATE emp_test set ename = 'brown' | |  '_merge'
WHERE empno = 1;

INSERT INTO emp_test VALUES (1, 'brown');

--실습 sql2 ppt // 17p
SELECT deptno , sal
FROM emp;

SELECT deptno, sum(sal) sal
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, sum(sal) sal
FROM emp;

--위 쿼리를 ROLLUP 형태로 변경


SELECT deptno , SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);
--GROUP BY deptno, sal
--UNION GROUP BY deptno;
--rollup
--group by 의 서브그룹을 생성
--group by ROLLUP( {clo, } )
--컬럼을 오른쪽에서부터 제거해가면서 나온 서브그룹을 
--GROUP BY 하여 UNION 한 것과 동일
--ex : GROUP BY ROLLUP (job, deptno)
--       GROUP BY job, deptno
--      UNION
--      GROUP BY job
--      UNION
--      GROUP BY --> 총계(모든 행에 대해 그룹함수 적용)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP(job, deptno);

--GROUPING SETS (col1, col2...)
--GROUPING SETS 의 나열된 항목이 하나의 서브그룹으로 GROUP BY 절에 이용된다.

--GROUT BY col1
--UNION ALL
--GROUP BY col2

--emp테이블을 이용해서 부서별 급여 합과 담당 업무(job)별 급여 합을 구하시오.

--부서번호, job, 급여합계 순으로 컬럼 만들어볼거임.
SELECT deptno, null job, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, job, SUM(sal)
FROM emp
GROUP BY job;

SELECT deptno, job, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);



















