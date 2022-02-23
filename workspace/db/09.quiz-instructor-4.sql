USE madang; -- 작업 데이터베이스 변경

/* 새로운 도서 (‘스포츠 세계’, ‘대한미디어’, 10000원)이 마당서점에 입고되었다. 
   삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보자. */
   
INSERT INTO book (bookname, publisher, price)
VALUES ('스포츠 세계', '대한미디어', 10000); -- 오류 발생

DESC book; -- 오류 확인을 위해 테이블 정보 보기 -- bookid는 not null

SELECT * FROM book ORDER BY bookid DESC; -- 마지막 bookid 조회

INSERT INTO book (bookid, bookname, publisher, price)
VALUES (23, '스포츠 세계', '대한미디어', 10000); -- bookid 지정 - 정상실행

SELECT * FROM book ORDER BY bookid DESC; -- 데이터 확인

/* ‘삼성당’에서 출판한 도서를 삭제해야 한다. */
-- 1-1. 삼성당에서 출판한 도서 조회
SELECT *
FROM book
WHERE publisher = '삼성당';

DELETE FROM book
WHERE publisher = '삼성당';

SELECT * FROM book; -- 데이터 확인 (삭제 확인)

/* ‘이상미디어’에서 출판한 도서를 삭제해야 한다. 
   삭제가 안 될 경우 원인을 생각해보자. */
   
SELECT * FROM book; -- 기존 데이터 확인

DELETE FROM book
WHERE publisher = '이상미디어'; -- 삭제 실패 : orders 테이블에서 참조하는 데이터이기 때문
							  -- 해결 : orders 테이블의 데이터를 삭제한 후 book 테이블 데이터 제거	
                              
/* 출판사 ‘대한미디어’가 ‘대한출판사’로 이름을 바꾸었다. */
UPDATE book
SET publisher = '대한출판사'
WHERE publisher = '대한미디어';

SELECT * FROM book;
   
   
