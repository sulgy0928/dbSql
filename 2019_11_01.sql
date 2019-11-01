--����
-- WHERE
--������
-- �� : =, !=, <>, >=, >, <=, <
--BETWEEN start AND end
--IN (set)
--LIKE 'S%' ( % : �ټ��� ���ڿ��� ��Ī //   _ : ��Ȯ�� �ѱ��� ��Ī)
--IS NULL (����--  != NULL �̷����ۼ��ϸ� �ȸ���.)
--AND, OR, NOT

--emp ���̺��� �Ի����ڰ� 1981�� 6�� 1�Ϻ��� 1986�� 12�� 31�� ���̿� �ִ� ����������ȸ
--BETWEEN AND   
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01', 'YYYY/MM/DD')
                AND TO_DATE('1986/12/31', 'YYYY/MM/DD');

-->=, <=
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD')
  AND hiredate <= TO_DATE('1986/12/31', 'YYYY/MM/DD');
  

--emp���̺��� ������(mgr)�� �ִ� ������ ��ȸ�ϱ�.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;
  
--������ AND OR�ǽ� where13
--job�� SALESMAN�̰ų� �����ȣ�� 78�� ����ִ��������� ��ȸ�ϱ�.
--LIKE���� ��� ����.
--empno�� ���� ���ڸ����� ���.
--empno : 7800 ~ 7899���� ���.
--        780~789
--        78

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno BETWEEN 7800 AND 7899 
    OR empno BETWEEN 780 AND 789
    OR empno =78;
   
--AND OR �ǽ� where14
--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6��1��������
--������ ������ ������ ���� ��ȸ�ϼ���.
SELECT *
FROM emp
WHERE job = 'SALESMAN'
  OR(   empno LIKE '78%' --���򰥸���� ��ȣ�� ��������..
  AND hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD'));
  
--order by �÷��� | ��Ī | �÷����ؽ� [ASC | DESC]
--order by ������ WHERE�� ������ ���.
--WHERE���� ���� ��� FROM�� ������ ���.
--emp���̺��� ename�������� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC : default.
--�׷��� ASC�� �Ⱥٿ��� �� ������ ������ ����� ���� �� �ִ�.
SELECT *
FROM emp
ORDER BY ename;

--�̸�(ename)�� �������� ��������
SELECT *
FROM emp
ORDER BY ename DESC; --desc �ҹ��ڷ��ص��������.
  
--job�� �������� ������������ ����, ���� job�� ������� 
--���(empno)���� �ø����� ����
--SALESMAN - PRESIDENT - MANAGER - CLERK - ANALYST

SELECT *
FROM emp
ORDER BY job DESC, empno asc;
  
--��Ī���� �����ϱ�.
--�����ȣ(empno), �����(ename) ����(sal * 12) as year_sal
SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����.

SELECT empno, ename, sal, sal*12 as year_sal
FROM emp
ORDER BY 4; --�׹�° �÷��� year_sal�� �÷���ȣ 4. �̷����ص� �����. ���� �� ���� ������ ���

--���������� orderby1
--dept���̺��� ��������� �μ��̸� �����������ķ� ��ȸ�ϴ� ���� �ۼ��ϱ�.
--dept���̺��� ��� ������ �μ���ġ�� �������� ���ķ� ��ȸ�ϴ� ���� �ۼ��ϱ�.
--**�÷����� ��������ʾ����� ���� �����ð��� ��� �������� �ùٸ� �÷��� ã�ƺ��� Ǯ��.**

SELECT *
FROM dept 
ORDER BY DNAME ASC;

SELECT *
FROM dept 
ORDER BY LOC ASC;


--orderby2
--emp���̺��� ��(comm)������ �ִ� ����鸸 ��ȸ�ϰ�, 
--�󿩸� ���� �޴� ����� ���� ��ȸ �ǵ��� �ϰ�,
--�󿩰� ���� ��� ������� �������������ϱ�.

SELECT *
FROM emp
WHERE comm IS NOT NULL --�ҹ��ڿ��� ���X
ORDER BY comm DESC, empno ASC--ASC�� �⺻��(����Ʈ)�⶧���� ���� �ٿ����� �ʾƵ� ���ϴ� ����� ���� �� ����.
;

--orderby3
--emp���̺��� �����ڰ� �ִ� ����鸸 ��ȸ�ϰ�, 
--����(job)������ �������� �����ϰ�, 
--������ ���� ��� ����� ū ����� ���� ��ȸ�Ǵ� Ŀ�� �ۼ��ϱ�.

SELECT *
FROM emp
WHERE mgr IS NOT NULL 
ORDER BY job asc, empno desc;


--orderby4
--emp���̺��� 10�� �μ�(deptno) Ȥ�� 30�� �μ��� ���ϴ� ��� �� �޿�(sal)�� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ�,
--�̸����� �������������ϴ� ������ �ۼ��ϱ�.

SELECT * --��ȴٽ�Ȯ��
FROM emp
WHERE (deptno = 10  OR deptno = 30) 
AND sal > 1500
ORDER BY ename desc
; 


--�� ������ ������ ���ǰ��ʿ���. PPT �����̵� 79p ����. 
--���� �������������Ͱ� �� �ִٸ� ����� �ȵɼ�(����̾ȵ�)����.
desc emp;
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM = 2
;


--emp���̺��� ���(empno), �̸�(ename)�� �޿��������� ������������.
--���ĵ� ��������� ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--row
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;

--row_1
--emp���̺��� ROWNUM���� 1~10�� ���� ��ȸ�ϴ� ������ �ۼ��ϱ�.
--(���ľ��� �����ϱ�.)
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE ROWNUM <= 10; 
--�� ��� : �������� WHERE ROWNUM BETWEEN 1 AND 10;

--row_2
--ROWNUM ���� 11~14�� ���� ��ȸ�ϴ� ������ �ۼ��ϱ�.
--ROWNUM, empno, ename ��µ�
SELECT *
FROM
        (SELECT ROWNUM rn, b.*
        FROM  
        (SELECT empno, ename
        FROM emp
    ORDER BY sal)b)
WHERE rn between 11 AND 14;

--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--���ڿ� ��ҹ��� ���� �Լ�
--LOWER, UPPER, INITCAP
SELECT LOWER('HELLO WORLD'),UPPER('hello world')
    ,  INITCAP('hello world')
FROM dual;

SELECT LOWER('HELLO WORLD'),UPPER('hello world')
    ,  INITCAP('hello world')
FROM emp
WHERE job = 'SALESMAN';

--FUNCTION�� WHERE�������� ��� ����.
SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';

--������ SQL ĥ������
--1. �º��� �������� ����.
--�º�(TABLE �� Į��)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
--Function Based Index -> FBI

--CONCAT : ���ڿ� ����. - �ΰ��� ���ڿ��� �����ϴ� �Լ�. 
--SUBSTR : ���ڿ��� �κ� ���ڿ�(java : String.substring)
--LENGTH : ���ڿ��� ����
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù��° �ε���.
--LPAD : ���ڿ��� Ư�� ���ڿ� ����
SELECT CONCAT(CONCAT('HELLO', ',') , 'WORLD') CONCAT, --��Ī�����ذ�.
             SUBSTR('HELLO, WORLD', 0,5) substr,
             SUBSTR('HELLO, WORLD', 1,5) substr1,
             LENGTH('HELLO, WORLD') length,
             INSTR('HELLO, WORLD', 'O')instr,
             --INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���Ŀ��ִ� �� �ε����� ǥ��)
             INSTR('HELLO, WORLD', 'O', 6)instr1,  
            --LPAD(���ڿ�, ��ü ���ڿ� ����, 
            --      ���ڿ��� ��ü���ڿ� ���̿� ��ġ�� �� �� ��� �߰��� ����.)
             LPAD('HELLO, WORLD', 15, '*') lpad,
             LPAD('HELLO, WORLD', 15) lpad,
             LPAD('HELLO, WORLD', 15, ' ') lpad,
             RPAD('HELLO, WORLD', 15, '*') rpad
             
FROM dual;


--����







































  
  
  
  
  
  
  
  
  
  
  
  
  