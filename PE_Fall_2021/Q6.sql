
with t as (Select p.ProductID, Name, SUM(Quantity) as TotalQuantity from Product p
join ProductInventory i on p.ProductID = i.ProductID
group by p.ProductID, Name)

Select ProductID, Name, TotalQuantity from t
where TotalQuantity = (select top 1 TotalQuantity from t order by TotalQuantity desc)

with T as
(select P.ProductID, P.Name , sum(PI.Quantity) as TotalQuantity
from Product P,[Location] L, ProductInventory [PI]
where L.LocationID = PI.LocationID and P.ProductID = PI.ProductID
group by P.ProductID, P.Name )
Select T.*
from T 
where T.TotalQuantity = (Select Max(T.TotalQuantity) from T)



