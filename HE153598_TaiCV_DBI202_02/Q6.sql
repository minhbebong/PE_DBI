
with t as (Select p.ProductID, Name, SUM(Quantity) as TotalQuantity from Product p
join ProductInventory i on p.ProductID = i.ProductID
group by p.ProductID, Name)

Select ProductID, Name, TotalQuantity from t
where TotalQuantity = (select top 1 TotalQuantity from t order by TotalQuantity desc)





