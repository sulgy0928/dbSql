--테이블에서 데이터 조회
/*
        SELECT 컬럼, | express(문자열상수)
        FROM 데이터를 조회할 테이블(VIEW)
        WHERE 조건 (condition)




*/


DESC user_tables;
SELECT table_name, 

'SELECT * FROM ' || table_name || ';' AS select_query

FROM user_tables
WHERE TABLE_NAME != 'EMP'; --전체건수에서 -1한 값(13건)나올것.

SELECT *
FROM user_tables;

--숫자비교연산
--부서번호가 30번보다 크거나 같은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno >= 30;

--부서번호가 30번보다 작은 부서에 속한 직원 조회

SELECT *
FROM emp
WHERE deptno < 30;

--입사 일자가 1928년 1월1일 이후인 직원 조회하기.
SELECT *
FROM emp
WHERE hiredate < TO_DATE('19820101', 'YYYYMMDD');


--col BETWEEN X AND Y연산
--컬럼의 값이 x보다 크거나 같고, y보다 작거나 같은 데이터
--급여(sal)가 1000보다 크거나 같고, Y보다 작거나 같은 데이터를 조회
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--위의 BETWEEN AND 연산자는 아래의 <=, >= 조합과 같다.
SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <=2000
  AND deptno = 30;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE ('1982/01/01', 'YYYY/MM/DD') AND TO_DATE ('1983/01/01', 'YYYY/MM/DD');

SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE ('1982/01/01', 'YYYY/MM/DD')  
  AND hiredate < TO_DATE ('1983/01/01', 'YYYY/MM/DD');

--IN 연산자
-- COL IN (values...)
-- 부서번호가 10 혹은 20인 직원들 조회하기.
SELECT *
FROM emp 
WHERE deptno in(10,20);

--IN 연산자는 OR연산자로 표현할수있다.
SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 20;

SELECT userid 아이디, usernm 이름, alias 별명
FROM users
WHERE userid in ('brown', 'cony', 'sally');


--COL LIKE 'S%'
--COL의 값이 대문자 S로 시작하는 모든 값
--COL LIKE 'S____'
--COL의 값이 대문자 S로 시작하고 이어서 4개의 문자열이 존재하는 값.

--emp 테이블에서 직원이름이 s로 시작하는 모든 직원 조회하기.
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--LIKE 실습 where4
--member테이블에서 회원의 성이 신씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하기.

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE ('신%');

--LIKE 실습 where5
--member테이블에서 회원의 성이 이씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하기.

SELECT mem_id, mem_name
FROM member
 WHERE mem_name LIKE ('%이%');

--WHERE mem_name LIKE ('%이%'); --mem_name이 문자열 안에 이가 들어간 데이터.
--WHERE mem_name LIKE ('이%'); --mem_name이 이로 시작하는 데이터.

--NULL 비교
--col IS NULL
--EMP테이블에서 MGR 정보가 없는사람(NULL) 조회
SELECT *
FROM emp 
WHERE mgr IS NULL;
--WHERE MGR !=null; --비교가 실패한다.

SELECT *
FROM emp
WHERE deptno !='10';
-- =, !=
-- is null // is not null

--조건에 맞는 데이터 조회하기. (IS NULL 실습where6)
--emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회하는 쿼리 작성하기.

SELECT *
FROM emp
WHERE comm is not null;

--AND / OR
--관리자(mgr) 사번이 7698이고 급여(sal)가 1000 이상인 사람
SELECT *
FROM emp
WHERE mgr  = 7698
  AND sal >= 1000;

--emp테이블에서 관리자(mgr) 사번이 7698이거나 급여(sal)가 1000 이상인 직원 조회
SELECT *
FROM emp
WHERE mgr  = 7698
   OR sal >= 1000;
   
   
--emp테이블에서 관리자(mgr) 사번이 7698이 아니고, 7839가 아닌 직원 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839); -- IN --> OR

--위의 쿼리를 AND/OR 연산자로 변환
SELECT *
FROM emp
WHERE mgr != (7698)
   OR mgr !=(7839);

--IN, NOT IN 연산자의 NULL 처리
--emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원 조회하기.
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
  AND mgr IS NOT NULL;  --IN 연산자에서 결과값에 NULL이 있을 경우 의도하지 않은 동작을 한다...!!

--논리연산(AND, OR 실습where7)
--emp테이블에서 job이  SALESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하기.
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM//DD');

--쌤의 답안
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM//DD');

--논리연산(AND, OR 실습 where8)
--emp 테이블에서 부서번호가 10번이 아니고,
--입사일자가 1981년 6월 1일 이후인 지원의 정보를 조회하기.
--(IN, NOT IN 연산자 사용 금지!)

SELECT *
FROM emp
WHERE deptno !=10
AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--논리연산(AND, OR 실습 where9)
--emp 테이블에서 부서번호가 10번이 아니고,
--입사일자가 1981년 6월 1일 이후인 지원의 정보를 조회하기.
--(NOT IN 연산자 사용!)


SELECT *
FROM emp
WHERE deptno NOT IN ('10')
  AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--논리연산(AND, OR 실습 where10)
--emp 테이블에서 부서번호가 10번이 아니고,
--입사일자가 1981년 6월 1일 이후인 지원의 정보를 조회하기.
--(부서는 10, 20, 30만 있다는 가정 하에 IN 연산자 사용.)

SELECT * 
FROM emp
WHERE deptno IN (20, 30)
  AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--논리연산(AND, OR 실습 where11)
--emp 테이블에서 job이 SALESMAN 이거나,
--입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하기.

SELECT * 
FROM emp
WHERE job IN ('SALESMAN') --job = 'SALESMAN'
   OR HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


--논리연산(AND, OR 실습 where12)
--emp 테이블에서 job이  SALESMAN 이거나,
--사원번호가 78로 시작하는 직원의 정보를 조회하기.

SELECT *
FROM emp 
WHERE job = 'SALESMAN'
   OR empno LIKE ('78%');


















--입사 일자가 19


















