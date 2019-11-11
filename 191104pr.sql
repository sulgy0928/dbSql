SELECT '아이디 : ' || userid --AS id_name
FROM users;

SELECT 'SELECT * ' || table_name || ';' query
FROM user_tables;



desc users;

SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE ('1982/01/01', 'YYYY/MM/DD')  
  AND hiredate < TO_DATE ('1983/01/01', 'YYYY/MM/DD');

SELECT userid , usernm
FROM users
WHERE userid IN('brown','cony','sally');


--2019_11_01 파일 참고
SELECT *
FROM emp
WHERE  job = 'SALESMAN' 
        OR(empno LIKE '78%'  
              AND hiredate >= TO_DATE ('19810601','YYYYMMDD'));
       





















