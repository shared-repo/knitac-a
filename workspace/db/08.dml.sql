USE madang; -- 작업 데이터베이스 변경

/* Book 테이블에 새로운 도서 ‘스포츠 의학’을 삽입하시오. 
   스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다 */
DESC book; -- 컬럼 목록 확인
SELECT * FROM book; -- 마지막 데이터 확인

-- 1-1. 컬럼 나열 + 값 나열
DELETE FROM book WHERE bookid = 11; -- 11번 도서 데이터 삭제
INSERT INTO book (bookid, bookname, publisher, price)
VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
SELECT * FROM book ORDER BY bookid DESC; -- 삽입된 데이터 확인

-- 1-2. 컬럼 나열 + 값 나열, 컬럼 순서는 자유롭게 결정
DELETE FROM book WHERE bookid = 12; -- 12번 도서 데이터 삭제
INSERT INTO book (bookid, publisher, price, bookname)
VALUES (12, '한솔의학서적', 90000, '스포츠 의학 2');
SELECT * FROM book ORDER BY bookid DESC; -- 삽입된 데이터 확인

-- 1-3. 모든 컬럼을 다 사용하는 경우 컬럼 생략 + 값 나열, 테이블의 컬럼 순서를 지켜서 값 표시
DELETE FROM book WHERE bookid = 13; -- 13번 도서 데이터 삭제
INSERT INTO book -- 모든 컬럼을 다 사용하는 경우 컬럼 목록 생략 가능
VALUES (13, '스포츠 의학 3', '한솔의학서적', 90000);
SELECT * FROM book ORDER BY bookid DESC; -- 삽입된 데이터 확인

/* Book 테이블에 새로운 도서 ‘스포츠 의학 4’을 삽입하시오. 
   스포츠 의학은 한솔의학서적에서 출간했으며 가격은 미정이다 */
DESC book; -- 컬럼의 상태 확인 ( 특히 price 컬럼 )

DELETE FROM book WHERE bookid = 14; -- 14번 도서 데이터 삭제
INSERT INTO book (bookid, bookname, publisher) -- NULL 허용 컬럼은 누락 가능
VALUES (14, '스포츠 의학 4', '한솔의학서적');
SELECT * FROM book ORDER BY bookid DESC; -- 삽입된 데이터 확인

/* 수입도서 목록(Imported_book)을 Book 테이블에 모두 삽입하시오. ( 테이블간 데이터 복사 )
   (Imported_book 테이블은 스크립트 Book 테이블과 같이 이미 만들어져 있음) */
DESC imported_book; -- book, imported_book 두 테이블의 구성 비교
DESC book; -- book, imported_book 두 테이블의 구성 비교

DELETE FROM book WHERE bookid IN (SELECT bookid FROM imported_book);
INSERT INTO book (bookid, bookname, publisher, price)
SELECT bookid, bookname, publisher, price FROM imported_book;

SELECT * FROM book ORDER BY bookid DESC;

/* Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오 */
SELECT * FROM customer; -- 기존 데이터 확인

UPDATE customer
SET address = '대한민국 제주', name = '세리박'
WHERE custid = 5;

SELECT * FROM customer; -- 변경 데이터 확인

/* Book 테이블에서 14번 ‘스포츠 의학’의 출판사를 
   imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오. */
SELECT * FROM imported_book WHERE bookid = 21; -- 데이터 확인
SELECT * FROM book WHERE bookid = 14; -- 데이터 확인

-- 1-1. imported_book 테이블의 21번 도서의 출판사 조회
SELECT publisher -- 조회 결과 : Pearson
FROM imported_book 
WHERE bookid = 21;

-- 1-2. book 테이블의 14번 도서의 출판사를 1-1의 조회 결과(Pearson)로 변경
UPDATE book
SET publisher = 'Pearson'
WHERE bookid = 14;

SELECT * FROM book WHERE bookid = 14; -- 데이터 확인

-- 2
UPDATE book
SET publisher = ( SELECT publisher
				  FROM imported_book 
				  WHERE bookid = 21 )
WHERE bookid = 13; -- 테스트를 위해 13번을 수정

SELECT * FROM book WHERE bookid = 13; -- 데이터 확인





