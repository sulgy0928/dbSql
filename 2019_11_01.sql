--복습
-- WHERE
--연산자
-- 비교 : =, !=, <>, >=, >, <=, <
--BETWEEN start AND end
--IN (set)
--LIKE 'S%' ( % : 다수의 문자열과 매칭 //   _ : 정확히 한글자 매칭)
--IS NULL (주의--  != NULL 이렇게작성하면 안먹음.)
--AND, OR, NOT

--emp 테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일 사이에 있는 직원정보조회
--BETWEEN AND   
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01', 'YYYY/MM/DD')
                AND TO_DATE('1986/12/31', 'YYYY/MM/DD');

-->=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1986/12/31', 'YYYY/MM/DD');
  

--emp테이블에서 관리자(mgr)가 있는 직원만 조회하기.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;
  
--논리연산 AND OR실습 where13
--job이 SALESMAN이거나 사원번호가 78이 들어있는직원정보 조회하기.
--LIKE연산 사용 금지.
--empno는 정수 네자리까지 허용.
--empno : 7800 ~ 7899까지 허용.
--        780~789
--        78

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno BETWEEN 7800 AND 7899 
    OR empno BETWEEN 780 AND 789
    OR empno =78;
   
--AND OR 실습 where14
--emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월1일이후인
--직원의 정보를 다음과 같이 조회하세요.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR(   empno LIKE '78%' --덜헷갈리라고 괄호로 포장해줌..
  AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'));
  
--order by 컬럼명 | 별칭 | 컬럼인텍스 [ASC | DESC]
--order by 구문은 WHERE절 다음에 기술.
--WHERE절이 없는 경우 FROM절 다음에 기술.
--emp테이블을 ename기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC : default.
--그래서 ASC를 안붙여도 위 쿼리와 동일한 결과를 얻을 수 있다.
SELECT *
FROM emp
ORDER BY ename;

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename DESC; --desc 소문자로해도상관없음.
  
--job을 기준으로 내림차순으로 정렬, 만약 job이 같을경우 
--사번(empno)으로 올림차순 정렬
--SALESMAN - PRESIDENT - MANAGER - CLERK - ANALYST

SELECT *
FROM emp
ORDER BY job DESC, empno asc;
  
--별칭으로 정렬하기.
--사원번호(empno), 사원명(ename) 연봉(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬.

SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 4; --네번째 컬럼인 year_sal의 컬럼번호 4. 이렇게해도 적용됨. 현재 저 기준 순으로 출력

--데이터정렬 orderby1
--dept테이블의 모든정보를 부서이름 오름차순정렬로 조회하는 쿼리 작성하기.
--dept테이블의 모든 정보를 부서위치별 내림차순 정렬로 조회하는 쿼리 작성하기.
--**컬럼명을 명시하지않았으니 지난 수업시간에 배운 내용으로 올바른 컬럼을 찾아보며 풀기.**

SELECT *
FROM dept 
ORDER BY DNAME ASC;

SELECT *
FROM dept 
ORDER BY LOC ASC;


--orderby2
--emp테이블에서 상여(comm)정보가 있는 사람들만 조회하고, 
--상여를 많이 받는 사람이 먼저 조회 되도록 하고,
--상여가 같을 경우 사번으로 오름차순정렬하기.

SELECT *
FROM emp
WHERE comm IS NOT NULL --소문자여도 상관X
ORDER BY comm DESC, empno ASC--ASC는 기본값(디폴트)기때문에 굳이 붙여주지 않아도 원하는 결과를 얻을 수 있음.
;

--orderby3
--emp테이블에서 관리자가 있는 사람들만 조회하고, 
--직군(job)순으로 오름차순 정렬하고, 
--직업이 같을 경우 사번이 큰 사원이 먼저 조회되는 커리 작성하기.

SELECT *
FROM emp
WHERE mgr IS NOT NULL 
ORDER BY job asc, empno desc;


--orderby4
--emp테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람 중 급여(sal)가 1500이 넘는 사람들만 조회하고,
--이름으로 내림차순정렬하는 쿼리를 작성하기.

SELECT * --답안다시확인
FROM emp
WHERE (deptno = 10  OR deptno = 30) 
AND sal > 1500
ORDER BY ename desc
; 


--이 형태의 쿼리는 주의가필요함. PPT 슬라이드 79p 참고. 
--아직 읽지않은데이터가 더 있다면 사용이 안될수(출력이안됨)있음.
desc emp;
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2
;


--emp테이블에서 사번(empno), 이름(ename)을 급여기준으로 오름차순정렬.
--정렬된 결과순으로 ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--row
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;

--row_1
--emp테이블에서 ROWNUM값이 1~10인 값만 조회하는 쿼리를 작성하기.
--(정렬없이 진행하기.)
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE ROWNUM <= 10; 
--쌤 답안 : 마지막줄 WHERE ROWNUM BETWEEN 1 AND 10;

--row_2
--ROWNUM 값이 11~14인 값만 조회하는 쿼리를 작성하기.
--ROWNUM, empno, ename 출력됨
SELECT *
FROM
        (SELECT ROWNUM rn, b.*
        FROM  
        (SELECT empno, ename
        FROM emp
    ORDER BY sal)b)
WHERE rn between 11 AND 14;

--FUNCTION
--DUAL 테이블 조회
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--문자열 대소문자 관련 함수
--LOWER, UPPER, INITCAP
SELECT LOWER('HELLO WORLD'),UPPER('hello world')
    ,  INITCAP('hello world')
FROM dual;

SELECT LOWER('HELLO WORLD'),UPPER('hello world')
    ,  INITCAP('hello world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION은 WHERE절에서도 사용 가능.
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--개발자 SQL 칠거지악
--1. 좌변을 가공하지 말라.
--좌변(TABLE 의 칼럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
--Function Based Index -> FBI

--CONCAT : 문자열 결합. - 두개의 문자열을 결합하는 함수. 
--SUBSTR : 문자열의 부분 문자열(java : String.substring)
--LENGTH : 문자열의 길이
--INSTR : 문자열에 특정 문자열이 등장하는 첫번째 인덱스.
--LPAD : 문자열에 특정 문자열 삽입
SELECT CONCAT(CONCAT('HELLO', ',') , 'WORLD') CONCAT, --별칭정해준것.
             SUBSTR('HELLO, WORLD', 0,5) substr,
             SUBSTR('HELLO, WORLD', 1,5) substr1,
             LENGTH('HELLO, WORLD') length,
             INSTR('HELLO, WORLD', 'O')instr,
             --INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후에있는 값 인덱스를 표시)
             INSTR('HELLO, WORLD', 'O', 6)instr1,  
            --LPAD(문자열, 전체 문자열 길이, 
            --      문자열이 전체문자열 길이에 미치지 못 할 경우 추가할 문자.)
             LPAD('HELLO, WORLD', 15, '*') lpad,
             LPAD('HELLO, WORLD', 15) lpad,
             LPAD('HELLO, WORLD', 15, ' ') lpad,
             RPAD('HELLO, WORLD', 15, '*') rpad
             
FROM dual;










































  
  
  
  
  
  
  
  
  
  
  
  
  