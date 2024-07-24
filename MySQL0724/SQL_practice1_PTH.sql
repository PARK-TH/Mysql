use hr;

-- A.1 데이터 검색 : SELECT

-- [문제 0] 사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력 하시오.
-- 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
select employee_id 사원번호, concat(first_name,' ',last_name) 이름, salary 급여, job_id 업무,	
	   hire_date 입사일, manager_id '담당 사원번호'
from employees;

-- [문제 1] 사원정보(EMPLOYEES) 테이블에서 사원의 성과 이름은 Name, 업무는 Job, 급여는 Salary,
-- 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary,
-- 급여에 $100 보너스를 추가하여 계 산한 연봉은 Increased Salary라는 별칭으로 출력하시오
select concat(first_name,' ',last_name) Name, job_id Job, salary Salary, 
	   (salary*12)+100 'Increased Ann Salary', (salary+100)*12 'Increased Salary'
from employees;

-- [문제 2] 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 
-- 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오
select last_name Name, concat(last_name,': 1 Year Salary = $' ,(salary*12))'1 Year Salary'
from employees;

-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
select distinct job_id 업무
from employees;


-- A.2 데이터 제한 및 정렬 : WHERE, ORDER BY

-- [문제 0] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다.
-- 사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인 
-- 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오(75행).
SELECT CONCAT(first_name,' ',last_name) Name, salary Salary
FROM employees
WHERE salary NOT BETWEEN 7000 and 10000
ORDER BY salary;

-- [문제 1] 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오.
-- 이때 머리글은 ‘e and o Name’라고 출력하시오
SELECT CONCAT(first_name,' ',last_name) 'e and o Name'
FROM employees
WHERE (first_name LIKE '%e%' OR '%o%') OR (last_name LIKE '%e%' OR '%o%')
ORDER BY CONCAT(first_name, ' ', last_name);

-- [문제 2] 현재 날짜 타입을 날짜 함수를 통해 확인하고,
-- 2006년 05월 20일부터 2007년 05월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭),
-- 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오
SELECT CONCAT(first_name,' ',last_name) NAME, employee_id 사원번호, hire_date 고용일자
FROM employees
WHERE hire_date BETWEEN '2006-05-20' AND '2007-05-20';

-- [문제 3] HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다.
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오.
-- 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
SELECT CONCAT(first_name,' ',last_name) Name, salary 급여, job_id 업무, commission_pct 수당율
FROM employees
ORDER BY salary DESC, commission_pct DESC; 


-- A.3 단일 행 함수 및 변환 함수

-- [문제 0] 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다.
-- 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다.
-- 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만 (반올림) 표시하는 보고서를 작성하시오.
-- 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급 여(Increased Salary로 별칭)순으로 출력한다
SELECT employee_id as 사번, CONCAT(first_name, ' ', last_name) as Name, salary as 급여, 
       ROUND(salary * 1.123) as 'Increased Salary'
FROM employees
WHERE department_id = 60;


-- [문제 1] 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다.
-- 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 표시하시오(18행).
SELECT CONCAT(first_name,' ', last_name) AS Name, (job_id) AS 'Employee JOBs'
FROM employees
WHERE last_name LIKE '%s';


-- [문제 2] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다.
-- 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오.
-- 수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고,
-- 별칭은 적절히 붙인다. 또한 출력 시 연봉이 높은 순으로 정렬한다(107행).
SELECT CONCAT(first_name, ' ', last_name) AS Name, salary AS 급여, 
	(salary * 12 + FNULL(ommission_pct * salary * 12, 0)) AS 연봉, 
	IF(commission_pct IS NOT NULL, 'Salary + Commission', 'Salary only') AS '수당여부'
FROM employees
ORDER BY (salary * 12 + IFNULL(commission_pct * salary * 12, 0)) DESC;


-- [문제 3] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오.
-- 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행).
SELECT CONCAT(first_name, ' ', last_name) AS Name, hire_date AS 입사일, DAYNAME(hire_date) AS 입사요일
FROM employees
ORDER BY WEEKDAY(hire_date);