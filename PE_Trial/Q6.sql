-- Cau 6

/*Test1
Write a query to display CustomerID, CustomerName and the number of orders
(NumberOfOrders) of customers who have the highest number of orders
*/
with t as (select Customer.ID, CustomerName, count(distinct Orders.ID) as NumberOfOrders
from Customer join Orders on Customer.ID = Orders.CustomerID
group by Customer.ID, CustomerName)
select * from t
where NumberOfOrders = (
	select max(NumberOfOrders)
	from t
)

 
/*Test2
Find all the products which appeared in the smallest number of orders, order by
ProductID. The results should be displayed in the form of ProductID, ProductName,
NumberOfOrders.
Note that the following figure show only 22 first rows of the results. In fact,
the query should return 90 rows.
*/
with t as (select Product.ID, ProductName, count(distinct OrderID) as NumberOfOrders
from Product join OrderDetails on Product.ID = OrderDetails.ProductID
group by Product.ID, ProductName
)

select * from t
where NumberOfOrders = (
	select min(NumberOfOrders)
	from t
)