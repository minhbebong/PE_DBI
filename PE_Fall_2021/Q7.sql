--SELECT bieu_thuc1, bieu_thuc2, … bieu_thucn
--FROM bang
--[WHERE dieu_kien]
--INTERSECT // UNION // EXCEPT
--SELECT bieu_thuc1, bieu_thuc2, … bieu_thucn
--FROM bang
--[WHERE dieu_kien];
--NHỚ DÙNG WITH AS
---------------------------
with t as (
	select l.locationID, max(Quantity) as Quantity  from Product p 
	join ProductInventory i on p.ProductID = i.ProductID
	join Location l on i.LocationID = l.LocationID
	group by l.LocationID
)
select distinct
	l.LocationID, 
	l.Name as LocationName, 
	p.ProductID, 
	p.Name as ProductName, 
	Quantity
from Product p 
join ProductInventory i on p.ProductID = i.ProductID
join Location l on i.LocationID = l.LocationID
where   
order by LocationName asc, ProductName desc

