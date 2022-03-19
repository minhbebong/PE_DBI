delete from ProductInventory
where ProductID not in (select ModelID from dbo.ProductModel where ModelID = 33)

DELETE FROM ProductInventory
WHERE ProductID = (SELECT P.ProductID
FROM ProductModel PM, Product P
WHERE PM.ModelID = P.ModelID AND PM.ModelID = 33)