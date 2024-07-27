use practice;

select*from table1;

-- 모든 문자열을 소문자로 변환
SELECT LOWER(name)
FROM table1;

-- 모든 문자열을 대문자로 변환
SELECT UPPER(name)
FROM table1;

-- 왼쪽 공백제거 LTRIM()
SELECT LTRIM(name)
FROM table1;

-- 오른쪽 공백제거 RTRIM()
SELECT RTRIM(name)
FROM table1;

-- LTRIM and RTRIM
SELECT RTRIM(LTRIM(name))
FROM table1;

-- TRIM 양쪽 공백 제거 or 특정 문자 제거
-- TRIM([[BOTH | LEADING | TRAILING] [remstr] FROM] str) 양쪽, 왼쪽, 오른쪽
SELECT TRIM(name)
FROM table1;

SELECT TRIM(LEADING 'c' FROM name) -- 대소문자 구분해야된다.
FROM table1;

SELECT TRIM(LEADING 'C' FROM name)
FROM table1;

-- SUBSTR 원하는 문자열 조회하기
SELECT SUBSTR(name,2,3)
FROM table1;

SELECT SUBSTR(TRIM(name),2,3)
FROM table1;

-- LENGHT 문자열 길이
SELECT length(name)
FROM table1;

SELECT length(rtrim(name))
FROM table1;

SELECT length(trim(name))
FROM table1;

-- REPLACE 문자열 변환
-- 명시해주지 않으면 해당 문자열을 제거한다.
SELECT replace(name,'o','T123')
FROM table1;

-- LPAD 설정한 길이가 될 때 까지 왼쪽을 특정 문자로 채우는 함수
SELECT LPAD(name,10, 'a')
FROM table1;

-- LPAD 설정한 길이가 될 때 까지 오른쪽을 특정 문자로 채우는 함수
SELECT RPAD(name,10, '%')
FROM table1;

