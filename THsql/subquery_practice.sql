-- 1. 각 직원의 이름과 그들이 속한 부서의 이름을 조회하되, 부서가 없는 직원도 포함하세요.
SELECT concat(e.first_name,' ',e.last_name), j.job_title, e.department_id
FROM employees e LEFT OUTER JOIN jobs j
ON e.job_id = j.job_id;

SELECT *
FROM employees
WHERE department_id is null;


-- 2. 각 직원의 이름과 그들의 직급을 조회하되, 해당 직급의 평균 월급보다 높은 월급을 받는 직원만 조회하세요.
SELECT concat(e.first_name,' ',e.last_name), e.salary
FROM employees e
WHERE e.salary > (
	SELECT avg(e2.salary)
	FROM employees e2
    WHERE e2.department_id = e.department_id
    )
ORDER BY e.salary desc;

select department_id ,avg(salary)
FROM employees
GROUP BY department_id
ORDER BY avg(salary) desc;

-- 3. 각 부서의 이름과 해당 부서에 속한 직원 수를 조회하되, 직원 수가 5명 이상인 부서만 조회하세요.
SELECT j.job_title, count(e.department_id)
FROM employees e join jobs j on e.job_id = j.job_id
GROUP BY j.job_title
HAVING count(e.department_id) >= 5;

SELECT j.job_title, count(e.department_id)
FROM employees e join jobs j on e.job_id = j.job_id
GROUP BY j.job_title
HAVING count(e.department_id) >= 0;


-- 4. 각 직원의 이름과 그 직원의 상사의 이름을 조회하되, 상사가 없는 직원도 모두 포함하세요.
SELECT concat(e.first_name,' ',e.last_name) 직원이름, concat(e2.first_name,' ',e2.last_name) 상사이름
FROM employees e 
LEFT JOIN employees e2 on e.manager_id = e2.employee_id
ORDER BY e2.first_name desc;

SELECT concat(first_name,' ',last_name)
FROM employees
WHERE manager_id is null;

-- 5. 각 부서에서 가장 높은 월급을 받는 직원의 이름과 월급을 조회하세요.
SELECT *
FROM employees e
JOIN departments d
ON e.department_id = d.department_id WHERE e.salary >= (
	SELECT max(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.salary desc;

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
ORDER BY MAX(salary) desc;

-- 6. 'Sales' 부서에 속한 직원들의 이름과 직급을 조회하되, 월급이 부서 평균보다 높은 직원들만 조회하세요.
SELECT concat(e.first_name,' ',e.last_name), j.job_title, e.salary
FROM employees e 
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name like 'Sales'
and e.salary > (
	SELECT avg(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.salary;


-- 7. 각 직급의 평균 월급을 조회하되, 평균 월급이 8000 이상인 직급만 조회하세요.
SELECT j.job_title, avg(e.salary) 평균월급
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title
HAVING 평균월급 >= 8000
ORDER BY 평균월급 desc; 


-- 8. 각 부서의 이름과 해당 부서의 평균 월급을 조회하되, 평균 월급이 7000 이상인 부서만 조회하세요.
SELECT d.department_name, avg(e.salary) 평균월급
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING 평균월급 >= 7000
ORDER BY 평균월급 desc; 


-- 9. 월급이 5000에서 10000 사이인 직원들의 이름과 부서 이름을 조회하세요.
SELECT concat(e.first_name,' ',e.last_name) 이름, d.department_name 부서명, e.salary 월급
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary between 5000 and 10000
ORDER BY e.salary desc;


-- 10. 각 부서에서 두 번째로 높은 월급을 받는 직원의 이름과 월급을 조회하세요.
SELECT d.department_id 부서명,(e.first_name,' ',e.last_name) 이름, e.salary 월급
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
ORDER BY e.salary desc
LIMIT 2;

-- 11. 각 직원의 이름과 직급의 최소 월급과 비교하여 그 직원의 월급이 최소 월급보다 높은지 여부를 조회하세요.
SELECT department_id ,min(salary)
FROM employees
GROUP BY department_id;
    
SELECT j.job_title, concat(e.first_name,' ',e.last_name), e.salary
FROM employees e, jobs j
WHERE e.salary > (
	SELECT min(e2.salary)
	FROM employees e2
    WHERE e2.job_id = j.job_id and e.department_id = e2.department_id
    GROUP BY j.job_title
)
ORDER BY j.job_title desc;


-- 12. 각 부서의 이름과 해당 부서에서 최대 월급과 최소 월급의 차이를 조회하세요.
SELECT d.department_name 부서이름, max(e.salary) '최대 월급', min(e.salary) '최소 월급', max(e.salary)-min(e.salary) '월급 차이'
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
GROUP BY e.department_id;


-- 13. 각 직급의 최소 월급보다 적게 받는 직원들의 이름과 월급을 조회하세요.



-- 14. 각 부서의 이름과 해당 부서에서 가장 적게 받는 직원의 이름과 월급을 조회하세요.
SELECT d.department_name,concat(e.first_name,' ',e.last_name), e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND e.salary in (
	SELECT min(e2.salary)
	FROM employees e2
	WHERE e2.department_id = d.department_id
	GROUP BY e2.department_id
);


-- 15. 'Manager' 직급에 속한 직원들의 이름과 부서 이름을 조회하세요.
SELECT (SELECT concat(e.fisrt_name,' ',e.last_name), j.job_title FROM jobs j WHERE e.job_id = j.job_id and job_title like 'Manager')
FROM employees e;

SELECT concat(e.fisrt_name,' ',e.last_name), j.job_title
FROM employees e 
JOIN jobs s ON e.job_id = j.job_id and j.job_title like '%Manager%';

SELECT job_title
FROM jobs;

-- 16. 모든 부서 중 직원 수가 가장 많은 부서의 이름과 직원 수를 조회하세요.
SELECT d.department_name 부서이름, count(d.department_id) '직원 수'
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
ORDER BY count(d.department_id) desc
LIMIT 1;



-- 17. 각 직원의 이름과 그들이 속한 부서의 위치 ID를 조회하세요.



-- 18. 'IT' 부서에 속한 직원들의 이름과 그들의 상사의 이름을 조회하세요.



-- 19. 각 직원의 이름과 직급과 해당 직급의 최대 월급을 조회하세요.



-- 20. 각 부서의 이름과 해당 부서에서 가장 적게 받는 직원의 이름과 월급을 조회하세요.


