

-- h_1 �����ý��ۺ� ������ ���� �������� ���� ��ȸ (dept0_02)

SELECT level lv, deptcd, LPAD(' ', 4  * (LEVEL - 1), ' ') || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;


-- ����� ���� ����
-- Ư�� ���κ��� �ڽ��� �θ��带 Ž�� (Ʈ�� ��ü Ž���� �ƴϴ�)
-- ���������� �������� ���� �μ��� ��ȸ
-- �������� dept0_00_0
SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd ;
-- PRIOR: �̹� ���� �����͸� ��Ī
--CONNECT BY p_deptcd = PRIOR depccd �ᵵ �����ϴ�.



-- �� �������� (�ǽ� h_4) ---------------------------------------------------------------------------------------------------------------------------
-- ������ ���� ����.sql�� �̿��Ͽ� ���̺��� �����ϰ� ������ ���� ����� �������� ������ �ۼ��Ͻÿ�.
-- s_id : ��� ���̵�
-- ps_id : �θ� ��� ���̵�
-- value : ��� ��
SELECT *
FROM h_sum;

SELECT LPAD(' ', (LEVEL - 1) * 8, ' ') || s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- �� �������� (�ǽ� h_5) ---------------------------------------------------------------------------------------------------------------------------
-- ���������� ��ũ��Ʈ.sql�� �̿��Ͽ� ���̺��� �����ϰ� ������ ���� ����� �������� ������ �ۼ��Ͻÿ�.
-- org_cd : �μ��ڵ�
-- parent_org_cd : �θ� �μ��ڵ�
-- no_emp : �μ� �ο���
SELECT *
FROM no_emp;

SELECT LPAD(' ', 10 * (LEVEL - 1), ' ') || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;
-----------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- pruning barnch (����ġ��)
-- ���� �������� [WHERE] ���� START WITH, CONNECT BY ���� ���� ����� ���Ŀ� ����ȴ�.

-- dept_h ���̺��� �ֻ��� ������ ��������� ��ȸ
SELECT deptcd, deptnm, LPAD(' ', 8 * (LEVEL - 1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

-- ���������� �ϼ��� ���� WHERE ���� ����ȴ�.
SELECT deptcd, deptnm, LPAD(' ', 8 * (LEVEL - 1), ' ') || deptnm deptnm
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;     -- ��ȹ���� �����κ� �Ʒ��� ��ó�� ���´�.

SELECT deptcd, deptnm, LPAD(' ', 8 * (LEVEL - 1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd
                            AND deptnm != '������ȹ��';


-- CONNECT_BY_ROOT(col) : col�� �ֻ��� ��� �÷� ��
-- SYS_CONNECT_BY_PATH(col, ������) : col�� �������� ������ �����ڷ� �̾ �����ִ� ���
                                                                  -- LTIRM�� ���� �ֻ��� ��� ������ �����ڸ� �����ִ� ���°� �Ϲ���
-- CONNECT_BY_ISLEAF :  �ش� row�� leaf node���� �Ǻ� ( 1:  0, 0 : X)
SELECT LPAD(' ', 8 * (LEVEL - 1), ' ' ) || org_cd org_cd,
             CONNECT_BY_ROOT(org_cd) root_org_cd,        -- ���� �ֻ��� �ڵ尡 ���� �����´�. ���� ������� �ʴµ� ���� �ʿ��� ���� ����.
             LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'), '-') path,           -- � ������ ���ؼ� �Դ��� �÷��� �̾ ������.
             CONNECT_BY_ISLEAF isleaf                              -- �ش� �÷��� ������ ����̳�, �ƴϳ�
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;



-- �� �������� (�Խñ� ���������� ���� �ڷ�.SQL, �ǽ� h6 ---------------------------------------------------------------------------------
-- �Խñ��� �����ϴ� board_test ���̺��� �̿��Ͽ� ���� ������ �ۼ��Ͻÿ�.
SELECT *
FROM board_test;

--SELECT seq, LPAD(' ', 8 * (LEVEL - 1), ' ') || title title
--FROM board_test
--START WITH seq IN ('1', '2', '4')
--CONNECT BY PRIOR seq = parent_seq;

SELECT seq, LPAD(' ', 8 * (LEVEL - 1), ' ') || title title
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq = parent_seq;
-----------------------------------------------------------------------------------------------------------------------------------------------------------



-- ORDER SIBLINGS BY : ���� ������ �����ϸ鼭 ������ �ض�.
SELECT seq, LPAD(' ', 8 * (LEVEL - 1), ' ') || title title
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

-- ����
SELECT *
FROM(SELECT seq, LPAD(' ', 8 * (LEVEL - 1), ' ') || title title,
                          CONNECT_BY_ROOT(seq) r_seq
            FROM board_test
            START WITH parent_seq IS NULL 
            CONNECT BY PRIOR seq = parent_seq
            ORDER SIBLINGS BY seq DESC) a
ORDER BY r_seq DESC, seq;
--ORDER SIBLINGS BY CONNECT_BY_ROOT(seq) DESC; -- ������.



SELECT *
FROM board_test;

-- �� �׷��ȣ �÷� �߰�
ALTER TABLE board_test ADD (gn NUMBER);

SELECT seq, LPAD(' ', 8 * (LEVEL - 1), ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq;



-- �ڽź��� �ٷ� �Ʒ� ����� �޿��� ���� �� �ְԲ�
SELECT a.ename, a.sal, b.sal l_sal
FROM
(SELECT ename, sal, ROWNUM rn
FROM(SELECT ename, sal FROM emp ORDER BY sal DESC)) a,
            (SELECT ename, sal, ROWNUM rn FROM(SELECT ename, sal FROM emp ORDER BY sal DESC)) b
WHERE a.rn = b.rn(+) - 1;
            


