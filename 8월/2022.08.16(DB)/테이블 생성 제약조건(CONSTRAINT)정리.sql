CREATE TABLE EMP05(
    EMPNO   NUMBER(4) CONSTRAINT EMP05_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10) CONSTRAINT EMP05_ENAME_NN NOT NULL,
    JOB     VARCHAR2(9),
    DEPTNO  NUMBER(2)
);

INSERT INTO EMP05
VALUE(EMPNO, ENAME, JOB, DEPTNO)
VALUES(7499, 'ALLEN', 'SALESMAN', 30);

DESC EMP05;

SELECT *
FROM USER_CONSTRAINTS;

SELECT * FROM EMP05;



-- 오류 보고 
-- ORA-00001: unique constraint (EZ.EMP05_EMPNO_PK) violated
-- EMPNO는 PRIMARY KEY(기본키) 이므로 중복불가능
INSERT INTO EMP05
VALUE(EMPNO, ENAME, JOB, DEPTNO)
VALUES(7499, 'JONE', 'MANAGER', 20);

-- 오류 보고 
-- ORA-01400: cannot insert NULL into ("EZ"."EMP05"."EMPNO")
-- EMPNO는 PRIMARY KEY(기본키)를 구성하는 컬럼에는 NULL을 입력할 수 없다
INSERT INTO EMP05
VALUE(EMPNO, ENAME, JOB, DEPTNO)
VALUES(NULL, 'JONE', 'MANAGER', 20);

-- DEPT 테이블의 구조를 따라하되
-- DEPTNO를 기본키로 지정하시오
-- EXAM_DEPT숫자 형태로 생성하시오
DESC DEPT;

CREATE TABLE EXAM_DEPT_01(
    DEPTNO  NUMBER(2) CONSTRAINT DEPT_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);

SELECT * FROM EXAM_DEPT_01;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EXAM_DEPT_01';

-- 참조 무결성 제약 조건 FOREIGN KEY(외래키)
-- 외래키 값은 NULL이거나 참조하는 릴레이션의 기본키 값과 동일해야 한다

-- FOREIGN KEY(외래키)
-- 관계형 데이터베이스에서 테이블 간의 관계를 정의하기 위해 기본키를 다른 테이블의
-- 외래키로 복사하는 경우 외래키가 생성된다
-- 부모 자식의 관계를 생성한다

-- 오류 보고 
-- ORA-02270: no matching unique or primary key for this column-list
-- ORA-02264: name already used by an existing constraint(CONSTRAINT ~~~ 제약조건명이 중복되면 안됨)
-- FOREIGN KEY(외래키) 다른 테이블(DEPT06)의 기본키(DEPTNO)를 사용하므로 아직 다른테이블(DEPT06)이 없기 때문에 생성시 에러

-- FOREIGN KEY(외래키) 형식 
-- DEPTNO NUMBER(2) CONSTRAINT 외래키명 REFERENCES 참조할 테이블명(참조할 테이블의 기본키 칼럼)
-- DEPTNO NUMBER(2) CONSTRAINT EMP06_DEPT06_NO_FK(외래키명) REFERENCES DEPT06(DEPTNO)(참조할 테이블과 기본키칼럼)

-- PRIMARY KEY(기본키) 칼럼의 기본적인 특징
-- 숫자 영어 형태
-- 1234321421, ASDADFGSDG, COM_12314
-- 기본적으로 일련번호형태를 사용함(주민등록번호)
-- 예제로는 DEPTNO의 부서번호 DEPTNO를 사용함

-- 테이블 생성 이후 제약조건 추가 ALTER ADD
-- 테이블 생성 이후 제약조건 삭제 ALTER DROP

-- 테이블 생성 이후 제약조건을 추가하는 방법(PRIMARY KEY)
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건(칼럼명);
-- ALTER TABLE DEPT07
-- ADD CONSTRAINT DEPT07_DEPTNO_PK PRIMARY KEY(DEPTNO);

-- 테이블 생성 이후 제약조건을 추가하는 방법(FOREIGN KEY)
-- ALTER TABLE 테이블명
-- ADD CONSTRAINT 제약조건명
-- FOREIGN KEY(칼럼명)REFERENCES 부모테이블명(부모테이블 기본키칼럼명);


CREATE TABLE EMP06(
    EMPNO   NUMBER(4)       CONSTRAINT EMP06_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10)    CONSTRAINT EMP06_ENAME_NN NOT NULL,
    JOB     VARCHAR2(9),
    DEPTNO  NUMBER(2)       CONSTRAINT EMP06_DEPT06_NO_FK REFERENCES    DEPT06(DEPTNO)
);

CREATE TABLE DEPT06(    -- 외래키 생성을 위한 테이블 DEPT06
    DEPTNO  NUMBER(2) CONSTRAINT DEPT06_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13) 
);
-- 오류 보고 integrity constraint(참조무결성 제약) - parent key not found 부모키가 없다
-- ORA-02291: integrity constraint (EZ.EMP06_DEPT06_NO_FK) violated - parent key not found
-- 먼저 부모테이블 DEPT06에 기본키(DEPTNO)를 생성해야 한다

-- 부모(DEPT06)의 기본키(DFPTNO)에 할당된 값만 자식의 테이블(EMP06)에 생성할 수 있게 된다
-- 잘못된 데이터 입력(부모테이블 DEPT06에 없는 부서번호등)을 외래키를 통해 방지할 수 있게 된다

-- 참조 무결성 제약조건은 부모 테이블의 기본키 칼럼의 데이터 이외의 값을
-- 참조 자식 테이블에서 사용 할 수 없게 한다
-- 존재하지 않는 값은 입력 불가

-- 부모 테이블                         자식 테이블
-- PRIMARY KEY COLUMN(기본키)         PRIMARY KEY COLUMN(기본키)    ,,,         FOREIGN KEY COLUMN(외래키)
--                                                                            부모 기본키 참조
-- 참조 무결성을 위한 부모와 자식 테이블의 관계

SELECT * FROM EMP06;

INSERT INTO EMP06 -- 순서 2
VALUE(EMPNO, ENAME, JOB, DEPTNO)
VALUES(7499, 'ALLEN', 'SALESMAN', 30);

-- SQL 오류: ORA-00926: missing VALUES keyword
INSERT INTO EMP06 -- 부모의 기본키 DEPTNO는 현재 10,30 만있으므로 에러 (부모테이블 기본키 20을 추가해줘야 작동)
VALUE(EMPNO, ENAME, JOB, DEPTNO)
VALUES(7400, 'ALLEN', 'SALESMAN', 20);

INSERT INTO DEPT06  -- 순서 1(부모테이블 DEPT06에 기본키 DEPTNO 30을 추가)
VALUES(30, 'SALES', 'CHICAGO');

INSERT INTO DEPT06 
VALUES(20, 'ACCOUNTING', 'NEW YORK');

SELECT * FROM DEPT06;



CREATE TABLE EMP07  -- EMP테이블정보로 AS EMP07테이블 생성 = 테이블 복사
AS 
SELECT * 
FROM EMP;

SELECT *
FROM EMP07;

CREATE TABLE DEPT07
AS
SELECT *
FROM DEPT;

SELECT *
FROM DEPT07;

-- CREATE TABLE ~~~ AS ~~~ (복사)를 통해 만들때 단점 -> 제약조건을 복제 할 수 없다(기본키와 외래키가 없음)
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%07';

DESC DEPT07;

-- 테이블 생성 이후 제약조건을 추가하는 방법(PRIMARY KEY)
ALTER TABLE DEPT07
ADD CONSTRAINT DEPT07_DEPTNO_PK PRIMARY KEY(DEPTNO);

-- 테이블 생성 이후 제약조건을 추가하는 방법(FOREIGN KEY)
ALTER TABLE EMP07
ADD CONSTRAINT EMP07_DEPT07_DEPTNO_FK 
FOREIGN KEY(DEPTNO)REFERENCES DEPT07(DEPTNO);

-- 테이블 생성 이후 제약조건을 제거하는 방법 -- ADD를 DROP으로 변경
-- 제약조건을 제거하는 경우 자식을 제거 후 부모를 제거해야함 (역순)
ALTER TABLE EMP07
DROP CONSTRAINT EMP07_DEPT07_DEPTNO_FK;

ALTER TABLE DEPT07
DROP CONSTRAINT DEPT07_DEPTNO_PK;

-- 사원 테이블과 부서 테이블에 관계를 설정하시오
-- 테이블 - MODEL 선택시 ERD 관계를 확인가능
-- 사원(부모) EXAM_EMP 
-- 부서(자식) EXAM_DEPT
-- 기본키? 외래키?

-- 부모(사원테이블)
CREATE TABLE EXAM_EMP_TEST(
    EMPNO NUMBER(4) NOT NULL CONSTRAINT EXAM_EMP_TEST_EMPNO_NN_UK UNIQUE, 
    ENAME VARCHAR2(10) CONSTRAINT EXAM_EMP_TEST_ENAME_NN NOT NULL,
    JOB   VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EXAM_EMP_TEST_DEPTNO_PK PRIMARY KEY
);

-- 자식(부서테이블)
CREATE TABLE EXAM_DEPT_TEST(
    DEPTNO NUMBER(2) CONSTRAINT EXAM_DEPT_TEST_DEPTNO_FK REFERENCES EXAM_EMP_TEST(DEPTNO),
    DNAME  VARCHAR2(14),
    LOC    VARCHAR2(13)
);
-- 자식테이블 기본키 제약조건 추가
ALTER TABLE EXAM_DEPT_TEST
ADD CONSTRAINT EXAM_DEPT_TEST_DNAME_PK PRIMARY KEY(DNAME);

INSERT INTO EXAM_EMP_TEST
VALUES(100,'김똘똘','점원',10);
INSERT INTO EXAM_EMP_TEST
VALUES(101,'최똘똘','영업',20);
INSERT INTO EXAM_EMP_TEST
VALUES(102,'이똘똘','호객',30);

SELECT * FROM EXAM_EMP_TEST;
SELECT * FROM EXAM_DEPT_TEST;

INSERT INTO EXAM_DEPT_TEST
VALUES(10,'점원부','인천');
INSERT INTO EXAM_DEPT_TEST
VALUES(20,'영업부','서울');
INSERT INTO EXAM_DEPT_TEST
VALUES(30,'호객부','대전');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%TEST%';

-- CHECK와 DEFAULT의 제약조건
-- CHECK는 특정 컬럼의 입력 가능한 값의 범위를 지정할 때 사용
-- 입력할 수 있는 값의 범위 등을 제한한다. CHECK 제약으로는 TRUE OR FALSE로
-- 평가할 수 있는 논리식을 지정한다
-- DEFAULT는 값을 입력하지 않아도 NULL 값이 아니라 
-- 설정한 값이 기본값으로 자동 입력되도록 하는 제약조건

CREATE TABLE EMP08(
    EMPNO   NUMBER(4)       CONSTRAINT EMP08_EMPNO_PK PRIMARY KEY,
    ENAME   VARCHAR2(10)    CONSTRAINT EMP08_ENAME_NN NOT NULL,    
    SAL     NUMBER          CONSTRAINT EMP08_SAL_CK 
        CHECK(SAL BETWEEN 500 AND 5000),
    GENDER  VARCHAR2(3)  DEFAULT 'F'   CONSTRAINT EMP08_GENDER_CK  -- DEFAULT값도 줌
        CHECK(GENDER = 'M' OR GENDER = 'F'),
    JOB     VARCHAR2(10)    DEFAULT 'employee',        -- 디폴트값을 주면 해당칼럼 입력안할경우 디폴트값이 입력된다
    DEPTNO  NUMBER(2)     
);

DESC EMP08;

INSERT INTO EMP08
VALUE(EMPNO, ENAME, SAL, DEPTNO)
VALUES(1111, '이재현', '4000', 10);

INSERT INTO EMP08
VALUES(1111, '이재현', '4000', 'M', 10);

SELECT * FROM EMP08;

-- 오류 보고 CHECK(SAL BETWEEN 500 AND 5000) 입력 가능한 값 범위(5500)를 벗어남
-- ORA-02290: check constraint (EZ.EMP08_SAL_CK) violated
INSERT INTO EMP08
VALUES(1112, '박윤미', '5500', 'F', 10);

INSERT INTO EMP08
VALUES(1112, '박윤미', '4000', 'F', 'it', 10);

DESC EMP08; -- DESC에서는 제약조건을 NOT NULL만 확인가능

SELECT *    -- 제약조건 확인
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP08';

-- 부서 테이블에서
-- 부서의 위치는 입력하지 않으면 기본적으로 서울(default '서울')
-- 값이 입력되도록 하시오

-- 부서 번호는 2자리 숫자만 입력가능하도록 제약조건을 지정
-- 유니크 제약조건과 not null 제약조건을 설정하시오

-- 제약조건을 확인 할 수 있도록 데이터 입력도 보여주시오

DESC EXAM_DEPT_TEST2;

DROP TABLE DEPT_TEST;

-- LIKE '__' 2자리수 지정 언더바 _ 로 또는 LIKE '%%'; 0으로 떨굴거면 '%0'
-- 2자리수 제약조건을 위해서 NUMBER타입인 DEPTNO를 TO_CHAR를 통해 문자형 타입으로 변경후
-- LENGTH를 이용해서 길이를 2로 CHECK 조건을 준다 (LENGTH를 사용할 경우 묵시적으로 형변환 되지만)
-- TO_CHAR를 명시하여 작성해주자

CREATE TABLE DEPT_TEST(
    DEPTNO  NUMBER(2) CONSTRAINT DEPT_TEST_DEPTNO_NN NOT NULL 
--                    CONSTRAINT DEPT_TEST_DEPTNO_CK CHECK(LENGTH(DEPTNO) = 2) 이경우 묵시적으로 문자형으로 형변환됨
                      CONSTRAINT DEPT_TEST_DEPTNO_CK CHECK(LENGTH(TO_CHAR(DEPTNO)) = 2)
                      CONSTRAINT DEPT_TEST_DEPTNO_UK UNIQUE,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13) DEFAULT '서울'
);
  
INSERT INTO DEPT_TEST
VALUES(10,'판매부','인천');

INSERT INTO DEPT_TEST
VALUES(20,'영업부','부산');

INSERT INTO DEPT_TEST
VALUE(DEPTNO,DNAME)
VALUES(30,'호객부');

INSERT INTO DEPT_TEST
VALUE(DEPTNO,DNAME)
VALUES(40,'호객부2');

INSERT INTO DEPT_TEST
VALUE(DEPTNO,DNAME)
VALUES('00','호객부3');

INSERT INTO DEPT_TEST
VALUE(DEPTNO,DNAME)
VALUES(11,'호객부4');

SELECT * 
FROM DEPT_TEST;

SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

CREATE TABLE EXAM_DEPT20(
    DEPTNO NUMBER(2) CONSTRAINT EXAM_DEPT20_U UNIQUE NOT NULL,
    DNAME VARCHAR2(14),
    LOC   VARCHAR2(13) DEFAULT 'SEOUL'
);

SELECT *
FROM EXAM_DEPT20;

INSERT INTO EXAM_DEPT20
(DEPTNO, DNAME, LOC)
VALUES(10, 'aa', '서울');

INSERT INTO EXAM_DEPT20
(DEPTNO, DNAME, LOC)
VALUES(10, 'bb', '인천');

INSERT INTO EXAM_DEPT20
(DEPTNO, DNAME, LOC)
VALUES(null, 'aa', '서울');

CREATE TABLE EXAM_DEPT21(
    DEPTNO NUMBER(2) CONSTRAINT EXAM_DEPT21_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC   VARCHAR2(13) DEFAULT 'SEOUL'
);

SELECT *
FROM EXAM_DEPT21;

INSERT INTO EXAM_DEPT21
(DEPTNO, DNAME, LOC)
VALUES(10, 'aa', '서울');

INSERT INTO EXAM_DEPT21
(DEPTNO, DNAME, LOC)
VALUES(10, 'bb', '인천');

INSERT INTO EXAM_DEPT21
(DEPTNO, DNAME, LOC)
VALUES(null, 'aa', '서울');

-- PRIMARY KEY(기본키)
-- 한 테이블에 유일하다
-- 반드시 존재해야한다
-- PRIMARY KEY는 UNIQUE + NOT NULL이랑은 다름

-- UNIQUE + NOT NULL + INDEX(색인 - 검색속도 향상)
 
-- UNIQUE, NOT NULL(유일 + NOT NULL)
-- 여러 칼럼에 가능하다


