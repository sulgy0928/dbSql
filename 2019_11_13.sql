--unique table level constraint

DROP TABLE dept_test;

CREATE TABLE dept_test(
        deptno NUMBER(2) PRIMARY KEY,
        dname VARCHAR2(14),
        loc VARCHAR2(13),
        
        --CONSTRAINT �������Ǹ� CONSTRAINT TYPE [ (�÷�...) ]
        CONSTRAINT uk_dept_test_dname_loc UNIQUE (dname, loc)
        );
        
INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
--ù��° ������ ���� dname, loc���� �ߺ��Ǿ� �ι�° ������ ���� ���� �ʴ´�.        
INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
        
--foreign key (��������)
DROP TABLE dept_test;

CREATE TABLE dept_test(
        deptno NUMBER(2) PRIMARY KEY,
        dname VARCHAR2(14),
        loc VARCHAR2(13)
);
        
INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
    commit;
        
--emp_test (empno, ename deptno)
DESC emp;        

CREATE TABLE emp_test(
        emptno NUMBER(4) PRIMARY KEY,
        ename VARCHAR2(10),
        deptno NUMBER(2) REFERENCES dept_test(deptno)
);  

--dept_test ���̺� 1�� �μ���ȣ�� �����ϰ�
--fk ������ dept_test.deptno �÷��� �����ϵ��� �����Ͽ�
--1�� �̿��� �μ���ȣ�� emp_test ���̺� �Էµ� �� ����.


--emp_test fk �׽�Ʈ insert
INSERT INTO emp_test VALUES(9999, 'brown', 1);

--2���μ��� dept_test ���̺� �������� �ʴ� ������ �̱� ������
--fk ���࿡ ���� INSERT�� ���������� ���ư����ʴ´�.
INSERT INTO emp_test VALUES(9998, 'sally', 2);

--���Ἲ ���࿡�� �߻� ��, �츰 �� �ؾ��ұ�?
--�Է��ϰ��� �ϴ� ���� �´����� �ϴ� Ȯ��.(ex  2���� �³�? ��� 1���ƴϾ�??) --�����߸��ΰ��.
--  .�θ����̺� ���� �� �Է��� �ȵƴ��� Ȯ��(dept_test Ȯ��)


--fk���� table level constraint
DROP TABLE emp_test;
CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,
        ename VARCHAR2(10),
        deptno NUMBER(2),
        CONSTRAINT fk_emp_test_no_dept_test FOREIGN KEY
        (deptno) REFERENCES dept_test(deptno)
);
        
  --FK������ �����Ϸ��� �����Ϸ��� �÷��� �ε����� �����Ǿ��־���Ѵ�.
  DROP TABLE emp_test; --�θ� ���� ����°� �ȵȴ�. �θ� �����ϴ� �ڽ����ֱ⶧����. 
  DROP TABLE dept_test;
        
CREATE TABLE dept_test(
        deptno NUMBER(2), /*PRIMARY KEY --> ���ɻ����Ѵٴ°�  ? UNIQUE������ ���ϰڴ�. */
        dname VARCHAR2(14),
        loc VARCHAR2(13)
        );
        
 CREATE TABLE emp_test(
            empno NUMBER(4),
            ename VARCHAR2(10),
    --dept_test.dept_no �÷��� �ε����� ���⶧���� ���������� 
    --fk ������ ���� �� �� ����.
            deptno NUMBER(2) REFERENCES dept_test(deptno)
            );
        
--���̺� ����^��^
DROP TABLE dept_test;
        
CREATE TABLE dept_test(
        deptno NUMBER(2) PRIMARY KEY,
        dname VARCHAR2(14),
        loc VARCHAR2(13)
        );
        
 CREATE TABLE emp_test(
            empno NUMBER(4),
            ename VARCHAR2(10),
            deptno NUMBER(2) REFERENCES dept_test(deptno)
            );   
            
INSERT INTO dept_test VALUES (1, 'ddit', 'daejeon');
INSERT INTO emp_test VALUES(9999, 'brown', 1);
   
COMMIT;

DELETE emp_test WHERE empno = 9999;
--dept_test ���̺��� deptno ���� �����ϴ� �����Ͱ� ���� ��� ������ �Ұ����ϴ�.
--��, �ڽ����̺��� �θ����̺��� ������ �� �����ϴ� �����Ͱ� ����� �θ����̺��� �����͸�
--���� �� �� �ִ�.
DELETE dept_test WHERE deptno = 1;
        
ROLLBACK;
--fk ���� �ɼ�
--default : ������ �Է�/���� �� ���������� ó������� fk ������ �������� �ʴ´�.
--ON DELETE CASCADE : �θ����� ���� ��, �װ� �����ϴ����� �ڽ����̺� ���̻���.
--ON DELETE NULL : �θ����� ���� ��, �װ� �����ϴ����� �ڽ����̺��� ���� NULL�� ��������.
DROP TABLE emp_test;
CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,
        ename VARCHAR2(10),
        deptno NUMBER(2),
        CONSTRAINT fk_emp_test_no_dept_test FOREIGN KEY
        (deptno) REFERENCES dept_test(deptno) ON DELETE CASCADE
);

INSERT INTO emp_test VALUES (9999, 'brown', 1);
        COMMIT;
        
--fk ���� default �ɼǽÿ��� �θ����̺��� �����͸� �����ϱ� ���� �ڽ����̺���
--�����ϴ� �����Ͱ� ����� ���������� ������ �����߾���.
--ON DELETE CASCADE �� ���, �θ����̺� ���� ��, �����ϴ� �ڽ����̺��� �����͸�
--���� �����Ѵ�.
--1. ���������� ���������� ����Ǵ���?
--2. �ڽ� ���̺� �����Ͱ� �����Ǿ�����?
DELETE dept_test  
    WHERE deptno=1;  
        
SELECT *
FROM emp_test;
        
        
        
        
 --FK���� ON DELETE SET NULL       
  DROP TABLE emp_test;
CREATE TABLE emp_test(
        empno NUMBER(4) PRIMARY KEY,
        ename VARCHAR2(10),
        deptno NUMBER(2),
        CONSTRAINT fk_emp_test_no_dept_test FOREIGN KEY
        (deptno) REFERENCES dept_test(deptno) ON DELETE SET NULL
);

INSERT INTO emp_test VALUES (9999, 'brown', 1);
        COMMIT;
        
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES (1, 'ddit' , 'daejeon');
INSERT INTO emp_test VALUES (9999, 'brown', 1);
COMMIT;
        
        
 --fk ���� default �ɼǽÿ��� �θ����̺��� �����͸� �����ϱ� ���� �ڽ����̺���
--�����ϴ� �����Ͱ� ����� ���������� ������ �����߾���.
--ON DELETE SET NULL �� ���, �θ����̺� ���� ��, �����ϴ� �ڽ����̺��� ��������
--�����÷��� NULL�� �����Ѵ�.
--1. ���������� ���������� ����Ǵ���?
--2. �ڽ� ���̺� �����Ͱ� NULL�� ����Ǿ�����?
DELETE dept_test  
    WHERE deptno=1;  
        
SELECT *
FROM emp_test;
        
 --CHECK ���� : �÷��� ���� ������ ����, Ȥ�� ���� �����Բ� ����.
 DROP TABLE emp_test;
 
CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10),
        sal NUMBER CHECK(sal >= 0)
        );
        
-- sal �÷��� CHECK �������ǿ� ���� 0�̰ų�, 0���� ū ���� �Է��� �����ϴ�.
INSERT INTO emp_test VALUES(9999, 'brown', 10000);
INSERT INTO emp_test VALUES(9998, 'sally', -10000);        
        
 
 
  DROP TABLE emp_test;
 
CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10),
        --emp_gb : 01 - ������ / 02 - ����.
        emp_gb VARCHAR2(2) CHECK (emp_gb IN ('01', '02'))
        );       
        
  INSERT INTO emp_test VALUES (9999, 'brown','01');      
        --emp_gb �÷� üũ���࿡ ���� 01, 02�� �ƴ� ���� �Է��� �� ����.
  INSERT INTO emp_test VALUES(9998, 'sally','03');       
        

--SELECT ����� �̿��� TABLE ����.
--CREATE TABLE ���̺�� AS
--SELECT ����
--> CTAS(CREATE TABLE AS�� ����)

DROP TABLE emp_test;
DROP TABLE dept_test;

--CUSTOMER ���̺��� ����Ͽ� CUSTOMER_TEST ���̺�� �����ϱ�
--CUSTOMER ���̺��� �����͵� ���� ����
--��--��--��--�ص����͸� �����ǰ� ���������� ���� ������ �ȵ�. ����.--��--��--��--��
CREATE TABLE CUSTOMER_TEST AS
SELECT *
FROM customer;
        
SELECT *
FROM customer_test;

CREATE TABLE test AS
SELECT SYSDATE dt
FROM dual;

SELECT *
FROM test;

DROP TABLE test;

--�����ʹ� �������� �ʰ� Ư�� ���̺��� �÷����ĸ� �����ü�������? Ʋ��.
DROP TABLE test;

CREATE TABLE customer_test AS
SELECT *
FROM customer 
WHERE 1 != 1;


--���̺� ����
--���ο� �÷� �߰��ϱ�.

DROP TABLE emp_test;
CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10)
        );          
        
--�ű��÷��߰��ϱ�.
ALTER TABLE emp_test ADD (deptno NUMBER (2));
desc emp_test;

--���� �÷� �����ϱ�.(���̺� �����Ͱ����»�Ȳ)
ALTER TABLE emp_test MODIFY (ename VARCHAR2 (200));
DESC emp_test;

ALTER TABLE emp_test MODIFY (ename NUMBER);
DESC emp_test;

--�����Ͱ� �ִ� ��Ȳ���� �÷� ���� : ��������.
INSERT INTO emp_test VALUES (9999, 1000, 10);
COMMIT;

--������ Ÿ���� �����ϱ����ؼ��� �÷��� ���� ����־���Ѵ�.
 ALTER TABLE emp_test MODIFY (ename VARCHAR2(10));
 
 --DEFAULT ����
ALTER TABLE emp_test MODIFY (deptno DEFAULT 10);

--�÷��� ����
ALTER TABLE emp_test RENAME column deptno TO dno;
desc emp_test;

--�÷� ����(DROP����  DELETE�� �ƴ�.)
ALTER TABLE emp_test DROP column DNO;
ALTER TABLE emp_test DROP (DNO);

    DESC emp_test;
        
--���̺� ���� : �������� �߰�
--PRIMARY KEY
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

--�������� ����
ALTER TABLE emp_test DROP constraint pk_emp_test;
        
--UNIQUE ���� - empno �� �غ���.

ALTER TABLE emp_test ADD CONSTRAINT uk_emp_test unique (empno);        
        
--UNIQUE ���� ���� :    uk_emp_test
  ALTER TABLE emp_test DROP constraint uk_emp_test;      
        
        
--FOREIGN KEY �߰�
--�Ը���ǽ�
--1. DEPT ���̺��� DEPTNO�÷��� PRIMARY KEY �������� ���̺��� �����ϱ�.
--DDL�� ���� ����.
ALTER TABLE dept ADD CONSTRAINT Edeptno PRIMARY KEY (deptno);


--2. emp ���̺��� empno �÷����� PRIMARY KEY ������ ���̺� ����
--DDL�� ���� ����
ALTER TABLE emp ADD CONSTRAINT pk_empno PRIMARY KEY (empno);

--3. emp ���̺��� deptno �÷����� dept ���̺��� deptno �÷���
--�����ϴ� fk������ ���̺���ddl������ �����ϱ�.
--emp --> dept (deptno)

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno)
references dept (deptno);


SELECT *
FROM emp_test;

--emp_test -> dept.deptno  fk���� �ɾ��. (ALTER TABLE)
DROP TABLE emp_test;
CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10),
        deptno NUMBER(2)
        );   
        
ALTER TABLE emp_test ADD CONSTRAINT fk_deptno 
FOREIGN KEY (deptno) references dept(deptno);       
        
--CHECK ���� �߰� (ename ����üũ, ���̰� 3���� �̻�)
ALTER TABLE emp_test ADD CONSTRAINT check_ename_len 
CHECK (LENGTH(ename) > 3 );

INSERT INTO emp_test VALUES (9999,'brown', 10);
INSERT INTO emp_test VALUES (9998,'br', 10);
ROLLBACK;

--CHECK ���� �����غ���.
ALTER TABLE emp_test DROP CONSTRAINT check_ename_len;

--NOT NULL ���� �߰��غ���.
ALTER TABLE emp_test MODIFY (ename NOT NULL);

--NOT NULL ���� �����غ���.
ALTER TABLE emp_test MODIFY (ename NULL);














        
        
        
        