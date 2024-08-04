use sakila;

select * from actor limit 10;

select * from actor order by first_name desc;

(select * from actor order by actor_id limit 10)
union all
(select * from actor order by actor_id desc limit 10) order by actor_id ;

desc payment;

-- 순위 함수: 조회 결과에 순위 부여
-- ROW_NUMBER, RANK, DENSE_RANK, NTILE. + OVER

-- 1) ROW_NUMBER: 유일한 값으로 순위를 부여하는 함수(모든 행에 유일한 값으로 부여한다.)
SELECT row_number() over (order by amount desc) as num, customer_id, amount
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x;

-- 임의의 동점에 대해서 순위를 MySQL이 임의로 부여하지 않게 하기 위해서 order by문에 정렬 조건을 추가
SELECT row_number() over (order by amount desc,customer_id desc) as num, customer_id, amount
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x;

-- RANK (우선 순위를 고려하지 않고 순위를 부여하는 함수): 같은 순위를 처리하는 방식이 row_number와 다르다
-- RANK 함수를 활용시에는 우선순위를 따지지않고 같은 순위를 부여한다.
-- 백분율 처리할 땐 RANK 사용
SELECT RANK() OVER(ORDER BY amount DESC) as num, customer_id, amount
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x;

-- 결과 확인 시, amount 값이 같을 경우 같은 순위를 부여한 것이 확인 됨
-- 공동 순위가 부여된 뒤 그 다음 순위를 같은 순위에 잇는 데이터 개수만큼 건너 뛴 순위가 부여된다.
SELECT staff_id,
RANK() over (PARTITION BY staff_id order by amount desc, customer_id) as num, customer_id, amount
FROM (
	SELECT customer_id, staff_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id, staff_id
) as x;

-- DENSE RANK
SELECT DENSE_RANK() OVER(ORDER BY amount DESC) as num, customer_id, amount
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x;

-- NTILE(): 그룹순위 인자로 지정한 개수만큼 데이터 행을 그룹화 한 다음 각 그룹에 순우ㅏㅣ를 부여하는 함수이다.
-- 각 그룹에 1부터 순위로 매겨지고, 순위는 각 행의 순위가 아니라 행이 속한 그룹의 순위이다.
SELECT NTILE(100) OVER(order by amount desc) as num, customer_id, amount
FROM (
	SELECT customer_id, sum(amount) as amount 
    FROM payment
    GROUP BY customer_id
) as x;

-- 분석함수: 데이터그룹을 기반으로 앞뒤 행을 계산하거나 그룹에 대한 누적분포, 상대 순위 계산 시 사용한다.
-- 집계함수와 달리 분석함수는 그룹마다 여러 행을 반환 할 수 있어서 활용도가 높다.
-- LAG(): 현재 행에서 바로 앞의 행을, LEAD(): 현재 행에서 바로 뒤의 행을 조회
SELECT x.payment_date, LAG(x.amount) over(order by x.payment_date asc) as lag_amount, amount,
	   lead(x.amount) over(order by x.payment_date asc) as lead_amount
FROM (
	SELECT date_format(payment_date, '%y-%m-%d') as payment_date, sum(amount) as amount
    FROM payment
    GROUP BY date_format(payment_date, '%y-%m-%d')
) as x
ORDER BY x.payment_date;

-- 누적 분포를 계산하는 함수 CUME_DIST(): 그룹 내에서 누적 분포를 계산하는 함수 (그룹에서 데이터 값이 포함되는 위치의 누적분포를 계산한다.)
-- 범위는 0초과 1이하의 범위값을 반환한다. 같은 값은 항상 같은 누적 분포값으로 계산한다.
-- NULL 최하위값으로 처리한다. (가장 낮은 값)
SELECT x.customer_id, x.amount, cume_dist() over(order by x.amount desc)
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x
ORDER BY x.amount desc;

-- 상대 순위를 계산하는 함수 PERCENT_RANK 지정한 그룹 또는 쿼리 결과로 이루어진
-- 그룹 내의 상대 순위를 계산할 떄 사용하는 함수이다.
-- CUME_DIST()와의 차이는 분포순위를 구한다는 것이다.
-- 퍼센트에서 위치값을 알 수 있다.(ex 상위 ~%) -> 대쉬보드 만들 때 반드시 사용해야 함
SELECT x.customer_id, x.amount, percent_rank() over(order by x.amount desc)
FROM (
	SELECT customer_id, sum(amount) as amount
    FROM payment
    GROUP BY customer_id
) as x
ORDER BY x.amount desc;
