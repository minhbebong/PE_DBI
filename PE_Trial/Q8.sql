/*Test1
Write a stored procedure named TotalAmount to calculate the total amount of an
order with OrderID (nvarchar(255)) is its input parameter and the TotalAmount
(float) is the output parameter. Note that the Amount of each product in an order
is calculate as SalePrice*Quantity*(1-Discount) and the TotalAmount of each order
is the sum of all the Amounts of all products in the order
*/

create proc TotalAmount @OrderID nvarchar(255), @totalAmount float output
as
begin
	set @totalAmount = (
		select sum(SalePrice*Quantity*(1-Discount))
		from OrderDetails
		where OrderID = @OrderID
	)
end

 
/*declare @t float
exec TotalAmount 'CA-2014-100006', @t output
print @t*/ -- xoa di hoac comment
 
 
/*Test2
Write a stored procedure named CountProduct to calculate the number of different
products in an order with OrderID (nvarchar(255)) is input parameter and the
NbProducts (int) is the output parameter of the procedure.
For example, when we execute the following code, the result should be 1:
*/
create proc CountProduct @orderID nvarchar(255), @NbProducts int output
as
begin
	set @NbProducts = (
		select count(ProductID)
		from OrderDetails
		where OrderID = @orderID
	)
end

 
/*declare @t int
exec CountProduct 'CA-2014-100391', @t output
print @t*/