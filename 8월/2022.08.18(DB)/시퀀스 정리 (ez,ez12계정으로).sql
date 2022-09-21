SELECT empno, ename, sal
FROM EMP;

CREATE TABLE PRI_EMP
AS
SELECT empno, ename, sal, job
FROM EMP;

ALTER TABLE PRI_EMP ADD job VARCHAR2(9);

SELECT *
FROM PRI_EMP;

-- PRI_EMP의 empno를 PRIMARY KEY(기본키)로 등록
ALTER TABLE PRI_EMP 
ADD CONSTRAINT PRI_EMP_EMPNO PRIMARY KEY(empno);

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'PRI_EMP';

-- 사원번호 추가 7935,7936,7937
-- 일일이 추가하는거 귀찮음 자동화를 하자 -> SEQUENCE(시퀀스)의 탄생 순차
-- 숫자(리터럴값)에 의존하지 않고 객체지향적으로 시퀀스명.NEXTVAL을 통해 사용한다

INSERT INTO PRI_EMP
VALUES(7935,'김똘똘',6000,'POLICE');

INSERT INTO PRI_EMP
VALUES(7936,'최똘똘',7000,'TRADER');

INSERT INTO PRI_EMP
VALUES(7937,'박똘똘',8000,'ANALYST');

CREATE SEQUENCE PRI_EMP_empno_SEQ
    START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100;

CREATE SEQUENCE PRI_EMP_empno_SEQ2
    START WITH 7935
INCREMENT BY 1;

INSERT INTO PRI_EMP
VALUES(PRI_EMP_empno_SEQ2.NEXTVAL,'김똘똘',6000,'POLICE');

INSERT INTO PRI_EMP
VALUES(PRI_EMP_empno_SEQ2.NEXTVAL,'최똘똘',7000,'TRADER');

INSERT INTO PRI_EMP
VALUES(PRI_EMP_empno_SEQ2.NEXTVAL,'박똘똘',8000,'ANALYST');

SELECT *
FROM PRI_EMP;

ROLLBACK;

SELECT MAX(empno)
FROM PRI_EMP;

SELECT *
FROM USER_SEQUENCES;

CREATE SEQUENCE DUAL_TEST_SEQ 
    START WITH 1
INCREMENT BY 10
MAXVALUE 50;

-- ORA-08004: sequence DUAL_TEST_SEQ.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- NEXTVAL이 MAXVALUE 최대값을 넘어가는경우 에러
SELECT DUAL_TEST_SEQ.NEXTVAL 다음값, 1
FROM DUAL;

SELECT DUAL_TEST_SEQ.CURRVAL 현재값, 2 -- CURRVAL (CURRENT VALUE 현재값)
FROM DUAL;

-- 부서가 SALES 사원들만 삭제하시오
DELETE FROM EMP
WHERE deptno IN (SELECT deptno
                   FROM DEPT
                  WHERE dname = 'SALES');

-- 사원테이블에서 부서가 SALES인 사원들을 모두 찾으시오
SELECT EMP.*
FROM EMP
WHERE deptno = (SELECT deptno
                FROM DEPT
                WHERE dname = 'SALES');

SELECT EMP.*, DEPT.dname 
FROM EMP INNER JOIN DEPT
ON EMP.deptno = DEPT.deptno
WHERE EMP.deptno = (SELECT deptno
                      FROM DEPT
                     WHERE dname = 'SALES');

ROLLBACK;                

