Select
	p.SubcategoryID,
	ps.Name as 'SubCategoryName', 
	Category, 
	Count(*) as NumberOfProducts
from ProductSubcategory ps
join Product p on ps.SubcategoryID = p.SubcategoryID
group by p.SubcategoryID,ps.Name, Category
order by Category asc, NumberOfProducts desc, SubCategoryName asc