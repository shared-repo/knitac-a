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