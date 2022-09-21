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

-- 다중행 서브쿼리(다중행 비교 연산자)

-- IN(서브쿼리): OR연산 -> 서브쿼리의 결과에 존재하는 임의의 값과 동일한 조건을 의미 

-- ALL(서브쿼리): AND연산 -> 서브쿼리의 결과에 존재하는 모든 값을 만족하는 조건을 의미

-- ANY(서브쿼리): 서브쿼리의 결과에 존재하는 어느 하나의 값이라도 만족하는 조건을 의미 
-- 최소값보다 큰 모든 건이 조건을 만족한다

-- EXISTS(서브쿼리): 서브쿼리의 결과를 만족하는 값이 존재하는지 여부를 확인하는 조건을 의미
-- 조건을 만족하는 건이 여러 건이더라도 1건만 찾으면 더 이상 검색하지 않는다

-- 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와
-- 부서명과 지역을 출력하시오
-- DEPTNO   DNAME   LOC

SELECT deptno, dname, loc
FROM DEPT
WHERE deptno IN (SELECT deptno
                FROM EMP
                WHERE job = 'MANAGER');

SELECT DEPT.deptno, dname, loc, ename, job
FROM DEPT INNER JOIN EMP
ON DEPT.deptno = EMP.deptno
AND job = 'MANAGER';
                      
-- 그 밖의 위치에서 사용하는 서브쿼리
-- (1)SELECT 절에 서브쿼리 사용하기

-- SELECT 절에서 사용하는 서브쿼리인 스칼라 서브쿼리(SCALAR SUBQUERY)
-- 스칼라 서브쿼리는 한 행, 한 칼럼만을 반환하는 서브쿼리를 말한다

-- 선수 정보와 해당 선수가 속한 팀의 평균 키를 함께 출력하시오
-- 선수명, 키, 소속팀의 평균키 (PLAYER A,B로 만들어서 서브쿼리내 조건을 검)
SELECT A.team_id 팀ID, player_name 선수명 , height 키 
        , (SELECT AVG(height) 
            FROM PLAYER B 
            WHERE B.team_id = A.team_id) "소속팀의 평균키"
FROM PLAYER A;

-- (2)FROM 절에서 서브쿼리 사용하기
-- 학문에서는 이를 인라인 뷰 (INLINE VIEW)라고 한다
-- VIEW 뷰 - 가상테이블(실제로 데이터가 존재하는 테이블이 아님)

-- 서브쿼리가 FROM 절에 사용되면 어떻게 될까?
-- 서브쿼리의 결과가 마치 실행 시에 #동적#으로 생성된 테이블인 것처럼 사용 할 수 있다
-- 인라인 뷰는 SQL문이 실행 될 때만 임시적으로 생성되는 동적인 뷰이기 때문에
-- 데이터베이스에 해당 정보가 저장되지 않는다 (VIEW 뷰 생각하면 됨 실제로 존재하는 테이블은 아님)
-- 일반적인 뷰를 정적 뷰 (STATIC VIEW) 라고 하고
-- 인라인 뷰를 동적 뷰 (DYNAMIC VIEW) 라고도 한다
-- 원하는 정보를 조회하는 실제 DB에 저장되지 않는 가상의 테이블을 생성 할 수 있다

-- 인라인 뷰는 테이블 명이 올 수 있는 곳에서 사용 할 수 있다

SELECT empno, ename, sal, hiredate
FROM EMP;

SELECT * 
FROM (SELECT empno, ename, sal, hiredate
        FROM EMP);
        
-- 사원의 번호와 이름 입사일 급여, 부서번호와 부서명을 조회
-- 단 직업은 CLERK인 사람만 (INLINE VIEW를 사용)

SELECT EMP.*
FROM (SELECT EMP.*, DEPT.dname, DEPT.loc
        FROM EMP INNER JOIN DEPT
          ON EMP.deptno = DEPT.deptno
       WHERE job = 'CLERK') EMP;
       
-- 사원 중에 가장 오래 다닌 직원부터 차례대로 출력(INLINE VIEW 활용)
SELECT EMPH.*
FROM (SELECT empno, ename, hiredate
        FROM EMP
       ORDER BY hiredate ASC) EMPH;       

SELECT * FROM SALGRADE;

-- 급여 등급추가로 확인 ( INLINE VIEW로 만든 테이블에도 JOIN 가능하다)
SELECT EMP.*, SALGRADE.grade
FROM (SELECT EMP.*, DEPT.dname, DEPT.loc
        FROM EMP INNER JOIN DEPT
          ON EMP.deptno = DEPT.deptno            
       WHERE job = 'CLERK') EMP INNER JOIN SALGRADE
          ON EMP.sal >= SALGRADE.LOSAL 
         AND EMP.sal <= SALGRADE.HISAL;    
         
-- K리그 선수들 중에서 포지션이 (MF)인 선수들의 소속팀명 및 선수정보 출력

-- (1.인라인뷰 + 다른 테이블 조인)
SELECT T.team_name 팀명, PL.player_name 선수명, PL.back_no 백넘버
FROM (SELECT player_name, back_no, team_id 
        FROM PLAYER
       WHERE position = 'MF') PL INNER JOIN TEAM T
          ON PL.team_id = T.team_id
ORDER BY 선수명;
--ORDER BY PL.player_name;

-- (2.인라인뷰 내부에 조인까지)
SELECT PL.*, PL.team_name, PL.player_name, PL.back_no
FROM (SELECT T.team_name, P.player_name, P.back_no
        FROM PLAYER P INNER JOIN TEAM T
          ON P.team_id = T.team_id
       WHERE position = 'MF'
       ORDER BY P.player_name ASC) PL;
          
SELECT * FROM EMP;          

-- 사원들 중에 급여를 가장 많이 받는 사원을 순서대로 3명만 출력하시오 (상위 3명 출력 RANK)
-- 모든 칼럼 출력 -> 회사에서는 모든 칼럼 출력은 (*) 애스트리크 <- 안씀 (즉 칼럼을 일일이 전부 명시해라)

-- INLINE VIEW와 ROWNUM을 통해 TOP-N 개념, 쿼리 -> 등급, 랭크를 구현
-- ROWNUM - 특정 원하는 개수의 행만 조회, 행번호 매기기 (가상칼럼) 
-- ROWNUM은 처음에 데이터를 INSERT할때 순서대로 부여되기 때문에 ORDER BY(정렬)가 들어가면 순서가 흐트러진다
-- 그러므로 INLINE VIEW를 통해서 정렬을 해준다 
-- 또한 ROWNUM은 무조건 1부터 시작해야 하기 때문에 중간 ~ 역순등 특정 구역부터 값을 구하기 위해서는
-- INLINE VIEW를 같이 사용한다
-- 실행순서 (1)FROM -> (2)WHERE ROWNUM(가상칼럼 SUDO COLUMN) ROWNUM은 디폴트값으로 데이터 1을 가지고있다

SELECT EMPS.empno, EMPS.ename, EMPS.job, EMPS.mgr
        , EMPS.hiredate, EMPS.sal, EMPS.comm, EMPS.deptno, ROWNUM||'번' , RM||'번' "EMPS의 ROWNUM"
FROM (SELECT ROWNUM RM, empno, ename, job, mgr, hiredate, sal, comm, deptno
        FROM EMP       
       ORDER BY SAL DESC) EMPS
WHERE ROWNUM <= 3;

-- 선수들 중에서 키가 NULL이 아닌 선수들 중에
-- 키가 가장 큰 순으로 5명의 선수들의 정보를 출력하시오

SELECT PL.player_name 선수명, PL.position 포지션, PL.height 키
FROM (SELECT P.player_name, P.position, P.height
        FROM PLAYER P
        WHERE P.height IS NOT NULL
        ORDER BY P.height DESC) PL
WHERE ROWNUM <= 5;

-- VIEW(뷰) - 가상테이블(실존X)
-- 테이블은 실제로 가지고 있는 반면 뷰는 실제 데이터를 가지고 있지 않다
-- VIEW(뷰)는 단지 뷰 정의(VIEW DIFINITION)만을 가지고 있다
-- 질의에서 VIEW(뷰)가 사용되면 뷰 정의를 참조해서 DBMS 내부적으로
-- 질의를 재작성하여 질의를 수행한다
-- 뷰는 실제 데이터를 가지고 있지 않지만 테이블이 수행하는
-- 역할을 수행하기 때문에 가상 테이블(VIRTUAL TABLE)이라고도 한다
-- 생성시 테이블과 다르게 CREATE OR REPLACE를 사용(생성 또는 교체)

-- VIEW(뷰) 사용의 장점
-- (1)독립성:         테이블 구조가 변경되어도 뷰(VIEW)를 사용하는 
--                   응용 프로그램은 변경되지 않아도 된다

-- (2)편리성:         복잡한 질의를 VIEW(뷰)로 생성함으로써 관련 질의를 
--                   단순하게 작성 할 수 있다. 또한 해당 형태의 SQL문을 자주
--                   사용할 때 뷰를 이용하면 편리하게 사용 할 수 있다

-- (3)보안성:         직원의 급여정보와 같이 숨기고 싶은 정보가 존재한다면,
--                   VIEW(뷰)를 생성할 때 해당 칼럼을 빼고 생성함으로써 사용자에게
--                   정보를 감출 수 있다

-- ##VIEW(뷰)를 사용하는 이유##
-- 복잡하고 긴 쿼리문을 VIEW(뷰)로 정의하면 접근을 단순화 할 수 있고 보안에 유리하다
-- 예를들어 30번부서인 사원정보를 자주사용한다면? 뷰로만들어서 쓰면 단순화가능

-- 형식 (AS를 통해 복사함) - 생성(CREATE) 하거나(OR) 교체(REPLACE)
-- CREATE OR REPLACE VIEW 뷰이름
-- AS
-- SELECT 문장;

-- SCOTT에게 VIEW를 만들 권한이 없어요 (권한 불충분)
-- 권한이 불충분 하다라고 뜬다면? 
-- GRANT CREATE VIEW TO SCOTT; 뷰생성 권한을 줌
-- GRANT DBA TO SCOTT (SYSTEM계정으로) 근데 지금은 임시로 DBA권한 줬음 (이럴일없음)
-- ORA-01031: insufficient privileges (권한없다는 오류)
-- 01031. 00000 -  "insufficient privileges"

-- 30번 부서에 소속된 사원들의 사번,사원명,급여,부서번호를 갖는 뷰 (가상테이블)
-- 해당 사항을 자주 검색시 만들어서 사용

-- 만들어져 있으면 교체한다 (CREATE OR REPLACE)
-- 기존뷰를 생성하거나 교체하는걸 기본으로 사용
CREATE OR REPLACE VIEW EMP_VIEW30
AS
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 30;

-- 생성한 VIEW 조회 (DDL SELECT)
-- SQL DEVELOPER에서 뷰 항목에 존재한다 뷰는 읽기전용 (READ ONLY)
SELECT EMP_VIEW30.*
FROM EMP_VIEW30;

DESC EMP_VIEW30;

-- VIEW 전체조회
SELECT *
FROM USER_VIEWS;

-- VIEW의 내용(TEXT), 목록 조회
SELECT TEXT, VIEW_NAME
FROM USER_VIEWS;

-- CONSTRAINTS 제약조건 전체조회
SELECT *
FROM USER_CONSTRAINTS;

-- 각 부서별 총급여 합계와 총급여 평균을  부서번호가 높은 순인 VIEW를 생성
-- 에러 ORA-00998 해결법 (칼럼명 정의) 
-- CREATE AS~는 SELECT 결과로 나오는 데이터를 가지고 바로 EMP_VIEW_SAL 뷰를
-- 만드는 것인데 이때 컬럼명을 따로 지정하지 않았기 때문에 AS 칼럼명을 지정해줘야한다

CREATE OR REPLACE VIEW EMP_VIEW_SAL
AS
SELECT EMP.deptno, SUM(EMP.sal) "SalSum", AVG(EMP.sal) "SalAvg"
FROM EMP
GROUP BY EMP.deptno
ORDER BY EMP.deptno DESC;

-- 프로시저(PROCEDURE)
-- 개발자가 자주 실행해야 하는 로직을 절차적인 언어를
-- 이용하여 작성한 프로그램 #모듈#이다 (함수나 메소드랑 비슷)
-- 필요할 때 호출하여 실행 할 수 있다
-- 프로시저는 ROLLBACK이 가능하다 (물론 프로시저 내부에 COMMIT 있으면 불가함)
 
-- 오라클은 사용자가 만든 PL/SQL문을
-- 데이터베이스에 저장할 수 있도록
-- 프로시저라는 것을 제공한다

-- 매개변수, 데이터타입, 매개변수2, 데이터타입2 자바의 메소드(함수) 만드는거같음
-- 함수(매개변수1,매개변수2) 사용할때 함수(인수1,인수2)
 
-- 형식
-- CREATE OR REPLACE PROCEDURE 프로시저명(argument1 data_type
-- ,argument2 data_type, ,,,)
-- 
-- IS
--      LOCAL_VARIABLE DECLATION
-- BEGIN
--      STATEMENT1; 실제 수행될 로직들 1
--      STATEMENT2; 실제 수행될 로직들 2
--    ,,,
-- EXCEPTION -- 예외처리도 존재함
--    ,,,
-- END;
-- /    -- (/)는 PL/SQL에서 실행문임(RUN)

-- 프로시저 예제
-- 프로시저를 이용해서 테이블(DEPT01) 데이터 삭제 기능을 만들어볼것이다
-- 명명규칙 (프로시저기능_PROC (프로시저약자)로 끝남 대부분)
-- DEPT01을 삭제하는 프로시저 생성(컴파일) - 컴파일 후 사용을 해야 적용된다
-- DELETE - 테이블 내용을 삭제/ DROP - 테이블 자체를 삭제
CREATE OR REPLACE PROCEDURE DEL_DEPT_PROC
IS
BEGIN
    DELETE FROM DEPT01;
END;
/

-----
-- AS를 통해 EMP01에 EMP 데이터를 복사해서 생성 (백업생성)
CREATE TABLE EMP01
AS
SELECT EMP.*
FROM EMP;
-----

-- EMP01
CREATE OR REPLACE PROCEDURE DEL_EMP01_PROC
IS
BEGIN
    DELETE FROM EMP01;
END;
/

-- 프로시저 실행시 EXECUTE 프로시저명
EXECUTE DEL_DEPT_PROC;

EXECUTE DEL_EMP01_PROC;

-- argument가 있는 프로시저 예제 연습용 테이블
CREATE TABLE TEST_DEPT
AS
SELECT DEPT.*
FROM DEPT
WHERE 1 = 0; -- 공집합 항상거짓임 즉 데이터가 빈 테이블을 복사해서 생성함

-- PL/SQL에서는 (:=) 이 대입연산자임
-- argument가 있는 프로시저 예제
CREATE OR REPLACE PROCEDURE TEST_DEPT_INSERT_PROC(
    V_DEPTNO IN NUMBER, -- argument, datatype
    V_DNAME IN VARCHAR2,
    V_LOC IN VARCHAR2,
    V_RESULT OUT VARCHAR2
)
IS
    CNT NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM TEST_DEPT
    WHERE DEPTNO = V_DEPTNO
    AND ROWNUM = 1;
    
    IF CNT > 0 THEN
        V_RESULT := '이미 등록된 부서번호입니다';
    ELSE
        INSERT INTO TEST_DEPT
        (DEPTNO, DNAME, LOC)
        VALUES(V_DEPTNO, V_DNAME, V_LOC);
        COMMIT;
        V_RESULT := '입력 완료!!';
    END IF;    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        V_RESULT := 'ERROR 발생!';
END;
/

SELECT *
FROM TEST_DEPT;

SELECT *
FROM DEPT;

-- TEST_DEPT_INSERT_PROC 프로시저 실행
-- PL/SQL는 스크립트 출력이라 알아보기 좀 힘듬 변수선언
VARIABLE RSLT VARCHAR2(40); -- '이미 등록된 부서번호입니다'; VARCHAR2(30)으론 작아서 안나왔음

-- EXECUTE 약자 EXEC로도 실행됨
EXECUTE TEST_DEPT_INSERT_PROC(10, 'ACCOUNTING', 'NEW YORK', :RSLT);
EXEC TEST_DEPT_INSERT_PROC(20, 'RESEARCH', 'DALLAS', :RSLT);

PRINT RSLT;

-- SEQUENCE(시퀀스)의 개념과 SEQUENCE(시퀀스) 생성 SEQUENCE = 순차!
-- 오라클에서는 행을 구분하기 위해 PRIMARY KEY(기본키)를 두고 있다
-- 기본 키는 중복된 값을 가질 수 없으므로
-- 항상 유일한 값을 가져야 한다
-- 기본키가 유일한 값을 갖도록 사용자가 직접 값을
-- 생성하려면 부담이 클 것이다
-- 시퀀스는 테이블 내의 유일한 숫자를 ##자동##으로 생성하는
-- 자동 번호 발생기이므로 시퀀스를 기본 키로 사용하면
-- 사용자의 부담을 줄일 수 있다

-- EXPRESSION (표현)
-- CREATE SEQUENCE 시퀀스명 -- 시퀀스명 명명규칙: 테이블명_칼럼명_SEQ(시퀀스)
-- START WITH 1     - 시퀀스 번호의 시작값을 지정할 때 사용한다 (1부터 시작)
-- INCREMENT BY 1   - 연속적인 시퀀스의 번호의 증가치를 지정할떄 사용한다 (1씩 증가)
-- MINVALUE 1       - 시퀀스가 가질 수 있는 최소값을 지정한다(특별한경우만 설정 한번 지정하면 못바꿈)
-- MAXVALUE 100     - 시퀀스가 가질 수 있는 최대값을 지정한다(특별한경우만 설정 한번 지정하면 못바꿈)
-- 등등;

-- ##MINVALUE나 MAXVALUE는 특별한 경우가 아닌한 설정하지 않는다##

-- NEXTVAL (다음값), CURRVAL (현재값)
-- 유일한 값을 얻는 방법 (시퀀스)
-- (1)1씩 증가한다 (1 - 2 - 3 - 4 - 5 - 6 - 7 ...)
-- (2)절대 숫자는 내려가지 않는다

-- 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원보다
-- 더 많은 급여를 받는 사람의 이름과 직급을 출력하시오

SELECT ename, sal
FROM EMP
WHERE sal > (SELECT MAX(SAL)
               FROM EMP
              WHERE deptno = 30);

-- 에러임 서브쿼리의 SAL의 결과가 여러개이므로              
-- 이것을 ALL을 통해서 한개의 결과(쿼리결과의 최대값 한개만 남음)
-- 그러므로 WHERE 칼럼 (연산식) ALL 이렇게 표현하는것
SELECT ename, sal
FROM EMP
WHERE sal >    (SELECT SAL
                  FROM EMP
                 WHERE deptno = 30);                            

-- ALL (모든것보다 크다 AND조건)
-- 즉 deptno = 30에서 최고값인 2850을 찾아서 (1개의 값만 남음)
-- 이 값을 sal과 비교하게 되는것
SELECT ename, sal
FROM EMP
WHERE sal > ALL(SELECT SAL
                  FROM EMP
                 WHERE deptno = 30);    

-- ANY는 아무거나
SELECT ename, sal
FROM EMP
WHERE sal > ANY(SELECT SAL
                  FROM EMP
                 WHERE deptno = 30);              
              
SELECT ename, sal
FROM EMP
WHERE sal > (SELECT MAX(SAL)
               FROM EMP
              WHERE deptno = (SELECT deptno
                                FROM DEPT
                               WHERE dname = 'SALES'));                                          