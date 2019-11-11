--smith, ward사원이 속한 부서의 직원들 조회.

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
                
-- ANY : set중에 만족하는게 하나라도 있으면 참.(크기비교)
--SMITH, WARD 두사람의 급여보다 적은 급여를 받는 직원의 정보 조회하기.
SELECT ename, sal
FROM emp
ORDER BY sal;

SELECT *
FROM emp
WHERE sal < any (SELECT sal --800, 1250
                                    FROM emp
                                    WHERE ename IN ('SMITH','WARD') );
                                            
-- SMITH와 WARD 보다 급여가 높은 직원 조회
--SMITH보다도 급여가 높고 WARD보다도 급여가 높은사람(and)
SELECT *
FROM emp
WHERE sal > all (SELECT sal --800, 1250
                                    FROM emp
                                    WHERE ename IN ('SMITH','WARD') );
        
--NOT IN


--관리자의 직원정보 조회하기
--1. 관리자인 사람만 조회.
--    . mgr 컬럼에 값이 나오는 직원
SELECT DISTINCT mgr
FROM emp;        
        
--어떤 직원의 관리자인 직원 정보를 조회한 것.
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

--관리자 역할을 하지 않는 평사원 정보 조회
--NOT IN 연산자 사용시 set에 NULL이 포함될 경우 정상적으로 동작하지 않는다.
--NULL처리 함수나 WHERE 절을 통해 NULL값을 처리한 이후 사용
SELECT * 
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,-9999)
                                FROM emp); 
 
 --pair wise
 --사번 7499, 7782인 직원의 관리자, 부서번호 조회
 --7698  30
 --7839  10
 --직원중에 관리자와 부서번호가 (7698, 30)이거나 (7839, 10)인 사람
 --mgr, deptno 컬럼을 동시에 만족시키는 직원정보 조회.
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
        
--SCALAR SUBQUERY : SELECT 절에 등장하는 서브쿼리.(단, 값이 하나의 행, 하나의 컬럼)        
--직원의 소속 부서명을 JOIN을 사용하지 않고 조회
SELECT empno, ename, deptno, (SELECT dname
                                                        FROM dept
                                                        WHERE deptno = emp.deptno) dname
FROM emp;
        
SELECT dname
FROM dept
WHERE deptno = 20;
        
        
 --sub4 데이터 생성
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

--sub5 실습 ppt 247p

SELECT pid, pnm
FROM product
WHERE pid NOT IN (100,400);

SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid --100, 400
                                    FROM cycle
                                    WHERE cid = 1);

--cid가 1인 손님의 애음제품 조회
SELECT pid
FROM cycle
WHERE cid = 1;

--sub6 실습 ppt 248p

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

--EXISTS MAIN 쿼리의 컬럼을 사용해서 SUBQUERY에 만족하는 조건이 있는지 체크
--만족하는 값이 하나라도 존재하면 더이상 진행하지 않고 멈추기 때문에
--성능면에서 유리.

--MGR가 존재하는 직원 조회
SELECT *
 FROM emp a
 WHERE EXISTS (SELECT  'X'
                                    FROM emp
                                    WHERE empno = a.mgr); 
 
 --MGR가 존재하지 않는 직원 조회
 SELECT *
 FROM emp a
 WHERE NOT EXISTS (SELECT  'X'
                                        FROM emp
                                        WHERE empno = a.mgr); 

--sub8실습 ppt 251p
--MGR가 존재하는 직원을 서브쿼리안써서 조회
SELECT *
 FROM emp
 WHERE mgr IS NOT NULL;

--부서에 소속된 직원이 있는 부서정보조회(EXISTS)
SELECT *
 FROM dept
 WHERE EXISTS(SELECT  'X'
                            FROM emp
                             WHERE deptno = dept.deptno);     
        
  SELECT *
 FROM dept --이렇게 IN연산자로도 가능하다.
 WHERE deptno IN (SELECT  deptno
                                 FROM emp); 
                                 
--집합연산
--UNION : 합집합. 중복을 제거
--              DBMS 에서는 중복을 제거하기 위해 데이터를 정렬
--              (대량의 데이터에 대해 정렬 시 부하.)
--UNION ALL : UNION과 같은개념.
--                      중복을 제거하지 않고, 위 아래 집합을 결합. => 중복가능
--                      위아래 집합에 중복되는 데이터가 없다는 것을 확신하면
--                      UNION 연산자보다 성능면에서 유리.
--사번이 7566 또는 7698인 사원 조회.(사번, 이름만 조회)
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION
--사번이 7369, 7499인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno = 7369 OR empno = 7499;


--UNION ALL (중복 허용, 위 아래 집합을 합치기만 함.)
SELECT empno, ename
FROM emp
WHERE empno = 7566 OR empno = 7698

UNION ALL

SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno = 7698;
--WHERE empno = 7369 OR empno = 7499;

--INTERSECT (교집합 : 위 아래 집합간의 공통데이터만 뽑아냄.)
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698,7369)

INTERSECT

SELECT empno, ename
FROM EMP
WHERE empno IN (7566, 7698,7499);


--MINUS (차집합 : 위집합에서 아래 집합을 제거.)
--얘는 순서가있음. 위아래 순서바뀌면 결과가 달라져버림.
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





        
        
        
        
        