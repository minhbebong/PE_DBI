delete from ProductInventory
where ProductID not in (select ModelID from dbo.ProductModel where ModelID = 33)