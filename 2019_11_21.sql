-- 48p
--��ü ������ �޿���� 2073.21
SELECT ROUND(AVG(sal), 2)
FROM emp;

--�μ��� ������ �޿� ��� 10 XXXX, 20 YYYY, 30 ZZZZ
SELECT *
FROM
            (SELECT deptno, ROUND(AVG(sal), 2) d_avgsal
            FROM emp
            GROUP BY deptno)
WHERE d_avgsal  > (SELECT ROUND(AVG(sal), 2)
                                     FROM emp);

--���� ���� WITH���� �����Ͽ�
--������ �����ϰ� ǥ���Ѵ�.

WITH dept_avg_sal AS  (SELECT deptno, ROUND(AVG(sal), 2) d_avgsal
                                                FROM emp
                                                GROUP BY deptno)
                                
                                SELECT *
                                FROM dept_avg_sal
                                WHERE d_avgsal < (SELECT ROUND(AVG(sal), 2) 
                                                                            FROM emp);

--�޷� �����
--STEP1. �ش� �� ���� ���� �����
--CONNECT BY LEVEL

--201911
--DATE + ���� = ���� + ����.
SELECT  TO_DATE(:YYYYMM, 'YYYYMM') + ( level-1), TO_CHAR(LAST_DAY(SYSDATE), 'DD')
FROM DUAL a
CONNECT BY LEVEL <= 30;

SELECT a.w, 
                        MAX(DECODE(d, 1, dt))  sun, MAX(DECODE(d, 2, dt)) mon, MAX(DECODE(d, 3, dt)) tue,
                        MAX( DECODE(d, 4, dt)) wed,  MAX(DECODE(d, 5, dt)) thu, MAX(DECODE(d, 6, dt)) fri, 
                         MAX(DECODE(d, 7, dt) )sun   
 FROM
                (SELECT  TO_DATE(:YYYYMM, 'YYYYMM') + (level-1) dt,
                                    TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'w') w,
                                    TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (level-1), 'd') d
                FROM DUAL a
                CONNECT BY LEVEL <=  TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')) a
                GROUP BY a.w
                ORDER BY a.w;
                
--SALES
SELECT NVL(MAX (DECODE (TO_CHAR(DT, 'MM'), '01', SUM(sales))),0) jan,
                NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '02', SUM(sales)) ),0)  feb,
                NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '03', SUM(sales))),0)  mar,
                NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '04', SUM(sales)) ),0) apr, 
                NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '05', SUM(sales)) ),0) may,
                NVL(MAX(DECODE(TO_CHAR(DT, 'MM'), '06', SUM(sales)) ),0) june
    FROM sales
    GROUP BY TO_CHAR(DT, 'MM');

--��������
--START WITH : ������ ���ۺκ��� ����
--CONNECT BY : ������ ���������� ����

--����� �������� ( ���� �ֻ��� ������������ ��� ������ Ž��)
SELECT *
FROM dept_h
START WITH deptcd = 'dept0' --START WITH p_deptcd  IS NULL
CONNECT BY PRIOR deptcd = p_deptcd; --PRIOR ���� ���� ������

























