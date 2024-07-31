DROP TABLE IF EXISTS job_history;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS regions;


create table employees(
	employee_id int unsigned not null,    -- 사원번호
    first_name varchar(20),            	  -- 성
    last_name varchar(30) not null,       -- 이름
    email varchar(25) not null,
    phone_number varchar(20),         	  -- 전화번호
    hire_date date not null,              -- 입사일
    job_id varchar(10) not null,          -- 직무번호
    salary decimal(8,2) not null,         -- 월급
    commission_pct decimal(2,2),          -- 커미션 (수당)
    manager_id int unsigned,
    department_id integer unsigned,       -- 부서아이디
    primary key (employee_id)
);

create table regions(
	region_id int unsigned not null,
    region_name varchar(25),
    primary key (region_id)
);


create table countries(
country_id char(2) not null, 
country_name varchar(40), 
region_id int unsigned not null, 
primary key(country_id));

create table locations(
location_id int unsigned not null auto_increment,
street_address varchar (40),
postal_code varchar(12),
city varchar(30) not null,
state_province varchar(30),
country_id char(2) not null,
primary key(location_id)
);

create table departments(
department_id int unsigned not null,
department_name varchar(30) not null,
manager_id int unsigned,
location_id int unsigned,
primary key (department_id)
);

create table jobs(
job_id varchar(20) not null,
job_title varchar(40) not null,
min_salary decimal(8,0) unsigned,
max_salary decimal(8,0) unsigned,
primary key(job_id)
);

create table job_history(
department_id int unsigned not null,
start_date date not null,
end_date date not null,
job_id varchar(20) not null,
employee_id int unsigned not null
);

ALTER table countries ADD foreign key (region_id) references regions(region_id);

-- drop table employees

select employee_id,CONCAT(first_name, ' ', last_name) as "Name", salary, hire_date, manager_id
from employees;



select CONCAT(first_name, ' ', last_name) as "Name", job_id as Job, salary as Salary, (salary+100)*12 as Increased_Salary
from employees;

select distinct department_id, job_id
from employees;


select Concat(last_name,': 1 Year Salary = $',salary*12) as "1 Year Salary"
from employees;


select CONCAT(first_name, ' ', last_name) as "Name", job_id as Job, salary as Salary, (salary+100)*12 as Increased_Salary
from employees
where salary not between 7000 and 10000
order by salary desc;