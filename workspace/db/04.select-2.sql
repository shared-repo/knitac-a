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

-- 가장 비싼 도서의 이름을 보이시오.
SELECT *
FROM book;

SELECT MAX(price) 최고가
FROM book;

SELECT *
FROM book
WHERE price = 35000;

SELECT *
FROM book
WHERE price = (	SELECT MAX(price)
				FROM book );

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
/* 1 */
SELECT DISTINCT c.name
FROM customer c, orders o -- inner join : 두 테이블에 모두 있는 일치하는 데이터 조회
WHERE c.custid = o.custid;

/* 2-1 */
SELECT DISTINCT custid -- 조회 결과 : 1, 2, 3, 4
FROM orders;
/* 2-2 */
SELECT name
FROM customer
WHERE custid IN (1, 2, 3, 4); -- 위에서 조회한 주문 테이블의 고객아이디 적용

/* 3 */
SELECT name
FROM customer
WHERE custid IN ( SELECT DISTINCT custid
				  FROM orders );
                  
-- 대한미디어에서 출판한 도서(book table)를 구매한 고객(orders table)의 이름(customer)을 보이시오
/* 1 */
SELECT c.name
FROM customer c, orders o, book b
WHERE c.custid = o.custid AND o.bookid = b.bookid
	  AND b.publisher = '대한미디어';

/* 2-1 */
SELECT bookid	-- 조회결과 : 3, 4
FROM BOOK
WHERE publisher = '대한미디어';
/* 2-2 */
SELECT custid	-- 조회결과 : 1
FROM orders
WHERE bookid IN (3, 4); -- 위에서 조회한 bookid를 적용
/* 2-3 */
SELECT name
FROM customer
WHERE custid IN (1); 	-- 위에서 조회한 custid를 적용

/* 3 */
SELECT name
FROM customer
WHERE custid IN ( SELECT custid
				  FROM orders
				  WHERE bookid IN ( SELECT bookid
									FROM BOOK
									WHERE publisher = '대한미디어') );
                                    
-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
/* 1-1 : 굿스포츠 출판사의 평균 도서 가격 */
SELECT AVG(price) 평균가격 -- 조회 결과 : 7000
FROM book
WHERE publisher = '굿스포츠';
/* 1-2 : 굿스포츠 출판사의 도서 조회 */
SELECT *
FROM book
WHERE publisher = '굿스포츠';
/* 1-3 : 굿스포츠 출판사의 도서 중 1-1의 가격보다 비싼 도서 조회 */
SELECT *
FROM book
WHERE publisher = '굿스포츠' AND price > 7000;

/* 2 : 1과 3을 결합해서 서브쿼리 작성 */
SELECT *
FROM book
WHERE publisher = '굿스포츠' AND price > ( SELECT AVG(price)
										 FROM book
										 WHERE publisher = '굿스포츠' );
                                         
/* 3 : 2의 작업을 모든 도서에 적용 */
SELECT mb.*
FROM book mb
WHERE mb.price > ( SELECT AVG(sb.price)
				   FROM book sb
				   -- WHERE sb.publisher = '현재 메인쿼리의 publisher' );
                   WHERE sb.publisher = mb.publisher );
                   
-- 주문이 있는 고객의 이름과 주소를 보이시오
SELECT *
FROM customer c
WHERE c.custid IN ( SELECT o.custid
				    FROM orders o
				    WHERE o.custid = c.custid );
                   
SELECT *
FROM customer c
WHERE EXISTS ( SELECT o.custid -- EXISTS : 존재 여부만 확인 (비교하지 않습니다)
			   FROM orders o
			   WHERE o.custid = c.custid );


