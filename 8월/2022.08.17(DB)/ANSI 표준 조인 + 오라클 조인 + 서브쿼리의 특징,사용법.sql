-- OUTER JOIN (외부 조인)
-- 2개 이상의 테이블이 조인될 때 어느 한 쪽의 테이블에는
-- 해당하는 데이터가 존재하는데 다른 쪽 테이블에는
-- 데이터가 존재하지 않는 경우 그 데이터는 출력되지 않는 문제를
-- 해결하기 위해서 사용되는 조인 기법이다

-- INNER JOIN과 대비하여 JOIN 조건에서 동일한 값이 없는
-- 행도 반환할 때 사용 할 수 있다

SELECT EE.ename 직원명, MA.ename 상사명
FROM EMP EE, EMP MA
WHERE EE.mgr = MA.empno;

-- 동등조인 KING은 상사가 없어서 조회되지 않는다
-- 외부조인을 통해 출력함 (+) 
-- 아우터 조인을 할 테이블(EMP MA)에 (+)기호를 적는다
-- (+)위치는 데이터가 부족한 컬럼의 이름 뒤에 붙인다

SELECT EE.ename 직원명, MA.ename 상사명
FROM EMP EE, EMP MA
WHERE EE.mgr = MA.empno(+);

-- 외부조인은 null도 매칭할수 있게 해준다
-- (+)위치에 따라 누락된 정보를 찾는 방식이 달라진다
-- 이경우 18개의 데이터가 조회됨
SELECT EE.ename 직원명, MA.ename 상사명
FROM EMP EE, EMP MA
WHERE EE.mgr(+) = MA.empno;

SELECT EE.ename 직원명, MA.ename 상사명
FROM EMP EE
LEFT JOIN EMP MA
ON EE.mgr = MA.empno;

-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만
-- 40번 부서의 이름도 출력되도록 쿼리문을 작성하시오

SELECT E.ename 사원명, D.deptno 부서번호, D.dname 부서명
FROM DEPT D, EMP E
WHERE D.deptno = E.deptno(+)
ORDER BY D.deptno ASC;

-- (+)를 통해 일치하지않는 즉 EMP테이블에 deptno가 40인 데이터가 없으므로
-- 해당 데이터가 null이 나오고 deptno가 40인 dname이출력이 된다. (부서가 부족하므로 부서에 OUTER JOING (+))
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DEPTNO;

-- 여기서는 DEPTNO가 NULL인 KING과 WARD가 나오게된다. (사원이 부족하므로 사원에 OUTER JOIN (+))
-- 즉 OUTER JOIN은 서로 조인이 안된것에 대해 한쪽에 있는 모든 정보를 억지로 NULL을 통해서 보여준다
SELECT E.ENAME, E.DEPTNO, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+)
ORDER BY D.DEPTNO;

-- ANSI JOIN (표준 조인)
-- 국내뿐만 아니라 전 세계적으로 많이 사용되고 있는 관계형
-- 데이터베이스 경우 오브젝트 개념을 포함한 여러 새로운 기능들이
-- 꾸준히 개발되고 있다.
-- 다양한 데이터베이스가 각자의 문법을 사용하여
-- 용어의 차이가 너무 커져서 상호 호환성이나 SQL 학습 효율이
-- 많이 부족한 문제가 발생하였다
-- 이를 향후 SQL에서 필요한 기능을 정리하고 호환 가능한 여러 기준을
-- 제정한 것이 ANSI/ISO SQL이다
-- ANSI에서 표준 기술을 정립하면서 많이 좋아졌다

-- 다른 DBMS와의 호환성을 위해서는 ANSI 조인을 사용하는 것이 좋다
-- ANSI 조인은 지금까지 학습한 SQL 조인보다 더욱 간편하고
-- 완벽한 포괄 조인 지원이 가능하게 되었다.

-- CROSS JOIN (테이블1 * 테이블2 교차곱)
-- WHERE 절을 생략한 채 사용한다

-- 형식
-- 오라클 조인
-- SELECT *
-- FROM 테이블1, 테이블2;
 
-- ANSI 조인
-- SELECT *
-- FROM 테이블1 CROSS JOIN 테이블2;

-- 예제(오라클)
SELECT E.*, D.*
FROM EMP E, DEPT D
ORDER BY ename;

-- 예제(ANSI)
SELECT E.*, D.*
FROM EMP E CROSS JOIN DEPT D;


-- INNER JOIN (내부 조인) 
-- 일반적으로 JOIN을 하면 묵시적으로 INNER JOIN으로 처리된다

-- 예제(오라클) -> WHERE절에 JOIN과 조건이 연결되어 붙는형태
SELECT E.ename, D.dname
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND E.ename = 'SMITH';

-- 예제(ANSI) -> JOIN ~ ON을 사용, 그리고 WHERE에 조건이 붙음
SELECT E.ename, D.dname
FROM EMP E INNER JOIN DEPT D
ON E.deptno = D.deptno
WHERE E.ename = 'SMITH';

-- MANAGER에 속한 사원들의 부서 정보를 출력 (ANSI 표준)
-- 사원번호   사원명   직업    부서번호   부서명
-- 사원명 빠른순서

SELECT E.empno 사원번호, E.ename 사원명, E.job 직업
        ,D.deptno 부서번호, D.dname 부서명
FROM EMP E
INNER JOIN DEPT D
ON D.deptno = E.deptno 
WHERE E.job = 'MANAGER'
ORDER BY E.ename;

-- 매니저 번호가 7698번인 사원들의 이름 및 소속 부서 코드
-- 부서 이름을 찾아라
-- ENAME       MGR      DEPTNO      DNAME

-- ANSI 표준
SELECT E.ename, E.mgr, D.deptno, D.dname
FROM EMP E INNER JOIN DEPT D
ON D.deptno = E.deptno
WHERE E.mgr = 7698;

-- 오라클
SELECT E.ename, E.mgr, D.deptno, D.dname
FROM EMP E, DEPT D
WHERE D.deptno = E.deptno
AND E.mgr = 7698;

-- 팀과 스타디움 테이블을 사용하여
-- 팀이름, 스타디움ID, 스타디움 이름을 조회하시오
-- 팀ID로 오름차순 정렬
-- 팀이름   스타디움ID   스타디움 이름     

-- ANSI 표준
SELECT T.team_name 팀이름, S.stadium_id 스타디움ID, S.stadium_name "스타디움 이름"
FROM TEAM T INNER JOIN STADIUM S
ON T.stadium_id = S.stadium_id
ORDER BY T.team_id;

-- 오라클
SELECT T.team_name 팀이름, S.stadium_id 스타디움ID, S.stadium_name "스타디움 이름"
FROM TEAM T, STADIUM S
WHERE T.stadium_id = S.stadium_id
ORDER BY T.team_id;

-- 다중 테이블 조인(오라클)
SELECT ES.ENAME MYNAME, E.ENAME, D.DNAME
FROM EMP ES, DEPT D, EMP E
WHERE ES.DEPTNO = D.DEPTNO
AND D.DEPTNO = E.DEPTNO
AND ES.ENAME = 'SMITH'
AND ES.ENAME <> E.ENAME;

-- 다중 조인 - ANSI 표준 조인
-- 다중 조인의 경우 조인 순서가 중요하다(처리속도 차이)
SELECT EMP_SMITH.ENAME MYNAME, E.ENAME, D.DNAME
FROM EMP EMP_SMITH INNER JOIN DEPT D
ON EMP_SMITH.DEPTNO = D.DEPTNO
    INNER JOIN EMP E
ON D.DEPTNO = E.DEPTNO
WHERE EMP_SMITH.ENAME = 'SMITH'
AND EMP_SMITH.ENAME <> E.ENAME;

-- GK 포지션의 선수별 연고지명, 팀명, 구장명을 출력하시오
-- 선수명 사전순으로(즉 오름차순)
-- 선수번호 선수명 포지션 연고지명 팀ID 팀명 구장명

-- ANSI 표준
SELECT P.player_id 선수번호, P.player_name 선수명, P.position 포지션
        , T.region_name 연고지명, T.team_id 팀ID, T.team_name 팀명, S.stadium_name 구장명
FROM PLAYER P INNER JOIN TEAM T
ON P.team_id = T.team_id
    INNER JOIN STADIUM S
ON T.stadium_id = S.stadium_id
WHERE P.position = 'GK'
ORDER BY P.player_name;

-- 오라클
SELECT P.player_id 선수번호, P.player_name 선수명, P.position 포지션
        , T.region_name 연고지명, T.team_id 팀ID, T.team_name 팀명, S.stadium_name 구장명
FROM PLAYER P, TEAM T, STADIUM S
WHERE P.team_id = T.team_id
AND T.stadium_id = S.stadium_id
AND P.position = 'GK'
ORDER BY P.player_name;


 SELECT * FROM SCHEDULE;
 
 SELECT * FROM TEAM;
 SELECT * FROM STADIUM;
 
-- ANSI 표준
-- 조건식의 경우 왼쪽에는 연산식 나오면 안됨
-- 기준은 SCHEDULE (다중조인은 기준이 중요 순서)
-- 1)(A-B)>=3 보다는 2)A >= B+3 <- 자바처럼 이렇게 처리하자
SELECT ST.stadium_name 경기장명, ST.stadium_id 경기장ID, SC.sche_date 경기일정
        , HT.team_name 홈팀명 , AT.team_name 상대팀명, SC.home_score 홈팀점수
        , SC.away_score 상대팀점수
FROM SCHEDULE SC INNER JOIN STADIUM ST
ON SC.stadium_id = ST.stadium_id    -- 조인을 함으로써 이제 스타디움의 내용을 가져다 쓸 수 있다
    INNER JOIN TEAM HT
ON SC.hometeam_id = HT.team_id      -- 조인을 함으로써 이제 TEAM의 내용을 가져다 쓸 수 있다
    INNER JOIN TEAM AT
ON SC.awayteam_id = AT.team_id      -- 조인을 함으로써 이제 TEAM의 내용을 가져다 쓸 수 있다
WHERE SC.home_score >= SC.away_score + 3 --home_score - away_score >= 3
ORDER BY ST.stadium_name;

-- 오라클
SELECT ST.stadium_name 경기장명, ST.stadium_id 경기장ID, SC.sche_date 경기일정
        , HT.team_name 홈팀명 , AT.team_name 상대팀명, SC.home_score 홈팀점수
        , SC.away_score 상대팀점수
FROM  SCHEDULE SC, STADIUM ST, TEAM HT, TEAM AT
WHERE SC.stadium_id = ST.stadium_id
AND HT.team_id = SC.hometeam_id
AND AT.team_id = SC.awayteam_id
AND SC.home_score >= SC.away_score + 3
ORDER BY ST.stadium_name;

-- ANSI OUTER JOIN

-- 형식
-- SELECT *
-- FROM TABLE1 [LEFT | RIGHT | FULL] OUTER JOIN TABLE2;

CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14)
);

INSERT INTO DEPT01
VALUES(10, 'ACCOUNTING');

INSERT INTO DEPT01
VALUES(20, 'RESEARCH');

SELECT *
FROM DEPT01;

CREATE TABLE DEPT02(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14)
);


INSERT INTO DEPT02
VALUES(10, 'ACCOUNTING');

INSERT INTO DEPT02
VALUES(30, 'SALES');

SELECT *
FROM DEPT02;

-- ORACLE OUTER JOIN 외부조인
SELECT *
FROM DEPT01 D1, DEPT02 D2
WHERE D1.deptno = D2.deptno(+);

SELECT *
FROM DEPT01 D1, DEPT02 D2
WHERE D1.deptno(+) = D2.deptno;

-- ANSI 표준 OUTER JOIN 외부조인
-- LEFT(즉 DEPT01)의 모든 정보가 보고싶다
-- 부족한 부분은 NULL로 채움
SELECT *
FROM DEPT01 D1 LEFT OUTER JOIN DEPT02 D2
ON D1.deptno = D2.deptno;

-- RIGHT(즉 DEPT02)의 모든 정보가 보고싶다
SELECT *
FROM DEPT01 D1 RIGHT OUTER JOIN DEPT02 D2
ON D1.deptno = D2.deptno;

-- ANSI 표준 FULL OUTER JOIN
-- FULL OUTER JOIN (테이블의 정보를 모두 보고싶다)
-- 즉 각 테이블에 내용 없는 부분을 각각 NULL로 처리하고 정보를 보여준다
SELECT *
FROM DEPT01 D1 FULL OUTER JOIN DEPT02 D2
ON D1.deptno = D2.deptno;

-- STADIUM에 등록된 운동장 중에 홈팀이 없는 경기장이 존재한다
-- 홈팀 없는 경기장의 정보도 출력되게 하시오
-- 경기장ID, 경기장명, 좌석수, 홈ID, 팀명

SELECT * FROM STADIUM;
DESC TEAM;
DESC SCHEDULE;

SELECT ST.stadium_id 경기장ID, ST.stadium_name 경기장명, ST.seat_count 좌석수
        , ST.hometeam_id 홈ID, T.team_name 팀명
FROM STADIUM ST LEFT OUTER JOIN TEAM T
ON ST.hometeam_id = T.team_id
ORDER BY ST.STADIUM_ID DESC;

-- 서브 쿼리(SUB QUERY)
-- 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다

-- 서브쿼리 구조
-- SELECT ...                     -- 메인쿼리
-- FROM ...
-- WHERE ... ( SELECT ...         -- 서브쿼리
--               FROM ...
--               WHERE ...
--            );
-- 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다

-- 서브쿼리를 사용할 때 주의사항
-- 1. 서브쿼리를 괄호로 감싸서 사용한다
-- 2. 서브쿼리는 단일 행 또는 복수 행 비교 연산자와 함께 사용이 가능하다
-- 단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고
-- 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다
-- 3. 서브쿼리에서는 ORDER BY를 사용하지 못한다.
-- ORDER BY 절은 SELECT 절에서 오직 한 개만 올 수 있기 때문에
-- ORDER BY 절은 메인쿼리의 마지막 문장에 위치해야 한다
-- 4. 서브쿼리는 메인 쿼리가 실행되기 이전에 한 번만 실행이 된다

-- 서브쿼리가 SQL문에서 사용이 가능한 곳
-- (1)SELECT 절
-- (2)FROM 절
-- (3)WHERE 절
-- (4)HAVING 절
-- (5)ORDER BY 절
-- (6)INSERT문의 VALUES 절
-- (7)UPDATE문의 SET 절
 
-- 서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류된다
-- 서브쿼리의 종류           설명
-- (1)비연관 서브쿼리        서브쿼리가 메인쿼리 칼럼을 가지고 있지 않는 형태
--                         메인쿼리에 값을 제공하기 위한 목적으로 주로 사용한다 

-- (2)연관 서브쿼리          서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리
--                         일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를
--                         서브쿼리에서 조건이 맞는지 확인하고자 할 때 주로 사용

-- 반환되는 데이터의 형태에 따른 서브쿼리 종류
-- 서브쿼리의 종류           설명
-- (1)단일행 서브쿼리        서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미
--                         단일행 비교 연산자 (=,<,<=,>,>=,<>) 등과 함께 사용된다. 

-- (2)다중행 서브쿼리        서브쿼리의 실행결과가 여러 건인 서브쿼리를 의미
--                         다중행 비교 연산자 (IN,ALL,ANY,SOME) 등과 함께 사용된다.

-- (3)다중칼럼 서브쿼리      서브쿼리의 실행 결과로 여러 칼럼을 반환한다. 메인쿼리의 조건절에
--                        여러 칼럼을 동시에 비교 할 수 있다. 서브쿼리와 메인쿼리에서 비교하고자
--                        하는 칼럼 개수와 칼럼의 위치가 동일해야 한다

-- WHERE절에 사용한 단일행 서브쿼리 예시
-- SMITH 사원의 부서명을 조회
SELECT dname
FROM DEPT
WHERE DEPTNO = (SELECT deptno
                 FROM EMP
                 WHERE ename = 'SMITH');
                 
-- SMITH와 같은 부서에서 근무하는 사원의 이름과 부서번호를 출력
-- ENAME DEPTNO

SELECT ename, deptno
FROM EMP
WHERE DEPTNO = (SELECT deptno
                  FROM EMP
                 WHERE ename = 'SMITH')
AND ename <> 'SMITH';

-- 정남일 선수가 소속된 팀의 선수들에 대한 정보를 표시하시오(단일행 서브쿼리)
-- 선수번호, 선수명, 포지션, 팀ID

-- ORA-01427: single-row subquery returns more than one row
-- 임시로 선수명: 정남일 데이터를 하나 추가로 넣었다
-- 선수명 정남일 데이터가 이제 2개가 조회되므로 에러가 발생한것(단일행 서브쿼리는 무조건 1건 이하 결과만)
SELECT player_id 선수번호, player_name 선수명, position 포지션, team_id 팀ID
FROM PLAYER
WHERE team_id = (SELECT team_id
                   FROM PLAYER
                  WHERE player_name = '정남일')
AND player_name <> '정남일'; -- 정남일을 제외한 정남일 선수 소속된 팀 선수들

DESC PLAYER;

INSERT INTO PLAYER
VALUE(PLAYER_ID, PLAYER_NAME, TEAM_ID)
VALUES(201003, '정남일', 'K07');


SELECT * 
FROM PLAYER 
WHERE player_name = '정남일';

-- 1.WARD와 동일한 직급을 가진 사원을 출력하는 SQL문을 작성하시오
-- 모든 칼럼
SELECT *
FROM EMP
WHERE job = (SELECT job
               FROM EMP
              WHERE ename = 'WARD')
AND ename <> 'WARD';              

-- 2.BLAKE의 급여와 동일하거나 더 많이 받는 사원명과 급여를 출력하시오
-- ENAME, SAL
SELECT ename,sal
FROM EMP
WHERE sal >= (SELECT sal
                FROM EMP
               WHERE ename = 'BLAKE')
AND ename <> 'BLAKE';

-- 3.DALLAS 에서 근무하는 사원의 이름, 부서 번호를 출력
-- EMPNO, ENAME, DEPTNO
SELECT empno, ename, deptno
FROM EMP
WHERE deptno = (SELECT deptno
                  FROM DEPT
                 WHERE loc = 'DALLAS');
                 

-- 4.영업부(SALES) 부서에서 근무하는 모든 사원의 이름과 급여를 출력
-- ENAME      영업부      SAL      
SELECT ename, dname 영업부, sal, 'SALES' 영업부2
FROM EMP
INNER JOIN DEPT
ON EMP.deptno = DEPT.deptno
WHERE EMP.deptno = (SELECT deptno 
                      FROM DEPT
                     WHERE dname = 'SALES');
              
-- 5.자신의 직속상관이 KING인 사원의 이름과 급여를 출력하시오
-- ENAME      SAL                 
SELECT ename, sal
FROM EMP
WHERE mgr = (SELECT empno
               FROM EMP
              WHERE ename = 'KING');
              
SELECT AVG(SAL), ROUND(AVG(SAL))
FROM EMP;

-- 급여가 평균급여보다 높은 사원들의 정보를 조회하시오
SELECT *
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
            FROM EMP
            );
            
-- 축구선수들의 평균키를 이용해서 키가 평균 이하인 선수들의 정보를 출력
-- 선수명  포지션  키 (키가 큰 순으로 정렬 DESC)

SELECT player_name, position, height
FROM PLAYER
WHERE height <= (SELECT AVG(height)
                  FROM PLAYER
                  )
ORDER BY height DESC;

SELECT deptno
FROM EMP
WHERE sal >= 2000;

-- ORA-01427: single-row subquery returns more than one row (단일행이라 에러)
SELECT ename, sal, deptno
FROM EMP
WHERE deptno = (SELECT deptno
                  FROM EMP
                 WHERE sal >= 2000);
                 
-- 다중행 서브쿼리 (다중행 비교 연산자 IN, SOME, ANY, ALL)
SELECT ename, sal, deptno
FROM EMP
WHERE deptno IN (SELECT deptno
                   FROM EMP
                  WHERE sal >= 2000);  
                  
-- 다중행 서브쿼리(다중행 비교 연산자)

-- IN(서브쿼리): OR연산 -> 서브쿼리의 결과에 존재하는 임의의 값과 동일한 조건을 의미 

-- ALL(서브쿼리): AND연산 -> 서브쿼리의 결과에 존재하는 모든 값을 만족하는 조건을 의미

-- ANY(서브쿼리): 서브쿼리의 결과에 존재하는 어느 하나의 값이라도 만족하는 조건을 의미
-- 최소값보다 큰 모든 건이 조건을 만족한다

-- EXISTS(서브쿼리): 서브쿼리의 결과를 만족하는 값이 존재하는지 여부를 확인하는 조건을 의미
-- 조건을 만족하는 건이 여러 건이더라도 1건만 찾으면 더 이상 검색하지 않는다
                  
 SELECT * FROM TEAM;                  
-- 선수들 중 정현수라는 선수가 소속되어 있는 팀 정보를 출력하는 서브쿼리
-- 연고지명 팀명 영문팀명 
SELECT region_name, team_name, e_team_name
FROM TEAM
WHERE team_id IN (SELECT team_id
                    FROM PLAYER
                   WHERE player_name = '정현수');

-- 부서별로 가장 급여를 많이 받는 사원의 정보를 출력
-- 부서번호 높은순
-- 사원번호 사원명 급여 부서번호 (부서별 -> GROUP BY를 써라)
-- 무식한 버전(별. GROUP BY 생각하자)
SELECT empno, ename, sal, deptno
FROM EMP
WHERE SAL IN    ((SELECT MAX(SAL) 
                    FROM EMP 
                   WHERE deptno = 10),
                 (SELECT MAX(SAL) 
                    FROM EMP 
                   WHERE deptno = 20),
                   (SELECT MAX(SAL) 
                    FROM EMP 
                   WHERE deptno = 30),
                   (SELECT MAX(SAL) 
                    FROM EMP 
                   WHERE deptno = 40),
                   (SELECT MAX(SAL) 
                    FROM EMP ))
ORDER BY DEPTNO DESC;

-- 부서별(GROUP BY)를 사용한 버전
SELECT empno, ename, sal, deptno
FROM EMP
WHERE SAL IN (
    SELECT MAX(SAL) 
    FROM EMP 
    WHERE deptno IS NOT NULL -- 안쓰면 NULL 포함
    GROUP BY deptno
    )    
ORDER BY DEPTNO DESC;

SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, DEPTNO 부서번호 
FROM EMP
WHERE SAL IN ( 
    SELECT MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO)
AND DEPTNO IS NOT NULL;

SELECT MAX(SAL)
FROM EMP
GROUP BY deptno
ORDER BY deptno DESC;

-- 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와
-- 부서명과 지역을 출력하시오
-- DEPTNO   DNAME   LOC
SELECT deptno, dname, loc
FROM DEPT
WHERE deptno IN (
        SELECT deptno
        FROM EMP
        WHERE job = 'MANAGER'
);

