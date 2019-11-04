--����(�ǽ� where11��)
--job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6��1�� ������ �������� ��ȸ�ϱ�.
-- ~�̰ų� --> OR
--1981�� 6��1�� ���� --> �ش� �� ����

SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD');
    
desc emp;
--TO_CHAR : DATEŸ���� ���ڿ��� ��ȯ.
--��¥�� ���ڿ��� ��ȯ�ÿ� ����(���� ����)�� �����������

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
        TO_CHAR(SYSDATE +5, 'YYYY/MM/DD HH24:MI:SS')
FROM dual;

SELECT TO_DATE('2019/12/31','YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3
FROM dual;

--fn2
SELECT 
        TO_CHAR(SYSDATE,'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE,'DD-MM-YYYY') DT_DD_MM_YYYY    
FROM dual;


SELECT ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'), 5),
       ADD_MONTHS(TO_DATE('20191010','YYYYMMDD'),-5)
FROM dual;


SELECT ROWNUM, a.*
    FROM(SELECT e.*
    FROM emp e
    ORDER BY ename)a;











