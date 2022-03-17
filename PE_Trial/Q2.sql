-- Cau 2 --
--Test1: Write a query to display all SubCategory in category 3 as follows
select *
from SubCategory
where CategoryID = 3

--Test2: Write a query to display all customers who are ‘Consumer’ and are from Arlington city as follows
select *
from Customer
where Segment = 'Consumer' and City = 'Arlington'
