-- Cau 5

/*Test1
Find all orders that were ordered on the same day as the latest order as
follows:
*/
select *
from Orders
where OrderDate = (
	select max(OrderDate)
	from Orders
)

 
/*Test2
Write a query to display ProductID, ProductName, Quantity of all products which
have the highest Quantity in one order.
*/
select ProductID, ProductName, Quantity
from Product join OrderDetails on Product.ID = OrderDetails.ProductID
where Quantity = (
	select max(Quantity)
	from OrderDetails
)