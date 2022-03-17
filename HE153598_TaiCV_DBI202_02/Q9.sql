	CREATE TRIGGER tr_insert_Product on Product
	AFTER INSERT 
	AS
	BEGIN 
		SELECT ProductID, i.Name as ProductName, i.ModelID, p.Name as ModelName FROM inserted i join 
		ProductModel  p on i.ModelID = p.ModelID
	END



