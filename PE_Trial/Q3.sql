-- Cau 3
/*Test1
Write a query to display all customers having CustomerName starting with B and
placed orders in December 2017. Display the result by descending order of Segment
and then by ascending order of CustomerName
*/
select distinct Customer.*
from Customer join Orders on Customer.ID = Orders.CustomerID
and CustomerName like 'B%' -- % thay cho chuoi ky tu bat ky; _ 1 ky tu bat ky
and month(OrderDate) = 12 and year(OrderDate) = 2017
order by Segment desc, CustomerName asc

/*Test2
Write a query to display the ID, CustomerName, City, State of all customers
who placed orders from 05 December 2017 to 10 December 2017 and their orders are
shipped less than 3 days. Display the result by ascending order of State and then
by descending order of City
*/
select distinct Customer.ID, CustomerName, City, State
from Orders join Customer on Orders.CustomerID = Customer.ID
and OrderDate between '2017-12-05' and '2017-12-10'
and ShipDate - OrderDate < 3
order by State desc, City asc
