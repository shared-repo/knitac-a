USE madang; /* 작업 데이터베이스 선택 */

SHOW TABLES; /* 테이블 목록 보기 */

DESC book; /* book 테이블 정보 보기 */

-- book 테이블의 모든 컬럼 데이터 조회
SELECT bookid, bookname, publisher, price
FROM book;

-- book 테이블의 모든 컬럼 데이터 조회 2
SELECT * -- * : 모든 컬럼
FROM book;

-- book 테이블의 bookname, price 컬럼 데이터 조회
SELECT bookname, price
FROM book;

-- book 테이블의 price, bookname 컬럼 데이터 조회
SELECT price, bookname
FROM book;

-- 도서 테이블의 모든 출판사 조회 ( 중복 포함 )
SELECT ALL publisher -- 지정하지 않으면 ALL 사용
FROM book;

-- 도서 테이블의 모든 출판사 조회 2 ( 중복 제거 )
SELECT DISTINCT publisher
FROM book;








