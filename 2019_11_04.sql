--복습(실습 where11번)
--job이 SALESMAN이거나 입사일자가 1981년 6월1일 이후인 직원정보 조회하기.
-- ~이거나 --> OR
--1981년 6월1일 이후 --> 해당 일 포함
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');
   
   
SELECT ROWNUM, emp.*
FROM emp;

--ROWNUM과 정렬문제
--ORDER BY 절은 SELECT 절 이후에 동작
--ROWNUM 가상컬럼이 적용되고나서 정렬되기 때문에
--우리가 원하는 대로 첫번째 데이터부터 순차적인 번호가 부여되질않는다.
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename; --alias를 줘서 해도 위와같은결과.
   
--ORDER BY 절을 포함한 인라인 뷰를 구성
--ROWNUM : 1번부터 읽어야함.
--WHERE절에 ROWNUM값을 중간만 읽는건 불가능
--안되는 케이스
--WHERE ROWNUM = 2
--WHRER ROWNUM >= 2

--가능한 케이스
--WHERE ROWNUM = 1
--WHERE ROWNUM <= 10

SELECT ROWNUM, a.*
    FROM(SELECT e.*
    FROM emp e
    ORDER BY ename)a;
   
--페이진 처리를 위한 꼼수 : ROWNUM에 별칭을 부여, 해당 SQL을 INLINE VIEW로
--감싸고 별칭을 통해 페이징 처리.
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
         FROM
            (SELECT e.*
            FROM emp e
            ORDER BY ename) a )
   WHERE rn BETWEEN 10 AND 14;
   
   
   
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
             RPAD('HELLO, WORLD', 15, '*') rpad,
             --REPLACE(원본문자열, 원본문자열에서 변경하고자 하는 대상 문자열, 변경문자열)
             REPLACE(REPLACE('HELLO, WORLD','HELLO','hello'),'WORLD','world')replace,
             TRIM('     HELLO, WORLD    ') trim,
             TRIM('H' FROM 'HELLO, WORLD') trim2 --H를 trim 해버림.(제거)
             
FROM dual;
   
    --ROUND(대상숫자, 반올림 결과 자릿수)
    SELECT ROUND(105.54,1) r1, --소수점 둘째자리에서 반올림
           ROUND(105.55,1) r2, --소수점 둘째자리에서 반올림
           ROUND(105.55,0) r3,  --소수점 첫째자리에서 반올림
           ROUND(105.55,-1) r4  --정수 첫째자리에서 반올림
    FROM dual;
   
   desc emp; --d컬럼 명 기억안날때 조회하는키.
   
   SELECT empno, ename, 
          sal,sal/1000, /*ROUND(sal/1000, 0) qutient,*/ MOD(sal, 1000) reminder --0~999
          --라운드함수 적용하면 몫만 남길 수 있다.
   FROM emp;
   
SELECT
TRUNC(105.54, 1) T1, --소수점 둘째자리에서 절삭.
TRUNC(105.55,1) T2,  --정수 첫째자리에서 절삭.
TRUNC(105.55,0) T3,  --소수점 첫째자리에서 절삭.
TRUNC(105.55,-1) T4 --소수점 둘째자리에서 절삭.
FROM dual;

--SYSDATE : 오라클이 설치된 서버의 현재 날짜 + 시간정보를 리턴한다.
-- 별도의 인자가 없는 함수.

--TO_CHAR : DATE타입을 문자열로 변환.
--날짜를 문자열로 변환시에 포맷(쿼리 형태)을 지정해줘야함
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'), --외우기^ㅅ^
       TO_CHAR(SYSDATE + (1/24/60)*30, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;


--Function(date실습 fn1)ppt 107p
SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE-3, NOW_BEFORE3
FROM dual;
   
--쌤의 예시.
SELECT LASTDAY, LASTDAY-5 as LASTDAY_BEFORE5,
        NOW, NOW-3 NOT_BEFORE3
FROM
    (SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
        SYSDATE NOW
   FROM DUAL);
   
   
--date format
--년도 : YYYY, YY, RR : 두자일 때랑, 네자 일때랑 다름
--RR은 두자리쓸때 50보다 크면 앞자리에 19가 붙고, 50보다 작으면 앞자리에 20이 붙는다.이래서 잘 안씀.
-- YYYY, RRRR 은 동일.가급적이면 명시적으로 표현 할 것.
-- D : 요일을 숫자로 표기 ( 일요일-1, 월요일-2, 화요일-3...토요일-7 )
SELECT TO_CHAR(TO_DATE('35/03/01', 'RR/MM/DD'),'YYYY/MM/DD)')r1,
       TO_CHAR(TO_DATE('55/03/01', 'RR/MM/DD'),'YYYY/MM/DD)')r2,
       TO_CHAR(TO_DATE('35/03/01', 'YY/MM/DD'),'YYYY/MM/DD)')y1,
       TO_CHAR(SYSDATE, 'D') d, --오늘은 월요일-2,
       TO_CHAR(SYSDATE, 'IW') iw, --주차 표기.
       TO_CHAR(TO_DATE('20191228', 'YYYYMMDD'),'IW') this_year,
       TO_CHAR(TO_DATE('20191229', 'YYYYMMDD'),'IW') this_year,
       TO_CHAR(TO_DATE('20191230', 'YYYYMMDD'),'IW') this_year,
       TO_CHAR(TO_DATE('20191231', 'YYYYMMDD'),'IW') this_year,
       TO_CHAR(TO_DATE('20200101', 'YYYYMMDD'),'IW') this_year
FROM DUAL; 
   
    --(date실습 fn2) PPT 111p

    SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') DT_DASH,
           TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WIDTH_TIME,
           TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
    FROM DUAL;

--날짜의 반올림(ROUND), 절삭(TRUNC) ppt 113p
-- ROUND(DATE, '포맷') YYYY, MM, DD 이런 형태를 포맷이라고함.
desc emp;
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
       TO_CHAR(ROUND(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as round_yyyy,
       TO_CHAR(ROUND(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,
       TO_CHAR(ROUND(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as round_DD,
       TO_CHAR(ROUND(hiredate-1, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,
       TO_CHAR(ROUND(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM
FROM emp
WHERE ename = 'SMITH';



SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
TO_CHAR(TRUNC(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as trunc_yyyy,
TO_CHAR(TRUNC(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM,
TO_CHAR(TRUNC(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as trunc_DD,
TO_CHAR(TRUNC(hiredate-1, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM,
TO_CHAR(TRUNC(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM
FROM emp
WHERE ename = 'SMITH';

-- PPT 115P
--Function(date). 날짜 연산 함수.
--MONTH_BETWEEN(DATE, DATE) : 두 날짜 사이의 개월을 계산.
-- 19801217 ~ 20191104 --> 20191117
--소숫점이 나오는 이유는 일자랑 시간때문에.
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
       MONTHS_BETWEEN(TO_DATE('20191117','YYYYMMDD'), hiredate) months_between
FROM emp
WHERE ename = 'SMITH';

--ADD_MONTHS(DATE, 개월 수) : DATE에 개월 수가 지난 날짜.
--개월수가 양수일 경우 미래, 음수일 경우 과거.
SELECT ename, TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS') hiredate,
       ADD_MONTHS(hiredate, 467) add_months,
       ADD_MONTHS(hiredate, -467) add_months
FROM emp
WHERE ename = 'SMITH';

--NEXT_DAY(DATE, 요일) : DATE 이후 첫번째 요일의 날짜.
SELECT SYSDATE, 
            NEXT_DAY(SYSDATE,7) first_sat, --오늘 날짜 이후 첫 토요일 일자.
            NEXT_DAY(SYSDATE,'토요일') first_sat --오늘 날짜 이후 첫 토요일 일자.
FROM dual;
   
   
--LAST_DAY(DATE)해당 날짜가 속한 원의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) LAST_DAY,
       LAST_DAY(ADD_MONTHS(SYSDATE,1)) LAST_DAY_12
FROM dual;

--DATE + 정수 = DATE(DATE에서 정수만큼 이후의 DATE)  
--D1 + 정수 = D2
--양변에서 D2 차감
--D1 + 정수 -D2 = D2-D2
--D1 + 정수 -D2 = 0
--D1 + 정수 = D2
--양변에 D1차감
--D1 + 정수 -D1 = D2 - D1
--정수 = D2 - D1
--결론 : 날짜에서 날짜를 빼면 일자가 나온다.
SELECT TO_DATE('20191104','YYYYMMDD') - TO_DATE('20191101','YYYYMMDD') D1,
       TO_DATE('20191201','YYYYMMDD') - TO_DATE('20191101','YYYYMMDD') D2,--11월의 일자 수 구하기
       --201908 : 2019년 8월의 일수 : 31 이걸 수식으로 구하기.
       TO_DATE('201908','YYYYMM'),
       ADD_MONTHS(TO_DATE('201908','YYYYMM'),1) - TO_DATE('201908','YYYYMM')D3
FROM dual;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   