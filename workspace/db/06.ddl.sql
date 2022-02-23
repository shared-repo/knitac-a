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

-- -----------------------------------------------------

USE madang; -- 작업 데이터베스를 madang으로 변경

/* 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
   • custid(고객번호) - INTEGER, 기본키
   • name(이름) – VARCHAR(40)
   • address(주소) – VARCHAR(40)
   • phone(전화번호) – VARCHAR(30) */
   
CREATE TABLE NewCustomer
(
	custid INTEGER PRIMARY KEY,
    name VARCHAR(40),
    address VARCHAR(40),
    phone VARCHAR(30)
);

DESC NewCustomer;
DROP TABLE IF EXISTS NewCustomer;

/* 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
   • orderid(주문번호) - INTEGER, 기본키
   • custid(고객번호) - INTEGER, NOT NULL 제약조건, 외래키(NewCustomer.custid, 연쇄삭제)
   • bookid(도서번호) - INTEGER, NOT NULL 제약조건, 외래키(NewBook.bookid, 연쇄삭제)
   • saleprice(판매가격) - INTEGER 
   • orderdate(판매일자) – DATE */
   
-- 이 실습을 하려면 위의 NewCustomer 테이블 생성 구문과 NewBook 테이블 생성 구문을 실행해서 
-- 미리 테이블을 만들어 두어야합니다. ( 외래키를 지정하기 위해 )

DROP TABLE IF EXISTS NewCustomer;
CREATE TABLE NewCustomer
(
	custid INTEGER PRIMARY KEY,
    name VARCHAR(40),
    address VARCHAR(40),
    phone VARCHAR(30)
);
DROP TABLE IF EXISTS NewBook;
CREATE TABLE NewBook
(
	bookid	INTEGER PRIMARY KEY,
    bookname VARCHAR(40),
    publisher VARCHAR(40),
    price INTEGER
);

CREATE TABLE NewOrders
(
	orderid INTEGER PRIMARY KEY,
    custid INTEGER NOT NULL,
    bookid INTEGER NOT NULL,
    saleprice INTEGER,
    orderdate DATE, -- DATE : 날짜 자료형
    -- FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
    -- FOREIGN KEY (bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE
    CONSTRAINT fk_newcustomer_neworders FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
    CONSTRAINT fk_newbook_neworders FOREIGN KEY (bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE
);
DESC NewOrders;
DROP TABLE IF EXISTS NewOrders;
-- 아래 DROP 구문은 NewOrder를 먼저 Drop 처리한 후에 실행해야 합니다.
DROP TABLE IF EXISTS NewCustomer;
DROP TABLE IF EXISTS NewBook;

/* 다음 요구사항에 따라 SQL문을 작성하고 실행하세요 
   실행을 위해 먼저 NewBook 테이블을 만들어야 합니다 */
   
DROP TABLE IF EXISTS NewBook;
CREATE TABLE NewBook
(
	bookid	INTEGER,
    bookname VARCHAR(40),
    publisher VARCHAR(40),
    price INTEGER
);

-- NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오.
ALTER TABLE NewBook
ADD isbn VARCHAR(13);
DESC NewBook;

-- NewBook 테이블의 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오.
ALTER TABLE NewBook
MODIFY isbn INTEGER;
DESC NewBook;

-- NewBook 테이블의 isbn 속성을 삭제하시오
ALTER TABLE NewBook
DROP COLUMN isbn;
DESC NewBook;

-- NewBook 테이블의 bookname 속성에 NOT NULL 제약조건을 적용하시오
ALTER TABLE NewBook
MODIFY bookname varchar(40) NOT NULL;
DESC NewBook;

-- NewBook 테이블의 bookid 속성을 기본키로 변경하시오
ALTER TABLE NewBook
-- ADD PRIMARY KEY (bookid) -- 아래 구문으로 대체 가능
ADD CONSTRAINT pk_book_bookid PRIMARY KEY (bookid);
DESC NewBook;

-- 테스트 정리
DROP TABLE IF EXISTS NewBook;













