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







