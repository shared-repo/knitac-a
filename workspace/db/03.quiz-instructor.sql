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

-- 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
-- custid를 구하는 과정은 위 문제 참고
SELECT COUNT(*) 총구매수량
FROM orders
WHERE custid = 1; -- 위 SQL에서 확인한 1을 조건에 적용

-- 마당서점 도서의 총 개수
SELECT COUNT(*) 총도서수
FROM book;

-- 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT DISTINCT publisher
FROM book;

-- SELECT COUNT(publisher) 거래처수 -- 중복되는 출판사도 계산됩니다.
SELECT COUNT(DISTINCT publisher) 거래처수 -- 중복을 제거한 출판사 수
FROM book;

-- 모든 고객의 이름, 주소
DESC customer;

SELECT name, address
FROM customer;

-- 2014년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
DESC orders;

SELECT orderid
FROM orders
WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07'; -- 문자(열), 날짜는 작은따옴표를 사용해서 표현

-- 2014년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
SELECT *
FROM orders
WHERE orderdate NOT BETWEEN '2014-07-04' AND '2014-07-07'; -- NOT BETWEEN : 범위 밖에 있는 데이터만 조회

-- 성이 ‘김’ 씨인 고객의 이름과 주소 (이름이 '박'으로 시작하는 고객)
DESC customer;

SELECT *
FROM customer
WHERE name LIKE '박%';

-- 성이 ‘박’ 씨이고 이름이 ‘리’로 끝나는 고객의 이름과 주소
SELECT * FROM customer;
SELECT *
FROM customer
WHERE name LIKE '박%리';



