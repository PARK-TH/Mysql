create database movieDB;

use movieDB;

create table movietbl(
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_file longblob
) default charset = utf8mb4;

drop table movietbl;


ALTER DATABASE movieDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
ALTER TABLE movietbl CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



INSERT INTO movietbl
VALUES(
    1,
    '쉰들러리스트',
    '스티븐 스필버그',
    '리암 니슨',
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieA_utf8.txt'),     
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieAA.mp4')
);
INSERT INTO movietbl
VALUES(
    2,
    '쇼생크탈출',
    '프랭크 다라본트',
    '팀 로빈스',
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieB_utf8.txt'),     
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieBB.mp4')
);
INSERT INTO movietbl
VALUES(
    3,
    '라스트 모히칸',
    '마이클 만',
    '다니엘 데이 루이스',
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieC_utf8.txt'),     
    LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/movieCC.mp4')
);
SET SQL_SAFE_UPDATES = 1;

DELETE FROM movietbl WHERE movie_script IS NULL;


select movie_script
from movietbl;

SHOW VARIABLES LIKE 'max_allowed_packet';
SHOW VARIABLES LIKE 'secure_file_priv';

SELECT LOAD_FILE('/Users/parktaehwan/Desktop/study/data/movies/test.txt');

SELECT movie_film FROM movietbl WHERE movie_id=3
INTO DUMPFILE '경로';

use modelDB;

create table pivotTest(
	uName CHAR(5), -- 판매자(김진수, 윤민수)
    season CHAR(2), -- 시즌
    amount int 		-- 수량
);


INSERT INTO pivotTest VALUES('김진수','겨울',10),('윤민수','여름',15),('김진수','가을',25),
	('김진수','봄',3),('김진수','봄',37),('윤민수','겨울',40),('윤민수','여름',64),('김진수','여름',14),('윤민수','겨울',22);
    
SELECT * FROM PIVOTtEST;

SELECT uNAME ,
		SUM(IF(season='봄',amount,0)) AS '봄',
        SUM(IF(season='여름',amount,0)) AS '여름',
        SUM(IF(season='가을',amount,0)) AS '가을',
        SUM(IF(season='겨울',amount,0)) AS '겨울',
        SUM(amount) AS '합계' FROM pivotTest GROUP BY uName;

-- 계절별로 판매자의 판매수량을 집계하여 출력하는 피벗테이블을 생성해주세요.
SELECT season ,
		SUM(IF(uName='김진수',amount,0)) AS '김진수',
        SUM(IF(uname='윤민수',amount,0)) AS '윤민수',
        SUM(amount) AS '합계' FROM pivotTest GROUP BY season;
        
        
-- JSON 데이터
/*
	웹과 모바일 응용 프로그램에서는 데이털르 교환하기 위해 개발형 표준 포맷인 JSON 을 활용한다.
	JSON은 속성(KEY)와 값(Value)으로 쌍으로 구성되어 있다. 독립적인 데이터 포맷이다.
    포맷이 단순하고 공개되어 있어 여러 프로그래밍 언어에서 채택하고있다.
    {
		"userName" : "김삼순",
        "birthYear": 2002,
        "address"  : "서울 성동구 북가좌동",
        "mobile"   : "01012348989"
    }// 중괄호를 객체라 한다.  => 김삼순 회원의 정보
    
*/

select*from usertbl;

use bookstore;

select * from usetbl;


SELECT json_object('name',name,'height',height) AS '키 180이상 회원의 정보'
FROM usertbl
WHERE height >= 180;


-- JSON을 위한 MYSQL은 다양한 내장함수를 제공한다.

	SET @json = '{
		"usertbl1" : [
			{"name": "임재범", "height": 182},
            {"name": "이승기", "height": 182},
            {"name": "성시경", "height": 186}
        ]
    
    }';

	SELECT JSON_VALID(@json) AS JSON_VALID;
    SELECT JSON_SEARCH(@json,'all','임재범') as JSON_SEARCH;
    SELECT JSON_SEARCH(@json,'$,usertbl1[0].mDate','2024-07-29') as JSON_INSERT;
    SELECT JSON_REPLACE(@json,'$.usertbl1[0].name','임영웅') as JASON_REPLACE;
    SELECT JSON_REMOVE(@json, '$.usertbl1[1]') as JSON_REMOVE;
    
    