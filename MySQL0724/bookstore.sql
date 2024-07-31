use bookstore;

-- 1
-- (5)
select count(publisher)
from customer c, book b, orders o
where c.custid = o.custid and b.bookid = o.bookid and c.name = '박지성';

-- (6)
select b.bookname, b.price, b.price-o.saleprice as '정가와 판매가격 차이' 
from customer c, book b, orders o
where c.custid = o.custid and b.bookid = o.bookid and c.name = '박지성';

-- (7)
select b.bookname
from customer c, book b, orders o
where c.custid = o.custid and b.bookid = o.bookid and c.name != '박지성';

-- 2
-- (8)
select custid
from customer c, book b, orders o
where c.custid and o.orderid = 'null';

-- (9)
select sum(o.saleprice) as '총액', avg(o.saleprice) as '평균액'
from customer c, orders o
where c.custid and o.custid;

-- (10)
select c.name
from customer c, book b, orders o
where c.custid = o.custid and b.bookid = o.bookid
group by c.name, o.saleprice
order by c.name;

-- (11)


