SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp;
  
  
--  * 에스테리크 (WILDCARD ALL을 의미한다)
-- 현업에서 거의안쓰니까 쓰지말자 
  
--SELECT *   
--  FROM EMP;

SELECT * FROM PLAYER;

SELECT  player_id , player_name, position, height, weight
FROM    PLAYER;

--DISTINCT 동일한 데이터 중복출력되지 않도록 한번만 출력하는 키워드

SELECT DISTINCT position
FROM PLAYER
WHERE position IS NOT NULL;

SELECT DISTINCT job FROM EMP;

칼럼명에 별칭(ALIAS) 지정하기
조회된 결과에 일종의 별명을 부여해서 칼럼명을 변경할 수 있다
칼럼명에 대한 사항
- 칼럼명 바로 뒤에 온다
- 칼럼명과 ALIAS 사이에 AS, as 키워드를 사용할 수 있다(option 안쓸경우 묵시적으로 적용)
- 이중 인용부호는 alias가 공백, 특수문자를 포함할 경우와 대소문자 구분이
필요한 경우 사용된다.

SELECT empno AS 사원번호, ename AS 사원명, job AS 직급, mgr AS 상사번호
        ,comm AS 커미션 ,deptno AS 부서번호 ,hiredate AS 입사일 ,sal AS 급여
FROM EMP;

선수테이블에서 선수명, 포지션, 키, 몸무게를 출력하시오

SELECT player_name as 선수명, position as 포지션
        , height as 키, weight as 몸무게
FROM PLAYER;

-- ""를 통해 인용부호나 띄어쓰기나 다 사용가능함 소문자 대문자 구분도 모두 "" 쌍따옴표안에 작성

SELECT player_name "선수 이름", position "선수 포지션", height "키+", weight "Weight"
FROM PLAYER;

desc dept; 

SELECT deptno, dname 부서명
FROM DEPT
WHERE dname = 'SALES';

SELECT *
FROM EMP ORDER BY EMPNO ASC;

--데이터베이스 SQL에서는 함수를 사용해서 반올림,올림,내림처리를함
--반올림 ROUND(반올림할값, 자리수)
--올림 CEIL(올림할값, 자리수)
--내림 TRUNC(내림할값, 자리수)

SELECT empno AS 사원번호, ename AS 사원명, job AS 직급
        , hiredate AS 입사일, ROUND(Sal/12,2) AS 월급, sal AS 연봉
FROM EMP;

SELECT player_name AS 선수명, height AS 키
        , weight AS 몸무게, ROUND(weight/((height/100)*(height/100)),2) AS "BMI 비만지수" FROM PLAYER;

SELECT player_name AS 이름, height AS 키
        , weight AS 몸무게, height - weight "키-몸무게" 
FROM PLAYER;

SELECT *
FROM DEPT;

합성 연산자 || CONCATENATION (CONCAT) 
합성 연산자의 특징
자바로 치면 String +를 생각하면됨 무조건 할줄 알아야됨
-문자와 문자를 연결하는 경우 2개의 수직 바(||)에 의해 이루엊니다
-칼럼과 문자 또는 다른 칼럼과 연결시킬 수 있다
-문자 표현식의 결과에 의해 새로운 칼럼을 생성한다



SELECT DNAME || '은 부서명을 뜻한다'|| ' 그리고 LOC는 위치이다 ' || LOC
FROM DEPT;

다음과 같이 출력
선수명 선수, 키 CM, 몸무게 KG

SELECT player_name || ' 선수' AS 선수명
        , height || 'CM' AS 키, weight || 'KG' AS 체격정보
FROM PLAYER;

SELECT '나의 이름은 ' || ename || ' is a ' || job || ' 직급을 가지고 있습니다.' || '잘 부탁드립니다' AS 사원소개
FROM EMP;
