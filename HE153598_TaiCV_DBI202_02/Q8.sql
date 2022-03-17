CREATE  PROC proc_product_model
@modelID int,
@numberOfProducts int output
AS
BEGIN
	set @numberOfProducts = (select distinct count(ProductID) from ProductModel pm 
							join Product p on pm.ModelID = p.ModelID
							where p.ModelID = @modelID)
END
