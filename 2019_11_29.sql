--파라미터가 있는 명시적 커서
DECLARE
            CURSOR emp_cursor(p_job emp.job%TYPE) IS
                            SELECT empno, ename, job
                            FROM emp
                            WHERE job = p_job;
                v_empno emp.empno%TYPE;
                v_ename emp.ename%TYPE;
                v_job emp.job%TYPE;
                
BEGIN
                FOR emp IN emp_cursor('SALESMAN') LOOP
                            dbms_output.put_line(emp.empno || ',' || emp.ename || ',' || emp.job);
                END LOOP;
END;
/

--cursor를 명시적으로 선언하지 않고
--loop에서 inline형태로 cursor 사용


set SERVEROUTPUT on;
--익명블록
DECLARE
            --cursor 선언 --> loop 에서 inline선언
BEGIN
                --for (String str : list)
            FOR rec IN (SELECT deptno, dname FROM dept)  LOOP
                    dbms_output.put_line(rec.dname || ',' || rec.dname);
            END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE avgdt
IS

            --선언부
                prev_dt DATE;
                ind NUMBER  :=  0;
                diff NUMBER  := 0;
BEGIN
                --dt 테이블의 모든 데이터 조회.
                FOR rec IN (SELECT * FROM dt ORDER BY dt DESC) LOOP
                --rec : dt 컬럼.
                --먼저읽은데이터(dt) - 다음데이터(dt)  =   
                IF ind = 6 THEN --LOOP의 첫부분.
                    prev_dt  :=  rec.dt;
             ELSE
                    diff  := diff + prev_dt - rec.dt;
                    prev_dt := rec.dt;
                END IF;
                
                ind  := ind + 1;
                
                END LOOP;
                dbms_output.put_line('diff : ' || diff(ind-1);
END;
/

exec avgdt;   -- 35

SELECT * 
FROM CYCLE;

--1 100 2
--1번고객은 100번제품을 월요일날 한 개 먹는다.

--> DAILY
CREATE OR REPLACE create_daily_sales(p_yyyymm VARCHAR2)
IS
        -- 달력의 행정보를 저장할 RECORED TYPE
        TYPE cal_row RECODE IS (
                    dt VARCHAR2(8),
                     d VARCHAR2(1));
                     
                     --달력 정보를 저장할 table type
                     TYPE calendar IS TABLE OF cal_row;
                     cal calendar;
BEGIN
               SELECT TO_CHAR(TO_DATE('201911', 'YYYYMM') +  (LEVEL-1), 'YYYYMMDD') dt,
                 TO_CHAR(TO_DATE('201911', 'YYYYMM') +  (LEVEL-1), 'D') d
                BULK COLLECT INTO cal
                FROM dual
                CONNECT BY LEVEL <= SELECT  TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD'));
 
                FOR i IN 1..cal.count LOOP;
                
                            dbms_output.put_line(cal(i).dt || ',' || cal(i).d);
            END;
/

SELECT  TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD'))
FROM dual;


SELECT TO_CHAR(TO_DATE('201911', 'YYYYMM') +  (LEVEL-1), 'YYYYMMDD') dt,
                 TO_CHAR(TO_DATE('201911', 'YYYYMM') +  (LEVEL-1), 'D') d

FROM dual
CONNECT BY LEVEL <= SELECT  TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD'));

--생성하려고 하는 년. 월의

desc cycle;

SELECT *
FROM CYCLE
WHERE DAY >= 20191100;

COMMIT;

------이진우쌤 답
CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm VARCHAR2)
IS
    --달력의 행정보를 저장할 RECORD TYPE
    TYPE cal_row IS RECORD (
        dt VARCHAR2(9),
        d VARCHAR2(1));
    
    --달력 정보를 저장할 table type
    TYPE calendar IS TABLE OF cal_row;
    cal calendar;
    
    --애음주기 cursor
    CURSOR cycle_cursor IS
        SELECT *
        FROM cycle;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d
           BULK COLLECT INTO cal
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')),'DD'));
    
    --생성하려고 하는 년월의 실적 데이터를 삭제한다
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%';
    
    --애음주기 loop
    FOR rec IN cycle_cursor LOOP
        FOR i IN 1..cal.count LOOP    
            --애음주기의 요일이랑 일자의 요일이랑 같은지 비교
            if REC.day = cal(i).d THEN
                INSERT INTO daily VALUES(rec.cid, rec.pid, cal(i).dt, rec.cnt);
            END IF;
        END LOOP;    
    END LOOP;
    COMMIT;    
END;
/

exec create_daily_sales('201911');

SELECT *
FROM daily;






