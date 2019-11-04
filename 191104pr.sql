--복습(실습 where11번)
--job이 SALESMAN이거나 입사일자가 1981년 6월1일 이후인 직원정보 조회하기.
-- ~이거나 --> OR
--1981년 6월1일 이후 --> 해당 일 포함

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');
    
desc emp;
--TO_CHAR : DATE타입을 문자열로 변환.
--날짜를 문자열로 변환시에 포맷(쿼리 형태)을 지정해줘야함

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
        TO_CHAR(SYSDATE +5, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3
FROM dual;

--fn2
SELECT 
        TO_CHAR(SYSDATE,'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE,'DD-MM-YYYY') DT_DD_MM_YYYY    
FROM dual;


SELECT ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'), 5),
       ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'),-5)
FROM dual;


SELECT ROWNUM, a.*
    FROM(SELECT e.*
    FROM emp e
    ORDER BY ename)a;











