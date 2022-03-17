Select 
p.ProductID, p.Name as ProductName, Color,Price,
i.LocationID, l.Name as LocationName, Shelf, Bin, Quantity
from Product p left join 
ProductInventory i on p.ProductID =i.ProductID
left join Location l on l.LocationID = i.LocationID
where Color = 'Yellow' and Cost < 400