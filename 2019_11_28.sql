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
--�ǽ� pro3

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


--ROWTYPE : ���̺��� �� ���� �����͸� ���� �� �ִ� ����Ÿ��
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
--���պ��� : record
DECLARE
        --User VO userVO; �� ������ ���.
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
        
        --java : Ÿ�� ������;
        --pl/sql : ������ Ÿ��;
        v_dept dept_tab;
        
        
BEGIN 
            SELECT *
            BULK COLLECT INTO v_dept
            FROM dept;
            
            FOR i in 1..v_dept.count LOOP
              dbms_output.put_line(v_dept(I).dname);
            END LOOP;
            --���� �迭�ε����� 1���ͽ����ؼ� 0 ������ ����.
          
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
-- FOR �ε��� ���� IN ���۰�..���ᰪ LOOP
--END LOOP;

DECLARE
BEGIN
        FOR i IN 0..5 LOOP
                dbms_output.put_line('I : '  ||  I);
        END LOOP;
END;
/

--LOOP : ��� �����Ǵܷ����� LOOP �ȿ��� ����.
-- java : while (true)

DECLARE
            i NUMBER;
BEGIN
            i := 0;
            
            LOOP
                dbms_output.put_line(i);
                i  :=  i  +  1 ;
                --loop ��� ���࿩�� �Ǵ�.
                EXIT WHEN i >= 5;
        END LOOP;
END;
/

SELECT *
FROM DT;


--������� : 5��.
--cursor, ��������ǽ� PRO_3
--DECLARE
--    TYPE d_row IS RECORD(
--                dt DATE);
--                
                --TYPE d_table IS TABLE OF d_row INDEX BY BINARY_INTEGER;
                --d_tab d_table;
                --diff 

--lead, lag �������� ����, ���� �����͸� ���� �� �� �ִ�.
SELECT AVG(diff)
FROM
(SELECT   dt -  LEAD(dt) OVER (ORDER BY dt DESC)diff
FROM dt);

--�м��Լ��� ������� ���Ҷ�
(SELECT ROWNUM RN, dt
FROM
            (SELECT dt
            FROM dt
            ORDER BY dt DESC))a,; 
            
    DECLARE
            --Ŀ�� ����.
            CURSOR dept_cursor IS
                                SELECT deptno, dname FROM dept;
                                
                v_deptno dept.deptno%TYPE;
                v_dname dept.dname%TYPE;
    BEGIN
                --Ŀ�� ����   
                OPEN dept_cursor;
                LOOP
                        FETCH dept_cursor INTO v_deptno, v_dname;
                        
                        dbms_output.put_line(v_deptno || ',' || v_dname);
                        EXIT WHEN dept_cursor%NOTFOUND; --���̻� ���� �����Ͱ� ���� �� ����.
                
                END LOOP;
    END;
/
            
--FOR LOOP CURSOR ����

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









