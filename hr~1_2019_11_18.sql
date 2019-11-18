SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC02';

SELECT *
FROM PC02.V_EMP_DEPT;

--sem 계정에서 조회권한을 받은 V_EMP_DEPT VIEW를 hr계정에서 조회하기 위해서는 
--계정명.view이름 형식으로 기술 해야 한다.
--매번 계정명을 기술하기 귀찮으니 시노님을 통해 다른 별칭을 생성.

CREATE SYNONYM V_EMP_DEPT FOR PC02.V_EMP_DEPT;


--이제 PC02.V_EMP_DEPT 이렇게쓰던걸 -->  V_EMP_DEPT 이렇게만 써주면 된다.
SELECT *
FROM V_EMP_DEPT;

DROP SYNONYM V_EMP_DEPT;

--hr 계정 비밀번호 : java
--hr 계정 비밀번호 변경 : hr
ALTER USER hr identified BY hr; --현재 hr계정으로 접속중이라 성공!
--ALTER USER PC identified BY java; --본인계정으로 접속한게 아니라서 실패 ㅋㅋ






























