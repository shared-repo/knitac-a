USE madang;

-- 실습에 필요한 기능 테스트
SELECT NOW();
SELECT CURRENT_TIMESTAMP();

/* 회원 테이블 만들기 ( 이름 : member )
   컬럼
	- memberid (문자형, null X, 기본키 )
    - passwd(문자형, null X ), 
	- email(문자형, null X ), 
    - usertype(문자형, 기본값 = 'user', 값은 'user' 또는 'admin'만 가능), 
	- active(boolean, 기본값 = true)
    - regdate(날짜형, 기본값 = now()) */
DROP TABLE IF EXISTS member;
CREATE TABLE member
(
	memberid VARCHAR(20) NOT NULL, -- PRIMARY KEY
    passwd VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    usertype VARCHAR(50) DEFAULT('user') CHECK(usertype IN ('user', 'admin')),
    active BOOLEAN DEFAULT(true),
    regdate DATE DEFAULT(NOW()),
    -- PRIMARY KEY (memberid) -- 아래 행과 같은 의미
    CONSTRAINT pk_member PRIMARY KEY (memberid)
);
DESC member;

/* 게시판 테이블 만들기 ( 이름 : board )
   컬럼 :    
	boardno(정수형, null X, primary key, 자동증가컬럼), 
    title (문자형, null X),
    writer (문자형, null X, 외래키 = member.memberid 참조), 
    content (문자형),
    regdate (날짜형, 기본값 = now()), 
    updatedate (날짜형, 기본값 = now()),
	readcount (정수형, 기본값 = 0) */
DROP TABLE IF EXISTS board;
CREATE TABLE board
(
	boardno INTEGER NOT NULL AUTO_INCREMENT, -- AUTO_INCREMENT : 자동 증가 컬럼 설정
    title VARCHAR(100) NOT NULL,
    writer VARCHAR(20) NOT NULL, -- VARCHAR(20)은 member.memberid와 동일하게 적용
    content VARCHAR(4000),
    readcount INTEGER DEFAULT(0),
    regdate DATE DEFAULT(NOW()),
    updatedate DATE DEFAULT(NOW()),
    CONSTRAINT pk_board PRIMARY KEY (boardno),
    CONSTRAINT fk_member_board FOREIGN KEY (writer) REFERENCES member(memberid)
);
DESC board;



