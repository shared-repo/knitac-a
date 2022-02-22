-- 박지성(customer)이 구매(orders)한 도서(book)의 출판사 수
SELECT COUNT(b.publisher) 출판사수
FROM book b, orders o, customer c
WHERE b.bookid = o.bookid AND o.custid = c.custid
	  AND c.name = '박지성';
      
SELECT COUNT(b.publisher) 출판사수
FROM book b
INNER JOIN orders o
ON b.bookid = o.bookid
INNER JOIN customer c
ON o.custid = c.custid
WHERE c.name = '박지성';

-- 박지성(customer)이 구매(orders)한 도서(book)의 이름, 가격, 정가와 판매가격의 차이
SELECT b.bookname 도서명, b.price 도서가격, b.price - o.saleprice 할인액
FROM book b, orders o, customer c
WHERE b.bookid = o.bookid AND o.custid = c.custid
	  AND c.name = '박지성';
      
SELECT b.bookname 도서명, b.price 도서가격, b.price - o.saleprice 할인액
FROM book b
INNER JOIN orders o
ON b.bookid = o.bookid
INNER JOIN customer c
ON o.custid = c.custid
WHERE c.name = '박지성';

-- 박지성(customer)이 구매(orders)하지 않은 도서(book)의 이름
/* 1-1. 박지성 고객의 구매 이력 조회 */
SELECT o.bookid	-- 조회결과 : 1, 3, 2
FROM customer c, orders o
WHERE c.custid = o.custid AND c.name = '박지성';
/* 1-2 */
SELECT *
FROM book b
WHERE b.bookid NOT IN (1, 2, 3); -- 위 1-1 결과를 적용

/* 2 */
SELECT *
FROM book b
WHERE b.bookid NOT IN ( SELECT o.bookid
						FROM customer c, orders o
						WHERE c.custid = o.custid AND c.name = '박지성' );
                        
-- 주문(orders)하지 않은 고객(customer)의 이름(부속질의 사용)
/* 1-1 주문한 고객 아이디 조회*/
SELECT DISTINCT custid	-- 조회결과 : 1, 2, 3, 4
FROM orders;
/* 1-2 */
SELECT *
FROM customer
WHERE custid NOT IN (1, 2, 3, 4); -- 1-1의 조회 결과 적용

/* 2 */
SELECT *
FROM customer
WHERE custid NOT IN ( SELECT DISTINCT custid
					  FROM orders );
                      
-- 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) 주문총액, AVG(saleprice) 평균주문액
FROM orders;

-- 고객(customer)의 이름과 고객별 구매(orders)액
SELECT c.name 고객이름, SUM(saleprice) 구매액
FROM orders o, customer c
WHERE o.custid = c.custid
GROUP BY c.custid;

SELECT c.name 고객이름, SUM(saleprice) 구매액
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
GROUP BY c.custid;

-- 고객(customer)의 이름과 고객이 구매(orders)한 도서(book) 목록
SELECT c.name, b.*
FROM customer c, orders o, book b
WHERE c.custid = o.custid AND o.bookid = b.bookid;

SELECT c.name, b.*
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid
INNER JOIN book b
ON o.bookid = b.bookid;

-- 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
/* 1-1 도서별로 (도서의 가격 - 판매 가격) 조회 */
SELECT b.bookid, b.bookname, b.price - o.saleprice 할인액
FROM book b, orders o
WHERE b.bookid = o.bookid;
/* 1-2 (도서의 가격 - 판매 가격)이 가장 큰 값 조회 */
SELECT MAX(b.price - o.saleprice) 최대할인액 -- 결과 : 6000
FROM book b, orders o
WHERE b.bookid = o.bookid;

/* 2 */
SELECT b.bookid, b.bookname, b.price - o.saleprice 할인액
FROM book b, orders o
WHERE b.bookid = o.bookid 
	  AND
      b.price - o.saleprice = ( SELECT MAX(b.price - o.saleprice)
								FROM book b, orders o
								WHERE b.bookid = o.bookid );





