--�Ķ���Ͱ� �ִ� ����� Ŀ��
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

--cursor�� ��������� �������� �ʰ�
--loop���� inline���·� cursor ���


set SERVEROUTPUT on;
--�͸���
DECLARE
            --cursor ���� --> loop ���� inline����
BEGIN
                --for (String str : list)
            FOR rec IN (SELECT deptno, dname FROM dept)  LOOP
                    dbms_output.put_line(rec.dname || ',' || rec.dname);
            END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE avgdt
IS

            --�����
                prev_dt DATE;
                ind NUMBER  :=  0;
                diff NUMBER  := 0;
BEGIN
                --dt ���̺��� ��� ������ ��ȸ.
                FOR rec IN (SELECT * FROM dt ORDER BY dt DESC) LOOP
                --rec : dt �÷�.
                --��������������(dt) - ����������(dt)  =   
                IF ind = 6 THEN --LOOP�� ù�κ�.
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
--1������ 100����ǰ�� �����ϳ� �� �� �Դ´�.

--> DAILY
CREATE OR REPLACE create_daily_sales(p_yyyymm VARCHAR2)
IS
        -- �޷��� �������� ������ RECORED TYPE
        TYPE cal_row RECODE IS (
                    dt VARCHAR2(8),
                     d VARCHAR2(1));
                     
                     --�޷� ������ ������ table type
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

--�����Ϸ��� �ϴ� ��. ����

desc cycle;

SELECT *
FROM CYCLE
WHERE DAY >= 20191100;

COMMIT;

------������� ��
CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm VARCHAR2)
IS
    --�޷��� �������� ������ RECORD TYPE
    TYPE cal_row IS RECORD (
        dt VARCHAR2(9),
        d VARCHAR2(1));
    
    --�޷� ������ ������ table type
    TYPE calendar IS TABLE OF cal_row;
    cal calendar;
    
    --�����ֱ� cursor
    CURSOR cycle_cursor IS
        SELECT *
        FROM cycle;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'YYYYMMDD') dt,
           TO_CHAR(TO_DATE(p_yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d
           BULK COLLECT INTO cal
    FROM dual
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm, 'YYYYMM')),'DD'));
    
    --�����Ϸ��� �ϴ� ����� ���� �����͸� �����Ѵ�
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%';
    
    --�����ֱ� loop
    FOR rec IN cycle_cursor LOOP
        FOR i IN 1..cal.count LOOP    
            --�����ֱ��� �����̶� ������ �����̶� ������ ��
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






