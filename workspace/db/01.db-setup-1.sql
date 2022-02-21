/* execute as root */

DROP DATABASE IF EXISTS  madang;		/* 기존 데이터베이스가 있다면 제거 */
DROP USER IF EXISTS  madang@localhost;	/* 기존 사용자가 있다면 제거 */
DROP USER IF EXISTS  madang@"%";		/* 기존 사용자가 있다면 제거 */

create user knitac@localhost identified by 'knitac'; /* 서버와 같은 컴퓨터에서 접속하는 사용자 */
create user knitac@"%" identified by 'knitac';	/* 다른 모든 컴퓨터에서 접속하는 사용자 */

create database madang; /* 데이터베이스 만들기 */

grant all privileges on madang.* to knitac@localhost; /* knitac에게 madang 데이터베이스 사용 권한 부여 */
grant all privileges on madang.* to knitac@"%"; /* knitac에게 madang 데이터베이스 사용 권한 부여 */

flush privileges; /* 위에서 실행한 권한 변경 사항을 적용 */

show databases; /* 서버의 모든 데이터베이스 목록 조회 : 위에서 만든 madang 있는지 확인 */

use mysql; /* 지금부터 mysql 데이터베이스를 대상으로 명령을 수행한다는 의미 */

show tables; /* 현재 작업중인 데이터베이스의 모든 테이블 목록을 조회 */

desc user; /* user 테이블에 대한 정보 조회 */

select user, host from user; /* user 테이블에서 사용자 아이디(user), host 컬럼의 데이터 조회 */










