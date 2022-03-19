--Question 2
select * from Location
where CostRate > 0
--Question 3
select pph.ProductID, pph.Price, pph.StartDate, pph.EndDate from ProductPriceHistory pph
where pph.Price < 100 and YEAR(pph.EndDate) = 2003
order by pph.Price desc
--Question4:
select p.ProductID, p.Name as ProductName, p.Color, ps.SubcategoryID, ps.Name as SubCategoryName,
ps.Category, pch.StartDate,pch.EndDate, pch.Cost as HistoryCost
from Product p
left join ProductSubcategory ps
on ps.SubcategoryID = p.SubcategoryID
left join ProductCostHistory pch
on pch.ProductID = p.ProductID
where p.Color = 'Black' and p.Name like'HL%'
--Question5:
select l.LocationID, l.Name as 'LocationName', COUNT(pdi.ProductID) as NumberOfProducts
from ProductInventory pdi, Location l
where l.LocationID = pdi.LocationID
group by l.LocationID, l.Name
order by NumberOfProducts desc, l.Name asc
--Question7:
select pm.ModelID, pm.Name as ModelName, p.ProductID, p.Name as ProductName,
count(p.ProductID) as NumberOfLocations
from ProductInventory pdi
left join Product p
on pdi.ProductID = p.ProductID
right join ProductModel pm
on pm.ModelID = p.ModelID
where pm.Name like 'HL Mountain%'
group by pm.ModelID, pm.Name, p.ProductID,p.Name
--question8:
drop proc proc_product_model
create proc proc_product_subcategory 
@subcategoryID int, @NumberOfProduct int out
as
begin
	set @NumberOfProduct = (select COUNT(p.ProductID) from ProductSubcategory ps, Product p
	where p.SubcategoryID = p.SubcategoryID and ps.SubcategoryID = @subcategoryID)
end
--Gọi kết quả
declare @x int 
exec proc_product_subcategory 1, @x output
select @x as NumberOfProducts
--question9
create trigger tr_delete_productInventory
on ProductInventory instead of delete
as
begin
	select d.ProductID,d.LocationID, l.Name as LocationName, d.Shelf, d.Bin, d.Quantity 
	from deleted d, Product p, Location l
	where d.ProductID = p.ProductID and l.LocationID = d.LocationID
end

delete from ProductInventory
where ProductID = 1 and LocationID = 1
--question 10.
update ProductInventory
set Quantity = 2000
where ProductID in (select ProductID from Product
where ModelID = 33)




