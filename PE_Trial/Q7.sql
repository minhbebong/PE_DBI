-- Cau 7

/*Test1
Display 5 products with the highest unit prices and 5 products with the smallest
unit prices as follows:
*/
with t as (select top 5 *
from Product
order by UnitPrice desc),
s as (select top 5 *
from Product
order by UnitPrice asc)

select * from t
union
select * from s
order by UnitPrice desc -- khong bat buoc order by vi de bai khong yeu cau

 
/*Test2
Write a query to display 5 sub-categories having the highest numbers of different
products and the 5 sub-categories having the smallest numbers of different
products, by descending order of number of different products as follows:
*/

with t as (select top 5 SubCategoryID, count(distinct Product.ID) as NumberOfProducts
from Product
group by SubCategoryID
order by NumberOfProducts desc),
s as (select top 5 SubCategoryID, count(distinct Product.ID) as NumberOfProducts
from Product
group by SubCategoryID
order by NumberOfProducts asc)

select * from t
union
select * from s
order by NumberOfProducts desc