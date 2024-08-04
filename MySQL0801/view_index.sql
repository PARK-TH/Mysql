-- DBMS(MYSQL)
-- BUILD - IN (내장함수) - Null 처리 필수함수
-- 상수나 속성이름을 입력값으로 받아 단일 값으로 결과를 반환

SELECT ABS(-78),ABS(74);

SELECT ROUND(234.734),FLOOR(42.8456);

SELECT ROUND(14272.23, -2);


use bookstore;

SELECT LENGTH(bookname), char_length(bookname)
FROM book;

SELECT * FROM customer;
select substr(name,1,1)'성', count(*)'인원'
from customer
group by substr(name,1,1);

select orderid '주문번호', orderdate '주문일', adddate(orderdate, interval 10 day)'확정일'
from orders;

SELECT orderid '주문번호', date_format(orderdate, '%y-%m-%d') '주문일',custid '고객번호',bookid '도서번호'
from orders
where orderdate = str_to_date('20240707','%Y%m%d'); 

select sysdate(),now(),date_format(sysdate(), '%Y/%m/%d %a %h:%i') 'sysdate_1';


create table Mybook (
	bookid int,
    price int
);

insert into mybook(bookid,price) values (1, 10000),(2,20000),(3,NULL);

select sum(price) 총합 from mybook;
select price + 100 from mybook where bookid =3;
select sum(price), avg(price),count(*),count(price) from mybook;

select *from mybook where price is null;
select *from mybook where price = ' ';


select name 이름, ifnull(phone, '연락처 없음') 전화번호 from customer;

set @seq:=0;
SELECT (@seq:=@seq+1) 순번, custid, name, phone
from customer
where @seq<2;


create view Vorders
as select o.orderid, o.custid, c.name,o.bookid, b.bookname, o.saleprice, o.orderdate 
   from customer c, orders o, book b
   where c.custid = o.custid and b.bookid = o.bookid;


Select *
from vorders;


create view Soccers
as select bookname from book where bookname like '%축구%';

select *
from soccers;

create or replace view korea(custid,name,addresss)
as select custid,name,addresss
   from customer 
   where addresss like '%대한민국%';

select *
from korea;

SELECT * FROM Vorders where name = '김연아';


-- 1)
create view highorders
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice
   from book b, customer c, orders o
   where b.bookid = o.bookid and o.custid = c.custid and b.price >= 20000;
   
   
-- 2)
select *
from highorders;

create or replace view highorders
as select b.bookid, b.bookname, c.name, b.publisher, o.saleprice
   from book b, customer c, orders o
   where b.bookid = o.bookid and o.custid = c.custid and b.price >= 14000;

-- 3)
select *
from highorders;


-- 인덱스
-- 인덱스가 많아지면 성능적으로 좋지않다.
-- mysql에서 주로 사용하는 인덱스는 크게 클러스터 인덱스(주 인덱스), 보조 인덱스가 있다.
create index ix_book on book(bookname);
create index ix_book2 on book(publisher, price);

show index from book;


select *
from book
where publisher = '대한미디어' and price>=30000;

