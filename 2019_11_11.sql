--smith, ward����� ���� �μ��� ������ ��ȸ.

SELECT *
FROM emp
WHERE deptno IN (20, 30);



SELECT *
FROM emp
WHERE deptno = 20
        OR deptno = 30;
        
SELECT *
FROM emp
WHERE deptno IN 
                (SELECT deptno      
                FROM emp 
                WHERE ename 
                IN('SMITH', 'WARD'));
        
 SELECT *
FROM emp
WHERE deptno IN 
                (SELECT deptno      
                FROM emp 
                WHERE ename 
                IN(:name1, :name2) );
                
-- ANY : set�߿� �����ϴ°� �ϳ��� ������ ��.(ũ���)
--SMITH, WARD �λ���� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϱ�.
SELECT ename, sal
FROM emp
ORDER BY sal;

SELECT *
FROM emp
WHERE sal < any (SELECT sal --800, 1250
                                    FROM emp
                                    WHERE ename IN ('SMITH','WARD') );
                                            
-- SMITH�� WARD ���� �޿��� ���� ���� ��ȸ
--SMITH���ٵ� �޿��� ���� WARD���ٵ� �޿��� �������(and)
SELECT *
FROM emp
WHERE sal > all (SELECT sal --800, 1250
                                    FROM emp
                                    WHERE ename IN ('SMITH','WARD') );
        
--NOT IN


--�������� �������� ��ȸ�ϱ�
--1. �������� ����� ��ȸ.
--    . mgr �÷��� ���� ������ ����
SELECT DISTINCT mgr
FROM emp;        
        
--� ������ �������� ���� ������ ��ȸ�� ��.
SELECT * 
FROM emp
WHERE empno IN(7839,7782,7698,7902,7566,7788);     
        
SELECT * 
FROM emp
WHERE empno IN (SELECT mgr
                                FROM emp); 
        
SELECT * 
FROM emp
WHERE empno NOT IN (SELECT mgr
                                FROM emp
                                WHERE mgr IS NOT NULL);         

--������ ������ ���� �ʴ� ���� ���� ��ȸ
--NOT IN ������ ���� set�� NULL�� ���Ե� ��� ���������� �������� �ʴ´�.
--NULLó�� �Լ��� WHERE ���� ���� NULL���� ó���� ���� ���
SELECT * 
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,-9999)
                                FROM emp); 
 
 --pair wise
 --��� 7499, 7782�� ������ ������, �μ���ȣ ��ȸ
 --7698  30
 --7839  10
 --�����߿� �����ڿ� �μ���ȣ�� (7698, 30)�̰ų� (7839, 10)�� ���
 --mgr, deptno �÷��� ���ÿ� ������Ű�� �������� ��ȸ.
 SELECT *
 FROM emp
 WHERE (mgr, deptno) 
                     IN(SELECT mgr, deptno
                     FROM emp
                     WHERE empno IN (7499, 7782));
        
        
SELECT *
 FROM emp
 WHERE mgr IN (SELECT mgr
                                 FROM emp
                                WHERE empno IN (7499, 7782)) 
 AND deptno IN (SELECT deptno
                                 FROM emp
                                WHERE empno IN (7499, 7782));       
        
--SCALAR SUBQUERY : SELECT ���� �����ϴ� ��������.(��, ���� �ϳ��� ��, �ϳ��� �÷�)        
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno, (SELECT dname
                                                        FROM dept
                                                        WHERE deptno = emp.deptno) dname
FROM emp;
        
SELECT dname
FROM dept
WHERE deptno = 20;
        
        
 --sub4 ������ ����
 INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
 COMMIT;
 
 
 SELECT *
 FROM emp
 ORDER BY DEPTNO;
        
 SELECT deptno, dname, loc
 FROM dept
 WHERE deptno NOT IN (SELECT deptno 
                                            FROM emp);
 
SELECT distinct deptno
FROM emp;

--sub5 �ǽ� ppt 247p

SELECT pid, pnm
FROM product
WHERE pid NOT IN (100,400);

SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid --100, 400
                                    FROM cycle
                                    WHERE cid = 1);

--cid�� 1�� �մ��� ������ǰ ��ȸ
SELECT pid
FROM cycle
WHERE cid = 1;

--sub6 �ǽ� ppt 248p

SELECT pid --100, 400
FROM cycle
WHERE cid = 1;

SELECT pid --100, 200
FROM cycle
WHERE cid = 2;

SELECT cid, pid, day, cnt
FROM cycle
WHERE cid = 1
AND pid IN    (SELECT pid 
                         FROM cycle
                         WHERE cid = 2);

--EXISTS MAIN ������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ
--�����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������
--���ɸ鿡�� ����.

--MGR�� �����ϴ� ���� ��ȸ
SELECT *
 FROM emp a
 WHERE EXISTS (SELECT  'X'
                                    FROM emp
                                    WHERE empno = a.mgr); 
 
 --MGR�� �������� �ʴ� ���� ��ȸ
 SELECT *
 FROM emp a
 WHERE NOT EXISTS (SELECT  'X'
                                        FROM emp
                                        WHERE empno = a.mgr); 

--sub8�ǽ� ppt 251p
--MGR�� �����ϴ� ������ ���������ȽἭ ��ȸ
SELECT *
 FROM emp
 WHERE mgr IS NOT NULL;

--�μ��� �Ҽӵ� ������ �ִ� �μ�������ȸ(EXISTS)
SELECT *
 FROM dept
 WHERE EXISTS(SELECT  'X'
                            FROM emp
                             WHERE deptno = dept.deptno);     
        
  SELECT *
 FROM dept --�̷��� IN�����ڷε� �����ϴ�.
 WHERE deptno IN (SELECT  deptno
                                 FROM emp); 
                                 
--���տ���
--UNION : ������. �ߺ��� ����
--              DBMS ������ �ߺ��� �����ϱ� ���� �����͸� ����
--              (�뷮�� �����Ϳ� ���� ���� �� ����.)
--UNION ALL : UNION�� ��������.
--                      �ߺ��� �������� �ʰ�, �� �Ʒ� ������ ����. => �ߺ�����
--                      ���Ʒ� ���տ� �ߺ��Ǵ� �����Ͱ� ���ٴ� ���� Ȯ���ϸ�
--                      UNION �����ں��� ���ɸ鿡�� ����.
--����� 7566 �Ǵ� 7698�� ��� ��ȸ.(���, �̸��� ��ȸ)
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION
--����� 7369, 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno = 7369 OR empno = 7499;


--UNION ALL (�ߺ� ���, �� �Ʒ� ������ ��ġ�⸸ ��.)
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION ALL

SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno = 7369 OR empno = 7499;

--INTERSECT (������ : �� �Ʒ� ���հ��� ���뵥���͸� �̾Ƴ�.)
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698,7369)

INTERSECT

SELECT empno, ename
FROM EMP
WHERE empno IN (7566, 7698,7499);


--MINUS (������ : �����տ��� �Ʒ� ������ ����.)
--��� ����������. ���Ʒ� �����ٲ�� ����� �޶�������.
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698,7369)

MINUS

SELECT empno, ename
FROM EMP
WHERE empno IN (7566, 7698,7499);






SELECT empno, ename
FROM EMP
WHERE empno IN (7566, 7698,7499)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698,7369);


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC02'
AND TABLE_NAME IN ('PROD','LPROD')
AND CONSTRAINT_TYPE IN ('P','R');





        
        
        
        
        