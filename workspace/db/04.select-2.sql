USE madang; -- 작업 데이터베이를 madang으로 변경

SHOW TABLES; -- 테이블 목록 보기

-- 고객과 고객의 주문에 관한 데이터를 병합해서 모두 보이시오 1
SELECT *
FROM customer, orders;

-- 고객과 고객의 주문에 관한 데이터를 병합해서 모두 보이시오 2
DESC customer;
DESC orders;

SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;

-- 고객과 고객의 주문에 관한 데이터를 병합해서 모두 보이시오 3
SELECT c.custid, c.name, o.orderid, o.saleprice, o.orderdate
FROM customer c, orders o -- 테이블 이름에 별칭 부여
WHERE c.custid = o.custid;

-- 고객과 고객의 주문에 관한 데이터를 병합해서 모두 보이시오 4
SELECT c.custid, c.name, o.orderid, o.saleprice, o.orderdate
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid; -- ON : JOIN 구문에 대한 WHERE

-- 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
SELECT *
FROM customer c, orders o
WHERE c.custid = o.custid
ORDER BY c.custid;

SELECT *
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid
ORDER BY c.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT c.name, o.saleprice, o.orderdate
FROM orders o, customer c
WHERE o.custid = c.custid;

SELECT c.name, o.saleprice, o.orderdate
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid;

-- 고객(이름)별로 주문한 모든 도서의 총 판매액을 구하고, 고객(이름)별로 정렬하시오.
SELECT o.custid, SUM(o.saleprice) 총판매액
FROM orders o
GROUP BY o.custid;

SELECT c.name, SUM(o.saleprice) 총판매액
FROM orders o, customer c
WHERE o.custid = c.custid
GROUP BY o.custid, c.name -- custid를 포함한 것은 동명이인을 구분하기 위한 것
ORDER BY c.name;

SELECT c.name, SUM(o.saleprice) 총판매액
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
GROUP BY o.custid, c.name
ORDER BY c.name;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT *
FROM orders;

SELECT o.orderid, c.custid, c.name, b.bookid, b.bookname, o.saleprice, o.orderdate
FROM orders o, customer c, book b
WHERE o.custid = c.custid AND o.bookid = b.bookid;

SELECT o.orderid, c.custid, c.name, b.bookid, b.bookname, o.saleprice, o.orderdate
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
INNER JOIN book b
ON o.bookid = b.bookid;

-- 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오 ( JOIN + WHERE )
SELECT o.orderid, c.custid, c.name, b.bookid, b.bookname, o.saleprice, o.orderdate
FROM orders o, customer c, book b
WHERE o.custid = c.custid 
	  AND o.bookid = b.bookid
      AND b.price = 20000;

SELECT o.orderid, c.custid, c.name, b.bookid, b.bookname, o.saleprice, o.orderdate
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
INNER JOIN book b
ON o.bookid = b.bookid
WHERE b.price = 20000;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- ( 고객별 주문 내역 조회 )
SELECT c.name, b.bookname, o.orderid, o.saleprice, o.orderdate
FROM customer c 
LEFT OUTER JOIN orders o -- 왼쪽 컬럼 (customer)는 모두 조회하고 오른쪽 컬럼은 일치하는 것만 조회
ON o.custid = c.custid
LEFT OUTER JOIN book b
ON o.bookid = b.bookid
ORDER BY c.name;

-- 고객별 주문 실적 ( 고객별 주문 총액 조회 )
SELECT c.custid, c.name, SUM(o.saleprice) 주문총액
FROM customer c
LEFT OUTER JOIN orders o
ON c.custid = o.custid
GROUP BY c.custid
ORDER BY SUM(o.saleprice) DESC;







