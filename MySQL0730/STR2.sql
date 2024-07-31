use bookstore;

-- 내장 함수: 제어흐름 함수, 문자열 함수, 수학함수, 날짜/시간 함수, 텍스트 검색 함수, 형변환 함수
-- 1. 제어흐름 함수: IF, IFNULL, NULLIF, CASE~WHEN~ELSE~END
-- 1-1. IF(수식): 수식이 참인지 거짓인지 결과에 따라 분기
SELECT IF(100 > 200, '됨', '안됨');

-- 1-2. IFNULL(수식1, 수식2): 수식1이 NULL이 아니면 수식1 반환, NULL이면 수식2 반환
SELECT IFNULL(NULL, '기본값'); -- '기본값' 반환
SELECT IFNULL('값 있음', '기본값'); -- '값 있음' 반환

-- 1-3. NULLIF(수식1, 수식2): 수식1과 수식2가 같으면 NULL 반환, 다르면 수식1 반환
SELECT NULLIF(1, 1); -- NULL 반환
SELECT NULLIF(1, 2); -- 1 반환

-- 1-4. CASE~WHEN~ELSE~END: 다중 분기를 처리하는 제어흐름 연산자
SELECT 
    CASE 
        WHEN 1 > 0 THEN '1이 0보다 큽니다'
        ELSE '1이 0보다 크지 않습니다'
    END;

-- 문자열 함수
-- 1. 문자열 함수
-- 1-1 ASCII(아스키코드), CHAR(숫자)
SELECT ASCII('A'), CHAR(65);

-- MySQL은 기본 UTF-8 코드를 사용하기 때문에
-- 영문자는 한글자당 1byte, 한글은 한글자 당 3byte 할당한다.
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc'); -- 24	3	3
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다'); -- 72	3	9

-- 1-2. CONCAT(문자열1, 문자열2...): 여러 문자열을 이어준다
SELECT CONCAT('gsegs', ' ', 'W23423'); 
SELECT CONCAT('234L', ' ', 'i234s', ' ', '====!'); 

-- 1-3. CONCAT_WS(구분자, 문자열1, 문자열2...): 구분자와 함께 문자열을 이어준다
SELECT CONCAT_WS('-', '2024', '07', '29');
SELECT CONCAT_WS(' ', '111', '222', '333', '444');

SELECT ELT(2,'ONE','TWO','THREE'),FIELD('둘','ONE','둘','THREE'),FIND_IN_SET('b', 'a,b,c,d'), INSTR('하나 둘 셋','둘'), LOCATE('셋','하나 둘 셋 넷');

-- FORMAT(숫자, 소숫점 자릿수): 숫자를 소수점 아래 자릿수까지 표현, 1000단위로 콤마(,)로 표시
SELECT FORMAT(123456.1231456,4);

SELECT BIN(31), HEX(31), OCT(31); -- 10진수를 2, 16, 8진수로 변환하여 출력
SELECT INSERT('abcdefghjk',3,4,'####'); -- INSERT(기준문자열, 위치, 길이, 삽입할 문자열) 기준 문자열의 위치부터 길이만큼 지우고 삽입할 문자열 끼워넣기


SELECT LEFT('abcdefghi',3), RIGHT('abcdefghi',3); -- 왼쪽 오른쪽 문자열의 길이만큼 반환한다.

-- UPPER(문자열), LOWER(문자열)
SELECT LOWER(), UPPER();
SELECT LCASE(), UCASE();

-- LAD(문자열, 채울문자열), RPAD()
SELECT LPAD('SSG I C',10,'&');

-- TRIM 양쪽 공백 제거 or 특정 문자 제거
-- TRIM([[BOTH | LEADING | TRAILING] [remstr] FROM] str) 양쪽, 왼쪽, 오른쪽
SELECT TRIM('		신세계 자바 프로젝트	');
SELECT TRIM(LEADING '신' FROM '신세계 자바 프로젝트');



-- 왼쪽 공백제거 LTRIM()
SELECT LTRIM('		강아지');

-- 오른쪽 공백제거 RTRIM()
SELECT RTRIM(' dasa		');

-- LTRIM and RTRIM
SELECT RTRIM(LTRIM(' 	문자열입니다 		'));


-- 날짜 및 시간 함수
-- 1.ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
	SELECT ADDDATE('2024-01-01', INTERVAL 31 DAY);
    SELECT SUBDATE('2025-01-01', INTERVAL 31 DAY);
    SELECT SUBDATE('2025-01-01', INTERVAL 1 MONTH);
    SELECT ADDDATE('2025-01-01 23:59:59','1:1:1');
    SELECT SUBDATE('2025-01-01 23:59:59','1:1:1');
    
-- 2.CURDATE():	현재 연-월-일 	CURTIME(): 현재 시:분:초 NOW(),SYSDATE(),LOCALTIME(),LOCALSTAMP -> 연-월-일-시:분:초
-- 3.YEAR(날짜), MONTH(날짜), DAY(날짜), HOUR(시간), SECOND(시간), MICROSECOND(시간)
SELECT YEAR(CURDATE());
SELECT MONTH(CURDATE());
SELECT DAY(CURDATE());
SELECT HOUR(CURTIME()),MICROSECOND(CURRENT_TIME);

SELECT DATE(NOW()),TIME(NOW());

