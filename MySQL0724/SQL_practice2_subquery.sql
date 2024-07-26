-- A. SQL Practice

-- A.6 서브쿼리를 사용하여 해결 하세요
-- [문제 1] HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다.
-- Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
SELECT concat(e.first_name,' ',e.last_name) Name, j.job_title 업무명, e.salary 급여
FROM employees e, jobs j
WHERE e.job_id = j.job_id and e.salary > (SELECT e2.salary FROM employees e2 WHERE e2.last_name = 'Tucker')
ORDER BY salary desc;

select concat(first_name,' ',last_name) Name, salary 급여
from employees
where last_name like 'Tucker';

-- [문제 2] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의
-- 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오
SELECT CONCAT(e1.first_name, ' ', e1.last_name) AS Name,j.job_title AS 업무명,
	   e1.salary AS 급여, e1.hire_date AS 입사일
FROM employees e1, jobs j
WHERE e1.job_id = j.job_id and e1.salary = (SELECT MIN(e2.salary) FROM employees e2 WHERE e2.job_id = e1.job_id)
ORDER BY e1.salary DESC;




select concat(first_name,' ',last_name) ,department_id, salary
from employees
where department_id is null;

-- [문제 3] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭),
-- 급여, 부서번호, 업무를 출력하시오
SELECT concat(e1.first_name,' ',e1.last_name) Name, e1.salary 급여, e1.department_id, j.job_title 업무명  
FROM employees e1, jobs j
where e1.job_id = j.job_id and e1.salary  > (
	SELECT AVG(e2.salary) 
    FROM employees e2 
    WHERE e1.department_id = e2.department_id
);

select avg(salary)
from employees
where department_id = 60;


-- [문제 4] 사원들의 지역별 근무 현황을 조회하고자 한다.
-- 도시 이름이 영문 'O' 로 시작하는 지역에 살고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오
SELECT
	e.employee_id 사번, 
    CONCAT(e.first_name, ' ', e.last_name) 이름, 
    j.job_title 업무, 
    e.hire_date 입사일,
    l.city 도시명
FROM 
	employees e,
	jobs j,
    locations l,
    departments d
WHERE 
	e.job_id = j.job_id 
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND e.department_id in (
		SELECT 
			d.department_id
        FROM 
			departments d, 
			locations l2 
		WHERE 
			d.location_id = l2.location_id
            and l2.city LIKE 'O%'
		);

SELECT
    e.employee_id 사번,
    CONCAT(e.first_name, ' ', e.last_name) 이름,
    j.job_title 업무,
    e.hire_date 입사일,
    l.city 도시명
FROM
    employees e,
    jobs j,
    locations l,
    departments d
WHERE
    e.job_id = j.job_id
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.city LIKE 'O%';


-- [문제 5] 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 성과 이름(Name으로 별칭),
-- 업무, 급여, 부서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오
SELECT 
    CONCAT(e1.first_name, ' ', e1.last_name) Name,
    j.job_title 업무,
    e1.salary 급여,
    e1.department_id 부서번호,
    (SELECT AVG(e2.salary) FROM employees e2 WHERE e2.department_id = e1.department_id) AS 'Department Avg Salary'
FROM 
    employees e1, jobs j
WHERE
	e1.job_id = j.job_id
ORDER BY 
    e1.department_id, e1.salary DESC;
    
    
SELECT AVG(e2.salary) 
FROM employees e1 inner join employees e2
on e1.department_id = e2.department_id = '60';   



-- [문제 6] ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오
SELECT concat(e1.first_name,' ',e1.last_name) Name, e1.salary 급여
FROM employees e1, jobs j
WHERE e1.salary > (
	SELECT e2.salary 
    FROM employees e2 
    WHERE e2.job_id = j.job_id and last_name like 'Kochhar' or first_name like 'Kochhar' )
ORDER BY e1.salary desc;

select concat(first_name,' ',last_name), salary
from employees
order by salary desc;

-- [문제 7] 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오
SELECT e1.employee_id 사원번호 ,concat(e1.first_name,' ',e1.last_name) 이름, j.job_title, e1.salary 급여, e1.department_id 부서번호
FROM employees e1, jobs j
WHERE e1.job_id = j.job_id and e1.salary < (SELECT AVG(e2.salary) FROM employees e2)
ORDER BY e1.salary desc;

SELECT avg(salary)
FROM employees;

-- [문제 8] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
SELECT min(e1.salary) '100번 부서의 최소급여보다 최소 급여가 많은 부서별 최소급여'
FROM employees e1, departments d, jobs j
WHERE e1.department_id = d.department_id 
and e1.job_id = j.job_id
and d.department_id in (
	SELECT 
		department_id
    FROM 
		departments
    WHERE
		department_id != '100'
)
GROUP BY 
	d.department_id
HAVING min(e1.salary) > (
	SELECT min(salary) 
    FROM employees
    WHERE department_id = '100');

SELECT min(salary) 
FROM employees
WHERE department_id = '100';

-- [문제 10] 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오



-- [문제 9] 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오 출력시 업무별로 정렬하시오
 SELECT 
	e1.employee_id 사원번호, 
	concat(e1.first_name, ' ', e1.last_name) AS Name,
	j.job_title AS 업무명,
	e1.department_id 부서번호,
	e1.salary AS 급여
FROM 
	employees e1,
    jobs j
WHERE
	e1.job_id = j.job_id 
    and e1.salary = (
		SELECT 
			MIN(e2.salary) 
		FROM 
			employees e2 
        WHERE
			e2.job_id = e1.job_id
		)
ORDER BY j.job_title;
 
 
-- [문제 11] 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.
SELECT
	CONCAT(e.first_name, ' ', e.last_name) 이름,
    j.job_id 업무,
    d.department_name 부서명,
    e.hire_date 입사일,
    e.salary 급여,
    e.department_id 부서번호
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id and j.job_id like 'SA_MAN';


SELECT j.job_id
FROM employees e, jobs j
WHERE e.job_id = j.job_id and j.job_id like 'SA_MAN';


-- [문제 12] 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오

SELECT 
    e1.manager_id AS 사원번호, 
    CONCAT(e2.first_name, ' ', e2.last_name) AS 이름,
    COUNT(e1.employee_id) '부하직원 수'
FROM 
    employees e1
JOIN 
    employees e2 ON e1.manager_id = e2.employee_id
GROUP BY 
    e1.manager_id
ORDER BY 
    COUNT(e1.employee_id) DESC
LIMIT 1;


-- [문제 13] 사원번호가 123인 사원의 업무가 같고 
-- 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오
SELECT 
    e1.employee_id 사원번호,
    CONCAT(e1.first_name, ' ', e1.last_name)이름,
    j.job_title 직업,
    e1.salary 급여
FROM 
    employees e1
JOIN 
    jobs j 
ON 
	e1.job_id = j.job_id
WHERE 
    e1.job_id = (SELECT job_id FROM employees WHERE employee_id = 123)
    AND e1.salary > (SELECT salary FROM employees WHERE employee_id = 192);


-- [문제 14] 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는 사원의 사원번호,
-- 이름,업무,입사일 자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.
SELECT  
	CONCAT(e.first_name, ' ', e.last_name) 이름,
    j.job_title 업무,
    e.hire_date 입사일,
    e.salary 급여,
    e.department_id 부서번호
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id 
WHERE salary > (SELECT min(salary) FROM employees WHERE department_id = 50)
and e.department_id != '50'
ORDER BY e.salary desc;
	


-- [문제 15] (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는 사원의 사원번호,
-- 이름,업무,입사일자,급여,부서번호를 출력하시오. 단 50번 부서의 사원은 제외합니다.
SELECT
	CONCAT(e.first_name, ' ', e.last_name) 이름,
    j.job_title 업무,
    e.hire_date 입사일,
    e.salary 급여,
    e.department_id 부서번호
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id 
WHERE salary > (SELECT max(salary) FROM employees WHERE department_id = 50)
and e.department_id != '50'
ORDER BY e.salary desc;


