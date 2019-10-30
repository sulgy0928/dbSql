-- SELECT : ��ȸ�� �÷� ���
--          -��ü�÷���ȸ : *
--          -�Ϻ� �÷� : �ش� �÷��� ����(,�� ����.)
-- FROM : ��ȸ�� ���̺� ���
-- ������ ���� �ٿ� ������ �ۼ��ص� �������.
--��, keyword�� �ٿ��� �ۼ��ؾ���.

--��� �÷��� ��ȸ.

SELECT * FROM prod;

--Ư���÷��� ��ȸ
SELECT prod_id, prod_name 
FROM prod;

--1) lprod ���̺��� ��� �÷� ��ȸ
SELECT * FROM prod;

--2) buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT buyer_id, buyer_name
FROM buyer;

--3) cart���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM cart;

--4)member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT mem_id, mem_pass, mem_name
FROM member;

--������ / ��¥����
--date type + ���� : ���ڸ� ���Ѵ�.
-- null�� ������ ������ ����� �׻� null�̴�.
SELECT userid, usernm, reg_dt,
        reg_dt + 5 reg_dt_after5,
        reg_dt - 5 as reg_dt_before5
FROM users;

--1) prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� prod_id -> id, prod_name -> name ���� �÷� ��Ī�� ����)
SELECT prod_id id, prod_name name
FROM prod;

--2) lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� lprod_gu ->gu, lprod_nm -> nm���� �÷� ��Ī�� ����)
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

--3) buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--(�� buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷� ��Ī�� ����)
SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

--���ڿ� ����. ������ ���뿡�� ������ ���� ����.
-- java�� +�� sql���� || .
--CONCAT(str, str)�Լ�
--users���̺��� userid, usernm
SELECT userid, usernm,
        userid || usernm,
        CONCAT(userid, usernm)
FROM users;

--���ڿ� ���(�÷��� ��� �����Ͱ� �ƴ϶� �����ڰ� ���� �Է��� ���ڿ�)
SELECT '����� ���̵� : ' || userid,
        CONCAT('����� ���̵� : ', userid) --���� �����ڵ�
FROM users;

--���ڿ����սǽ� sel_con1
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM '||table_name ||';' QUERY 
FROM user_tables;

--desc table
--���̺� ���ǵ� Į���� �˰� ���� ��.
--1. desc
--2.select * ...

desc emp; -- ��ũ����/�ش� ���̺� ���� ������ ������ �˷���.

SELECT *
FROM emp;




--WHERE��, ���� ������.
SELECT *
FROM users
WHERE userid = 'brown';

--usernm�� ���� �� �����͸� ��ȸ�ϴ� ������ �Ẹ��.
SELECT *
FROM users
WHERE usernm = '����';




