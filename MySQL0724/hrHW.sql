-- 하나의 스키마에서 여러 테이블이 존재하고 정보를 저장하고 있다.
-- 테이블간의 관계를 기반으로 수행되는 연산
-- join sql:1999 문법 이전과 이후 구분
-- join 종류는 등가조인(equi join) ==> 오라클 : natural / inner join
-- outer join (외부조인) ===> left outer join, right outer join
-- self join(자체 조인)
-- 비등가 조인
-- 카티시안 곱 ==> cross join

use hr;

-- 등가조인 = equi 조인 = inner join 조인 조건에서 '='을 사용하는 조인 
	select emp.employee_id 사원번호, emp.first_name 이름, emp.department_id 부서번호, dept.department_id
		   부서번호, dept.department_name 부서이름
	from employees emp, departments dept
	where emp.department_id = dept.department_id;
    
-- 지역코드가 1700인 사원의 이름과 지역번호, 부서번호, 부서이름을 조회하세요
	select l.location_id, concat(e.first_name,' ',e.last_name) as name, d.department_id, d.department_name
	from employees e, departments d, locations l
	where e.department_id=d.department_id and d.location_id and l.location_id = 1700;


-- 각 사원을 관리하는 상사의 이름을 조회하세요
-- 위계성 데이터 셀프 조인
select e1.employee_id as 사원번호, concat(e1.first_name+' '+e1.last_name) as 사원이름,
	   e1.manager_id 상사번호, e2.employee_id "상사의 사원번호", e2.first_name 상사이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

select e1.employee_id as 사원번호, concat(e1.first_name+' '+e1.last_name) as 사원이름,
	   e1.manager_id 상사번호, e2.employee_id "상사의 사원번호", e2.first_name 상사이름
from employees e1 inner join employees as e2 
on e1.manager_id = e2.employee_id;



-- left outer join
select dept.department_id 부서번호, dept.department_name 부서이름, emp.last_name 사원명
from departments dept left outer join employees emp
on dept.department_id = emp.department_id;


-- 1.모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
select concat(emp.first_name,' ',emp.last_name) as 사원이름, dept.department_id as 부서번호, dept.department_name as '부서 이름'
from employees emp, departments dept
where emp.department_id = dept.department_id;



-- 2.부서번호 80에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select distinct d.department_id 부서번호, l.city '부서의 위치'
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id and l.country_id = c.country_id and d.department_id = 80;

-- 3.커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
select concat(e.first_name,' ',e.last_name) as 사원이름, d.department_name as '부서 이름', l.location_id 위치번호, l.city 도시명
from employees e, departments d, locations l
where e.department_id = d.department_id and l.location_id = d.location_id and e.commission_pct is not null;



-- 4.이름에 a가 포함된 모든 사원의 이름과 부서명을 조회하세요
select concat(e.first_name,' ',e.last_name) as 사원이름, d.department_name as '부서 이름'
from employees e, departments d
where e.department_id = d.department_id and (e.last_name like '%a%' or e.first_name like '%a%');

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요
select l.city '도시명', concat(e.first_name,' ',e.last_name) as 사원이름, e.job_id 업무, d.department_id '부서 번호', d.department_name 부서명
from employees e, departments d, locations l
where l.location_id = d.location_id and d.department_id = e.department_id and l.city = 'toronto';


-- 6. 사원의 이름 과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 
-- 각각의 컬럼명을 Employee, Emp#, Manger, Mgr#으로 지정하세요
select concat(e2.first_name,' ',e2.last_name) employee, e2.employee_id 'Emp#',
	   concat(e1.first_name,' ',e1.last_name) Manager, e1.employee_id 'Mgr#'
from employees e1 inner join employees e2
on e1.employee_id = e2.manager_id
order by e1.employee_id;


select * from employees;

-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE manager_id IS NULL OR CONCAT(first_name,' ', last_name) like 'Steven King'
ORDER BY employee_id; -- ?

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
-- select concat(e1.first_name,' ',e1.last_name) 같은부서
-- from employees e1 inner join employees e2
-- on e1.department_id = e2.department_id and concat(e2.first_name,' ',e2.last_name) = 'John Chen';

select concat(e1.first_name,' ',e1.last_name) 같은부서
from employees e1 inner join employees e2
on e1.department_id = e2.department_id and e2.employee_id = 202;

-- 지정한 사람과 부서 번호가 같아야함

-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
select concat(e.first_name,' ',e.last_name) 사원이름, e.job_id 업무, d.department_name 부서이름, salary 급여 , grade_level 급여등급
from employees e, departments d, jobs j, job_grades jg
where e.department_id = d.department_id and e.job_id = j.job_id and e.salary
between jg.lowest_sal and jg.highest_sal
order by jg.grade_level desc;

select *
from job_grades;
