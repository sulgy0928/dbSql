--emp ���̺� empno�÷��� �������� PRIMARY KEY �� ����
--PRIMARY KEY = UNIQUE + NOT NULL
--UNIQUE ==>  �ش� �÷����� UNIQUE INDEX�� �ڵ����� �����Ѵ�.

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
 
--empno �÷����� �ε����� �����ϴ� ��Ȳ���� �ٸ��÷������� �����͸� ��ȸ�ϴ� ���
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);
 
 --�ε��� ���� �÷��� SELECT ���� ����� ���, ���̺� ������ �ʿ����.
 
 EXPLAIN PLAN FOR
 SELECT empno
 FROM emp
 WHERE empno = 7782;
 
  SELECT *
 FROM TABLE(dbms_xplan.display);
 
 
 --�÷��� �ߺ��� ������ non-unique �ε��� ���� �� unique index���� �����ȹ ��
 --PRIMARY KEY �������� ����(UNIQUE �ε��� ����)
 ALTER TABLE emp DROP CONSTRAINT pk_emp;
 CREATE INDEX  /*UNIQUE*/  IDX_emp_01 ON emp (empno);
 
EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE empno = 7782;
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --emp ���̺� job �÷����� �ι�° �ε��� ����.(non-unique index)
 --job�÷��� �ٸ� �ο��� job�÷��� �ߺ��� ������ �÷��̴�.
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
 
 --emp ���̺� job, ename �÷��� �������� non-unique �ε��� ����
 CREATE INDEX IDX_emp_03 ON emp (job, ename);
 
  EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE 'C%';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --emp ���̺� ename, job�÷�����  non-unique �ε��� ����
 CREATE INDEX IDX_EMP_04 ON emp (ename,job);
 
  EXPLAIN PLAN FOR
SELECT *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE '%C';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --HINT �� ����� �����ȹ ����.
EXPLAIN PLAN FOR
SELECT /*+ INDEX ( emp idx_emp_03) */ *
 FROM emp
 WHERE job = 'MANAGER'
 AND ename LIKE '%C';
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
--index �ǽ� idx1  ppt 401
CREATE TABLE DEPT_TEST AS SELECT * 
FROM DEPT WHERE 1 = 1;

CREATE INDEX /*UNIQUE*/idx_dept_04 ON dept_test (deptno);
 
  DROP INDEX idx_dept_04;
 
-- index idx3 �ǽ�  ppt 403
SELECT empno
FROM emp;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 