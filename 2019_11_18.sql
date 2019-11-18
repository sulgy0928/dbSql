--dictionary
--접두어    USER : 사용자 소유 객체.
--                  ALL  :  사용자가 사용 가능한 객체
--                 DBA  :  관리자 관점의 전체 객체(일반사용자는 사용 불가.)
--                    V$  :  시스템과 관련된 VIEW (일반사용자는 사용 불가)

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN ('PC02', 'HR');

--오라클에서 동일한 SQL이란?
--문자가 하나라도 틀리면 안됨.
--다음 sql들은 같은 결과를 만들어 낼 진 몰라도 DBMS에서는
--서로 다른  SQL로 인식된다.
SELECT /*bind_test*/ * FROM emp;
Select /*bind_test*/* FROM emp;
select /*bind_test*/*  FROM emp;

select /*bind_test*/ * FROM emp WHERE empno = 7369;
select /*bind_test*/ * FROM emp WHERE empno = 7499;
select /*bind_test*/ * FROM emp WHERE empno = 7521;

select /*bind_test*/ * FROM emp WHERE empno =: empno; --시스템에 불필요한 부하를 주지 않기위해 사용.(bind)

SELECT * 
FROM V$SQL ; --system 계정으로 조회 가능.


--도시의 발전수준.
-- (버거킹갯수 + 맥날 갯수+ KFC 갯수)  /  롯데리아 갯수

--sido   경기도
--          강원도
--          대구광역시
--          경상남도
--          경상북도
--          광주광역시
--          부산광역시        --총 2145개의 데이터.
--          서울특별시
--          대전광역시
--          전라남도
--          전라북도
--          울산광역시
--          인천광역시
--          충청남도
--          충청북도
--          제주특별자치도
-- 시도, 시군구 별 매장수가 필요.(버거킹, 맥도날드, KFC) : 
-- 시도, 시군구 별 매장수가 필요.(롯데리아) : 
SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu;

SELECT * FROM fastfood;

SELECT gb,sido,sigungu
FROM fastfood
WHERE sido IN('경기도')
    AND gb IN('버거킹');

--대전 : 중구, 동구 ,서구, 유성구, 대덕구
SELECT sido, sigungu, COUNT(*) cnt
    FROM fastfood
    WHERE gb = '롯데리아'
            AND sido IN('대전')
    GROUP BY sido, sigungu;
















































































