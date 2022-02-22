-- 작업 데이터베이스 결정
USE madang;

/* 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 
   정수형은 INTEGER를 사용하며 문자형은 가변형 문자타입인 VARCHAR을 사용한다. 
   bookid(도서번호)-INTEGER
   bookname(도서이름)-VARCHAR(20)
   publisher(출판사)-VARCHAR(20)
   price(가격)-INTEGER */
   
SHOW TABLES; -- 테이블 목록 확인

CREATE TABLE newbook
(
	bookid	INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER
);

SHOW TABLES; -- 테이블 목록 확인 : 새 테이블 생성 여부 확인

DESC newbook; -- 테이블 구성 표시

DROP TABLE IF EXISTS newbook; -- newbook 테이블이 있으면 제거

/* 위 테이블 생성 구문에 primary key (주식별자, 기본키) 추가 */
CREATE TABLE newbook
(
	bookid	INTEGER PRIMARY KEY, -- PRIMARY KEY : bookid는 중복해서 저장할 수 없음 (고유값)
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER
);
DESC newbook;
DROP TABLE IF EXISTS newbook;

CREATE TABLE newbook
(
	bookid	INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER,
    PRIMARY KEY (bookid) -- PRIMARY KEY : bookid는 중복해서 저장할 수 없음 (고유값)
);
DESC newbook;
DROP TABLE IF EXISTS newbook;

CREATE TABLE newbook
(
	bookid	INTEGER,
    bookname VARCHAR(20),
    publisher VARCHAR(20),
    price INTEGER,
    PRIMARY KEY (bookid, bookname) -- PRIMARY KEY : bookid, bookname이 동시에 일치하는 데이터는 저장할 수 없음 (고유값)
);
DESC newbook;
DROP TABLE IF EXISTS newbook;

/* 위 테이블 생성 구문에 다음 제약 조건 추가
   - bookname은 NULL 값을 가질 수 없고 (필수 입력 값),			-- NULL / NOT NULL 
   - publisher는 같은 값이 있으면 안 된다. 					-- UNIQUE
   - price에 값이 입력되지 않을 경우 기본 값 10000을 저장한다.		-- DEFAULT
   - 또 가격은 최소 1,000원 이상으로 한다. 					-- CHECK	*/
   
CREATE TABLE newbook
(
	bookid	INTEGER PRIMARY KEY,						-- PRIMARY KEY는 자동으로 NOT NULL
    bookname VARCHAR(20) NOT NULL, 						-- 필수 입력 컬럼
    publisher VARCHAR(20) UNIQUE,						-- 중복을 허용하지 않습니다			
    price INTEGER DEFAULT(10000) CHECK(price > 1000)	-- 값이 없으면 자동으로 10000 저장, 
														-- 값은 반드시 1000보다 커야합니다. 
);
DESC newbook;
DROP TABLE IF EXISTS newbook;





