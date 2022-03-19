Select 
p.ProductID, p.Name as ProductName, Color,Price,
i.LocationID, l.Name as LocationName, Shelf, Bin, Quantity
from Product p left join 
ProductInventory i on p.ProductID =i.ProductID
left join Location l on l.LocationID = i.LocationID
where Color = 'Yellow' and Cost < 400

--De Khac
WITH T AS
(select P.ProductID, P.Name AS ProductName, P.Price,P.ModelID AS ModelName ,PS.Name as SubCategoryName, PS.Category
from Product P LEFT JOIN ProductSubcategory PS
ON P.SubcategoryID = PS.SubcategoryID
WHERE Price<100 and Color='Black')
SELECT T.* 
FROM T left join ProductModel PM
on T.ModelName = PM.ModelID