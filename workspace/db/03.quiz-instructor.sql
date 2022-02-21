USE madang;

-- 도서번호가 1인 도서의 이름
DESC book;

SELECT bookname
FROM book
WHERE bookid = 1;

-- 가격이 20,000원 이상인 도서의 이름
SELECT bookname
FROM book
WHERE price >= 20000;

-- 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
DESC customer;

SELECT custid
FROM customer
WHERE name = '박지성'; -- 이 조회를 통해서 custid가 1인 것을 확인

SELECT SUM(saleprice) 총구매액
FROM orders
WHERE custid = 1; -- 위 SQL에서 확인한 1을 조건에 적용