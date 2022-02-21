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

-- 가격이 20,000원 미만인 도서를 검색하시오
SELECT *
FROM book
WHERE price < 20000;

-- 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000; -- AND : 두 조건을 결합

-- 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오 2.
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000; -- 범위를 표현할 때 : BETWEEN 시작 AND 종료

-- 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어'; -- 문자(열) 표현은 작은따옴표 사용 (큰따옴표 사용 X)

-- 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오 2
SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어'); -- 주어진 목록에 포함되는지 확인 : IN ( .... )

-- 출판사가 ‘굿스포츠’ 및 ‘대한미디어’가 아닌 도서를 검색하시오
SELECT *
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어'); -- 주어진 목록에 포함되지 않는 것을 확인 : NOT IN ( .... )

-- ‘축구의 역사’를 출간한 출판사를 검색하시오
SELECT *
FROM book
WHERE bookname = '축구의 역사'; -- = 연산자는 완전일치 검사

-- 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '%축구%'; -- LIKE : 부분일치 검사 (%는 갯수에 제약 없는 와일드카드)

-- 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '_구%'; -- LIKE : 부분일치 검사 (_는 1개의 문자에 대한 와일드카드)

-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000; -- AND : 두 조건을 결합 ( 모두 만족하는 경우 )

-- 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어'; -- OR : 두 조건을 결합 ( 하나라도 만족하는 경우 )

-- 도서를 이름순으로 검색하시오
SELECT *
FROM book
ORDER BY bookname;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
SELECT *
FROM book
ORDER BY price, bookname;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
SELECT *
FROM book
ORDER BY price DESC, publisher ASC; -- DESC : 내림차순, ASC : 오름차순, 지정하지 않으면 ASC

--
DESC orders;

-- 고객이 주문한 도서의 총 판매액을 구하시오.
-- SELECT SUM(saleprice) AS 총판매액 -- AS는 컬럼의 별칭을 지정하는 명령 ( AS는 생략 가능 )
SELECT SUM(saleprice) 총판매액 
FROM orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) 총구매액
FROM orders
WHERE custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT 
	SUM(saleprice) 총판매액, 
    AVG(saleprice) 평균판매액, 
    MIN(saleprice) 최저가, 
    MAX(saleprice) 최고가
FROM orders;

-- 마당서점의 도서 판매 건수를 구하시오
SELECT COUNT(*) 총판매도서수
FROM orders;

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid 고객아이디, COUNT(saleprice) 총수량, SUM(saleprice) 총판매액
FROM orders
GROUP BY custid;

-- 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
-- 단, 두 권 이상 구매한 고객만 구한다
SELECT custid 고객아이디, COUNT(saleprice) 총수량, SUM(saleprice) 총판매액
FROM orders
-- WHERE saleprice >= 8000 AND COUNT(saleprice) >= 2 -- WHERE 절에서 집계함수 사용할 수 없음
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(saleprice) >= 2; -- 조건으로 집계함수를 사용하려면 HAVING에 표현









