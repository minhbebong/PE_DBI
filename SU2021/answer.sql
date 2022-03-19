--question1
Create table Customers
(
	CID varchar(20) not null ,
	[name] nvarchar(200),
	[address] nvarchar(100),
	primary key (CID)
)
Create table Loans
(
	loanNumber varchar(20) not null primary key,
	[Date] date,
	Amount float,
	CID varchar(20) not null, 
	Foreign key (CID) references Customers(CID)
)
Create table Payments
(	
	paymentNumber int not null primary key,
	[Date] date,
	Amount float,
	loanNumber varchar(20) not null, 
	Foreign key (loanNumber) references Loans(loanNumber)
)
-- question 2
select * from products p
where p.category_name = 'Cyclocross Bicycles'
-- question 3
select p.product_name, p.model_year, p.list_price, p.brand_name from products p
where p.brand_name = 'Trek' and p.model_year = '2018'
and p.list_price >3000 
order by p.list_price 
-- question 4
select o.order_id, o.order_date, o.customer_id, c.first_name, c.last_name, s.store_name
from orders o, customers c, stores s
where o.customer_id = c.customer_id and s.store_id = o.store_id
and o.order_date between '2016/1/1' and '2016/1/31'
and s.store_name = 'Santa Cruz Bikes'

select order_id, order_date,customer_id,first_name,last_name,store_name 
from orders inner join (staffs inner join stores on staffs.store_id = stores.store_id) 
on orders.staff_id = staffs.staff_id 
where store_name ='Santa Cruz Bikes' and YEAR(order_date) =2016 and MONTH(order_date) = 1

-- question 5
select o.store_id, s.store_name, count(o.store_id) as NumberOfOrderIn2018 
from orders o, stores s
where s.store_id = o.store_id
and YEAR(o.order_date) = 2018
group by o.store_id, s.store_name
order by NumberOfOrderIn2018 DESC

select orders.store_id, store_name, COUNT(orders.order_date) as NumberOfOrdersIn2018 
from orders inner join (staffs inner join stores on staffs.store_id = stores.store_id)
on orders.staff_id = staffs.staff_id group by orders.store_id, store_name,
YEAR(order_date) having YEAR(order_date)=2018 order by NumberOfOrdersIn2018 desc
-- question 6
select s.product_id, p.product_name, p.model_year, sum(s.quantity) as TotalStockQuantity from stocks s, products p
where p.product_id = s.product_id
group by s.product_id, p.product_name, p.model_year
having sum(s.quantity) = (select top 1 sum(s.quantity) as TotalStockQuantity from stocks s, products p
where p.product_id = s.product_id
group by s.product_id, p.product_name, p.model_year
order by TotalStockQuantity DESC)
-- question 7
select * from (
select s.store_name, o.staff_id, st.first_name, st.last_name, count(s.store_name) as NumberOfOrders  from orders o, stores s, staffs st
where st.staff_id = o.staff_id and o.store_id = s.store_id
group by s.store_name, o.staff_id, st.first_name, st.last_name
having count(s.store_name) in
(select max(a.NumberOfOrders) from
(select s.store_name, count(*) as NumberOfOrders  from orders o, stores s
where o.store_id = s.store_id
group by s.store_name, o.staff_id) as a
group by a.store_name)) as c
order by c.store_name ASC

Select top 2 orders.customer_id, first_name, last_name, COUNT(orders.customer_id) 
as NumberOfOrders from customers inner join orders 
on customers.customer_id = orders.customer_id 
group by orders.customer_id, first_name, last_name 

--Cach 2:
select d1.store_name, d1.staff_id, d1.first_name, d1.last_name, d1.NumberOfOrders
from(select s.store_name, s1.staff_id, s1.first_name, s1.last_name, 
count(s.store_name) as NumberOfOrders
from stores s, staffs s1, orders o
where s1.store_id = s.store_id and o.store_id = s.store_id and o.staff_id = s1.staff_id
group by s.store_name, s1.staff_id, s1.first_name, s1.last_name) as d1
inner join (select b1.store_name, max(b1.NumberOfOrders) as num from (select s.store_name, count(s.store_name) as NumberOfOrders
from stores s, staffs s1, orders o
where s1.store_id = s.store_id and o.store_id = s.store_id and o.staff_id = s1.staff_id
group by s.store_name, s1.staff_id) as b1
group by b1.store_name) d2
on d2.store_name = d1.store_name and d2.num = d1.NumberOfOrders
order by d2.store_name ASC

-- question 8
drop proc pr1
create proc pr1 @store_id int, @numberOfStaffs int output 
as
begin
	set @numberOfStaffs = (select count(s.store_id) from staffs s where s.store_id = @store_id group by s.store_id)
end

declare @x int
exec pr1 3, @x output
select @x as NumberOfStaffs

--DEkhac
create proc pr2
@product_id int, @totalAmount int output
as
begin
	select @totalAmount = COUNT(stocks.product_id)
	from stocks, stores
	where stocks.store_id = stores.store_id and @product_id = stocks.product_id
end

-- question 9
drop trigger Tr2
create trigger Tr2 
on stocks after delete
as
begin
	select d.product_id, p.product_name, d.store_id, s.store_name, d.quantity   
	from deleted d, products p, stores s where p.product_id = d.product_id and s.store_id=d.store_id
end

delete from stocks
where store_id = 1 and product_id in (10,11,12)
--question 10
update stocks 
set quantity = 30
where store_id = 1 and product_id in 
(select p.product_id from stocks s, products p
where p.product_id = s.product_id and 
p.category_name = 'Cruisers Bicycles' and s.store_id = 1)

