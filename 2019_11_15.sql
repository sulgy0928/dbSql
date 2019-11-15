--emp 테이블에 empno컬럼을 기준으로 PRIMARY KEY 를 생성
--PRIMARY KEY = UNIQUE + NOT NULL
--UNIQUE ==>  해당 컬럼으로 UNIQUE INDEX를 자동으로 생성한다.

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY(empno);

EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE empno = 7369;
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 
SELECT *
 FROM emp
 WHERE empno = 7369;
 
--empno 컬럼으로 인덱스가 존재하는 상황에서 다른컬럼값으로 데이터를 조회하는 경우
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);
 
 --인덱스 구성 컬럼만 SELECT 절에 기술한 경우, 테이블 접근이 필요없다.
 
 EXPLAIN PLAN FOR
 SELECT empno
 FROM emp
 WHERE empno = 7782;
 
  SELECT *
 FROM TABLE(dbms_xplan.display);
 
 
 --컬럼에 중복이 가능한 non-unique 인덱스 생성 후 unique index와의 실행계획 비교
 --PRIMARY KEY 제약조건 삭제(UNIQUE 인덱스 삭제)
 ALTER TABLE emp DROP CONSTRAINT pk_emp;
 CREATE INDEX  /*UNIQUE*/  IDX_emp_01 ON emp (empno);
 
EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE empno = 7782;
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --emp 테이블에 job 컬럼으로 두번째 인덱스 생성.(non-unique index)
 --job컬럼은 다른 로우의 job컬럼과 중복이 가능한 컬럼이다.
 CREATE INDEX idx_emp_02 ON emp (job);
 
EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
  
 
 EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE 'C%';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --emp 테이블에 job, ename 컬럼을 기준으로 non-unique 인덱스 생성
 CREATE INDEX IDX_emp_03 ON emp (job, ename);
 
  EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE 'C%';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --emp 테이블에 ename, job컬럼으로  non-unique 인덱스 생성
 CREATE INDEX IDX_EMP_04 ON emp (ename,job);
 
  EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE '%C';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --HINT 를 사용한 실행계획 제어.
EXPLAIN PLAN FOR
SELECT /*+ INDEX ( emp idx_emp_03) */ *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE '%C';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
--index 실습 idx1  ppt 401
CREATE TABLE DEPT_TEST AS SELECT * 
FROM DEPT WHERE 1 = 1;

CREATE INDEX /*UNIQUE*/idx_dept_04 ON dept_test (deptno);
 
  DROP INDEX idx_dept_04;
 
-- index idx3 실습  ppt 403
SELECT empno
FROM emp;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 