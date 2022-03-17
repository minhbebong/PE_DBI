-- Cau 4
/*Test1
Write a query to display SubCategoryID, SubCategoryName and the corresponding
number of products (NumberOfProducts) in each sub-category having the number of
products greater than 100, by descending order of NumberOfProducts.
*/
select SubCategory.ID as SubCategoryID, SubCategoryName,
count(distinct Product.ID) as NumberOfProducts
from SubCategory left join Product on SubCategory.ID = Product.SubCategoryID
group by SubCategory.ID, SubCategoryName
having count(distinct Product.ID) > 100
order by NumberOfProducts desc

/*Test2
The Amount of each product in an order is calculated by
Quantity*SalePrice*(1-Discount). The TotalAmount of each order is the sum of the
Amount of all product in the order. Write a query to display OrderID, OrderDate,
TotalAmount of all orders having TotalAmount greater than 8000, by descending order
of TotalAmount as follows
*/
select Orders.ID as OrderID, OrderDate, sum(Quantity*SalePrice*(1-Discount)) as TotalAmount
from OrderDetails join Orders on OrderDetails.OrderID = Orders.ID
group by Orders.ID, OrderDate
having sum(Quantity*SalePrice*(1-Discount)) > 8000
order by TotalAmount desc