CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept.deptno%TYPE,
                                                                                                    p_dname IN dept.dname%TYPE,
                                                                                                    p_loc IN dept.loc%TYPE
                                                                                                                                                            )
IS
    var_ename emp.ename%TYPE;
    var_dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname
    INTO var_ename, var_dname
    FROM emp, dept
    WHERE empno = p_empno
    AND emp.deptno = dept.deptno;
    
    dbms_output.put_line(var_ename || ', ' || var_dname);
END;
/
exec printemp(7369);
--실습 pro3

CREATE OR REPLACE PROCEDURE UPDATEdept_test (p_deptno IN dept.deptno%TYPE,
                                                                                                             p_dname IN dept.dname%TYPE,
                                                                                                             p_loc IN dept.loc%TYPE
                                                                                                                                                            )
IS

BEGIN
    UPDATE dept_test SET dname = p_dname, loc = p_loc
    WHERE deptno = p_deptno;
    commit;
    
END;
/

exec UPDATEdept_test(90, 'ddit_m', 'daejeon');


SELECT *
FROM dept_test;


--ROWTYPE : 테이블의 한 행의 데이터를 담을 수 있는 참조타입
set serveroutput on;
DECLARE
                dept_row dept%ROWTYPE;
BEGIN
                SELECT *
                INTO dept_row
                FROM dept
                WHERE deptno = 10;
                
                dbms_output.put_line(dept_row.dname|| ',' || 
                                                        dept_row.dname|| ',' ||
                                                        dept_row.loc);
END;
/
--복합변수 : record
DECLARE
        --User VO userVO; 이 과정과 비슷.
        TYPE dept_row IS RECORD(
                    deptno NUMBER(2),
                    dname dept.dname%TYPE);
                    
                    v_dname dept.dname%TYPE;
                    v_row dept_row;
BEGIN
            SELECT deptno, dname
            INTO v_row
            FROM dept
            WHERE deptno = 10;

        dbms_output.put_line( v_row.deptno || ',' || v_row.dname);
END;
/

--tabletype
DECLARE
        TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
        
        --java : 타입 변수명;
        --pl/sql : 변수명 타입;
        v_dept dept_tab;
        
        
BEGIN 
            SELECT *
            BULK COLLECT INTO v_dept
            FROM dept;
            
            FOR i in 1..v_dept.count LOOP
              dbms_output.put_line(v_dept(I).dname);
            END LOOP;
            --여긴 배열인덱스가 1부터시작해서 0 넣으면 오류.
          
         END;
/

SELECT *
FROM dept;

--IF
--ELSE IF --> ELSIF
--END IF;

DECLARE
            ind BINARY_INTEGER;
BEGIN
        ind := 2;
        
        IF ind = 1 THEN 
                     dbms_output.put_line(ind);
         ELSIF ind = 2 THEN
                    dbms_output.put_line('ELSIF' || ind);
          ELSE
                      dbms_output.put_line('ELSE');
          END IF;
                    
END;
/

--FOR LOOP : 
-- FOR 인덱스 변수 IN 시작값..종료값 LOOP
--END LOOP;

DECLARE
BEGIN
        FOR i IN 0..5 LOOP
                dbms_output.put_line('I : '  ||  I);
        END LOOP;
END;
/

--LOOP : 계속 실행판단로직을 LOOP 안에서 제어.
-- java : while (true)

DECLARE
            i NUMBER;
BEGIN
            i := 0;
            
            LOOP
                dbms_output.put_line(i);
                i  :=  i  +  1 ;
                --loop 계속 진행여부 판단.
                EXIT WHEN i >= 5;
        END LOOP;
END;
/

SELECT *
FROM DT;


--간격평균 : 5일.
--cursor, 로직제어실습 PRO_3
--DECLARE
--    TYPE d_row IS RECORD(
--                dt DATE);
--                
                --TYPE d_table IS TABLE OF d_row INDEX BY BINARY_INTEGER;
                --d_tab d_table;
                --diff 

--lead, lag 현재행의 이전, 이후 데이터를 가져 올 수 있다.
SELECT AVG(diff)
FROM
(SELECT   dt -  LEAD(dt) OVER (ORDER BY dt DESC)diff
FROM dt);

--분석함수를 사용하지 못할때
(SELECT ROWNUM RN, dt
FROM
            (SELECT dt
            FROM dt
            ORDER BY dt DESC))a,; 
            
    DECLARE
            --커서 선언.
            CURSOR dept_cursor IS
                                SELECT deptno, dname FROM dept;
                                
                v_deptno dept.deptno%TYPE;
                v_dname dept.dname%TYPE;
    BEGIN
                --커서 열기   
                OPEN dept_cursor;
                LOOP
                        FETCH dept_cursor INTO v_deptno, v_dname;
                        
                        dbms_output.put_line(v_deptno || ',' || v_dname);
                        EXIT WHEN dept_cursor%NOTFOUND; --더이상 읽을 데이터가 없을 때 종료.
                
                END LOOP;
    END;
/
            
--FOR LOOP CURSOR 결합

DECLARE
                CURSOR dept_cursor IS
                        SELECT deptno, dname
                        FROM dept;                        
    v_deptno dept.deptno%TYPE;
     v_dname dept.dname%TYPE;
BEGIN
            FOR rec IN dept_cursor LOOP
                dbms_output.put_line(rec.deptno || ',' || rec.dname);
            END LOOP;
END;
/

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









