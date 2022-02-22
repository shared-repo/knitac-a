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

