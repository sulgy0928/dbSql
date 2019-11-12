--프젝할때 이정도는 혼자 짤 줄 알아야함....^ㅅ^

--실습 sub7 ppt 249p
--1번고객이 먹는 애음제품
--2번고객 도 먹는 애음제품
--고객명과 제품명 추가.
SELECT cycle.cid, customer.cnm, product.pid,product.pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN(SELECT pid 
                    FROM cycle    
                    WHERE cid = 2);

--실습 sub9 ppt 252p
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X' 
                                FROM cycle
                                WHERE cid = 1 
                                AND pid = product.pid);

--1번고객의 애음제품
SELECT *
FROM cycle
WHERE cid = 1;

SELECT *
FROM DEPT;

-- DELETE DEPT WHERE DEPTNO = 99;  이렇게 하면 해당계정sql에선 다시조회하면
--지워진걸로 조회되지만 다른계정에서 다시조회하면 여전히 지워지지않고 남아있다.
-- commit을 하지 않아서 확정되지 않아 반영이 안되는 것인데, commit을 하면 적용되어 제대로 지워진다.


desc emp;

desc dept;

INSERT INTO emp ( ename, job)
VALUES( 'brown', null);

SELECT *
FROM emp
WHERE empno = 9999;

rollback;

desc emp;

SELECT *
FROM USER_TAB_COLUMNS
WHERE table_name = 'EMP'
ORDER BY column_id;
1. EMPNO
2. ENAME
3. JOB
4. MGR
5. HIREDATE
6. SAL
7. COMM
8. DEPTNO

INSERT INTO emp
VALUES (9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);

--SELECT 결과(여러 건)을 INSERT 할 수도 있다.
INSERT INTO emp(empno, ename)
SELECT deptno, dname
FROM dept;

COMMIT;
SELECT *
FROM emp;

--UPDATE
--UPDATE 테이블 SET  컬럼 = 값, 컬럼 = 값....
--WEHRE condition

SELECT *
FROM dept;

UPDATE dept SET dname = '대덕IT', loc='ym' --업데이트 : 기존 데이터를 말그대로 업데이트 한다. WHERE 절 안쓰는 실수 주의.
                                                                          --                 한글 한 자가 3byte. 용량때매 글자수 제한있음
WHERE deptno=99;


SELECT *
FROM emp;

--DELETE 테이블명
--WHERE condition

--사원번호가 9999인 직원을 emp테이블에서 삭제

DELETE emp
WHERE empno = 9999;

--부서테이블을 이용해서 emp 테이블에 입력한 5건(4건)의 데이터를 삭제
--10,20,30,40,99 --> empno < 100, 혹은 empno BETWEEN 10 AND 99 이렇게 해야함.
DELETE emp
WHERE empno < 100;

SELECT*
FROM emp
WHERE empno < 100; --지우고자 하는 범위를 미리 확인해보면 실수 확률이 줄어들지 ^ㅅ^

ROLLBACK;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

SELECT *
FROM emp
WHERE empno BETWEEN 10 AND 99;

ROLLBACK;

DELETE emp
WHERE empno IN  (SELECT deptno 
                               FROM dept);

rollback;

SELECT *
FROM emp;

DELETE emp WHERE empno = 9999;
commit;

--LV1 --> LV3
SET TRANSACTION
isolation LEVEL SERIALIZABLE; --오라클에선 괜찮은데 다른 DBMS에선 이렇게 개인이 임의로 했다간 난리가 남 ㅎ



SELECT *
FROM dept;

--DDL : AUTO COMMIT, rollback이 안됨.
--CREATE
CREATE TABLE ranger_new(
        ranger_no NUMBER,   --타입을 숫자로 지정.
        ranger_name VARCHAR2(50) ,--문자 : [VARCHAR2](베리어블캐릭터. 일반적으로 많이쓰임) , CHAR(캐릭터. 문제가 많이 사용하지않음)
        reg_dt DATE DEFAULT sysdate --DEFAUL : SYSDATE

);

desc ranger_new;
--DDL은 rollback이 적용되지 않는다.
rollback;


INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');

SELECT *
FROM ranger_new;

commit;

--날짜타입에서 특정필드가져오기
--ex : sysdate 에서 년도만 가져오기
SELECT TO_CHAR(SYSDATE,'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, 
                TO_CHAR(reg_dt) mm,
                EXTRACT(MONTH FROM reg_dt) mm,
                EXTRACT(YEAR FROM reg_dt) year
FROM ranger_new;

--제약조건
--DEPT 모방해서 DEPT_TEST 만들것임.
CREATE TABLE dept_test(
        deptno number(2) PRIMARY KEY,  -- deptno 컬럼을 식별자로 지정.
        dname varchar2(14),                       -- 식별자로 지정이 되면 값이 중복이 
        loc varchar2(13)                              -- 될 수 없고, null일수도없다.
);

desc dept_test;

--primary key 제약조건
--1. deptno 컬럼에 null이 들어갈 수 없다
--2. deptno 컬럼에 중복된 값이 들어갈 수 없다.
desc dept_test;
INSERT INTO dept_test(deptno, dname, loc)
VALUES (null, 'ddit', 'daejeon');

INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');

rollback;

--사용자 지정 제약조건명을 부여한 primary key
DROP TABLE dept_test;

CREATE TABLE dept_test(
            deptno NUMBER(2)  CONSTRAINT PK_DEPT_TEST PRIMARY KEY, --제약조건의 이름
            dname VARCHAR2(14),
            loc VARCHAR2(13)
);

--TABLE CONSTRAINT
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST  PRIMARY KEY (deptno, dname)
    );

INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');

SELECT *
FROM dept_test;

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2)  PRIMARY KEY, 
        dname VARCHAR2(14)  NOT NULL,
        loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, null,'daejeon');

--UNIQUE
DROP TABLE dept_test;
CREATE TABLE dept_test(
        deptno NUMBER(2)  PRIMARY KEY, 
        dname VARCHAR2(14) UNIQUE,
        loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2','daejeon');
rollback























































