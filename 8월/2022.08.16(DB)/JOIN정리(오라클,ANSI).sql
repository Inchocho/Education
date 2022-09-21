-- JOIN
-- 두 개 이상의 테이블들을 연결 또는 결합하여 데이터를 출력하는 것을 JOIN이라고 한다
-- JOIN은 (RDBMS)관계형 데이터베이스의 가장 큰 장점이면서 대표적인 핵심 기능이다
-- 일반적인 경우 행들은 PK나 FK 값의 연관에 의해 JOIN이 성립된다
-- 데이터베이스에서는 데이터가 중복되면 여러 가지 이상 현상이 발생하기 때문에
-- 데이터가 중복되지 않도록 하기 위해서 2개 이상의 테이블로 나누어서 정보를 저장해 놓는다
-- 그래서 원하는 정보를 얻어오려면 여러 개의 테이블을 조인해야 한다

-- 조인의 종류
-- EQUI JOIN(동등 조인)
-- 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 칼럼의 값이
-- 일치되는 행을 연결하여 결과를 얻는 방법이다
-- FROM에 테이블명이 2개이상 들어가면 JOIN임
 
-- SELECT 칼럼명1, 칼럼명2, ,,,
-- FROM 테이블1, 테이블2
-- WHERE 테이블1.칼럼명1 = 테이블2.칼럼명2;

SELECT *
FROM EMP, DEPT  
WHERE EMP.deptno = DEPT.deptno;

-- SELECT column_name(s)
-- FROM table1
-- INNER JOIN table2
-- ON table1.column_name = table2.column_name;
SELECT A.empno, A.ename, B.dname, B.loc
FROM EMP A
JOIN DEPT B -- JOIN으로 명시할 경우 디폴트 INNER JOIN 실행
ON A.deptno = B.deptno
WHERE A.deptno IN (10,20,30);

-- 선수 테이블과 팀 테이블에서(부모 TEAM 자식 PLAYER)
-- 선수 이름과 소속된 팀의 이름을 출력

-- ORA-00918: column ambiguously defined 칼럼이 모호하다(어디서 team_id를 가져와야 될지 모호함)
-- 테이블을 명시해주면 해결됨 TEAM.team_id
-- 모든 SELECT에 들어오는 칼럼에는 테이블명이 묵시적으로 적용된다
-- player_name -> 실제 PLAYER.player_name

SELECT player_name 선수명, team_name 소속팀명, TEAM.team_id 팀아이디
FROM PLAYER, TEAM
WHERE PLAYER.team_id = TEAM.team_id;

-- 테이블에도 별칭을 적용하여 작성
SELECT P.player_name 선수명, T.team_name 소속팀명, T.team_id 팀아이디
FROM PLAYER P, TEAM T
WHERE P.team_id = T.team_id;

SELECT player_name 선수명, team_name 소속팀명
FROM PLAYER a
JOIN TEAM b
ON a.team_id = b.team_id;

-- 조인을 사용하여 뉴욕에서 근무하는 사원의 이름과 급여를 출력
-- 사원번호 사원명 급여 부서위치(사원명 빠른순서)
SELECT E.empno 사원번호, E.ename 사원명, E.sal 급여, D.loc 부서위치
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND D.loc = 'NEW YORK'
ORDER BY E.ename ASC;

-- ACCOUNTING 부서 소속 사원의 이름과 입사일 조회
-- 입사일이 늦은 순으로 조회
-- 입사일은 ??-??-?? 년월일로 나타내시오
-- ENAME    입사일
SELECT E.ename, TO_CHAR(E.hiredate,'YY-MM-DD') 입사일
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND D.dname = 'ACCOUNTING'
ORDER BY hiredate desc;

-- 직급이 MANAGER인 사원의 이름, 부서명을 조회하는 SQL문 작성
-- 부서번호가 빠른 순으로 조회
-- EMPNO ENAME JOB DEPTNO DNAME
SELECT E.empno, E.ename, E.job, D.deptno, D.dname
FROM EMP E, DEPT D
WHERE E.deptno = D.deptno
AND E.job = 'MANAGER'
ORDER BY E.deptno ASC;

DESC TEAM;
SELECT * FROM PLAYER
WHERE player_name LIKE '실%';

-- 실바 선수의 이름, 백넘버, 소속되어 있는 팀명 및 연고지를 알고 싶다
-- 연고지란 REGION_NAME을 의미
-- 선수명 백넘버 팀ID 팀명 연고지

SELECT P.player_name 선수명, P.back_no 백넘버, P.team_id 팀ID
        , T.team_name 팀명, T.region_name 연고지
FROM PLAYER P, TEAM T
WHERE P.team_id = T.team_id
AND P.player_name = '실바';

-- 포지션이 골키퍼인 선수들에 대한 데이터만을 백넘버 순으로 출력하시오
-- 백넘버 번호 느린 순 
SELECT P.team_id 팀ID, P.player_name 선수명
        , P.back_no 백넘버, T.region_name 연고지
FROM PLAYER P, TEAM T
WHERE P.team_id = T.team_id
AND   P.position = 'GK'
ORDER BY P.back_no DESC;

-- NON-EQUI JOIN(비동등 조인)
-- 조건의 특정 범위 내에 있는지를 조사하기 위한 연산자
-- = 이외의 다른 연산자들을 사용한다
-- (>, <, <=, >= 등)

-- 급여에 관련되어 등급제,호봉제를 나타내는 테이블
SELECT * 
FROM SALGRADE;

-- 비동등조인 예시
-- 사원의 급여등급을 표시하시오
SELECT ename, sal, grade
FROM EMP E, SALGRADE S
WHERE SAL BETWEEN LOSAL AND HISAL;

-- 오라클 조인 없이 구하며
-- 급여등급이 높은 값에서 낮은 값으로 출력되게 하시오

SELECT E.ename, E.sal, S.grade
FROM EMP E, SALGRADE S
WHERE E.sal >= S.losal
AND E.sal <= S.hisal
ORDER BY S.grade DESC;

-- 다중 테이블 조인(PLAYER,TEAM,STADIUM 테이블)
-- 최소 테이블 - 1개 이상 조인을 걸어야한다.
-- 즉 현재는 3개 테이블 조인이므로 최소 2번 조인
-- PLAYER - TEAM 조인(team_id) 1번
-- TEAM - STADIUM 조인(stadium_id) 2번

SELECT P.player_name, P.position, T.region_name 연고지
    ,T.team_name, S.stadium_name 구장명
FROM PLAYER P, TEAM T, STADIUM S
WHERE P.team_id = T.team_id
AND T.stadium_id = S.stadium_id;

-- 급여등급에서 이제는 부서명도 출력되게 한다
-- 부서번호 부서명 사원명 급여 급여등급
-- 부서명이 빠른 순으로

SELECT D.deptno 부서번호 , D.dname 부서명
    , E.ename 사원명 , E.sal 급여 , S.grade 급여등급
FROM EMP E, SALGRADE S, DEPT D
WHERE E.deptno = D.deptno
AND E.sal >= S.losal
AND E.sal <= S.hisal
AND E.sal >= 2000 
AND E.sal <= 4000
ORDER BY D.dname ASC;

-- SELF JOIN(셀프 조인)
-- 자기 자신과 조인을 맺는 것
-- 잘 사용 안함(애매하면 피해)

-- 조건: 사원의 매니저번호(사원테이블 EMPLOYEE.MGR)가 사원의 번호(사원테이블 MANAGER.EMPNO)인 데이터
-- 조회 사원의 모든정보(EMPLOYEE.*), EMPLOYEE의 사원명 + 의 매니저 + MANAGER의 사원명
-- EMPLOYEE의 ename은 MGR(매니저번호)가 MANAGER의 EMPNO(사원번호)인 사원명 데이터 
-- MANAGER의 ename에는 EMPLOYEE의 매니저번호가 empno인 데이터
-- EMPLOYEE.mgr = MANAGER.empno 그러므로 매니저번호가 null인 KING이 안나옴
-- 즉 하나의 테이블 EMP 에서 고용테이블과 매니저테이블을 분리하여서 원하는 조건의 데이터를 사용한다

SELECT EMPLOYEE.*, EMPLOYEE.ename || '의 매니저' || MANAGER.ename "직원과 상사 관계"
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.mgr = MANAGER.empno
ORDER BY EMPLOYEE.empno ASC;

-- 매니저가 KING인 사원들의 이름과 직급을 출력하시오 (사원번호 7839)
-- 상사번호 상사명 사원번호 사원명 사원직급

SELECT MANAGER.empno 상사번호, MANAGER.ename 상사명
    , EMPLOYEE.empno 사원번호, EMPLOYEE.ename 사원명, EMPLOYEE.job 사원직급    
FROM EMP EMPLOYEE, EMP MANAGER
WHERE EMPLOYEE.mgr = MANAGER.empno
AND MANAGER.ename = 'KING';

-- SMITH와 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
SELECT A.ename "Myname", B.ename "Ename"
FROM EMP A, EMP B, DEPT D
WHERE A.deptno = D.deptno
AND A.deptno = B.deptno
AND A.ename = 'SMITH'
AND B.ename <> 'SMITH';

-- SMITH와 동일한 근무지에서 근무하는 사원의 이름 + 근무지를 출력하시오
SELECT MY_INFO.ENAME "MyName", FRIEND.ENAME, D.DNAME
FROM EMP MY_INFO, DEPT D, EMP FRIEND
WHERE D.deptno = MY_INFO.deptno 
AND MY_INFO.DEPTNO = FRIEND.DEPTNO   
AND MY_INFO.ENAME = 'SMITH'
AND FRIEND.ENAME <> 'SMITH';


SELECT es.ename MyName, e.ename, d.dname
from emp es, emp e, dept d
where es.deptno = d.deptno
AND e.deptno = d.deptno
AND es.deptno = e.deptno
and es.ename = 'SMITH'
and es.ename <> e.ename;