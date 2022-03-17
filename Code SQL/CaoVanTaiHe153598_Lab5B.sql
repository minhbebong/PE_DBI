--1.	Trigger to print a message “N customers are successfully inserted” 
--		when some customers are inserted into the Customers table, where 
--		N is the number of inserted customers.

	CREATE TRIGGER trg_1_LAB5B on Customers
	AFTER INSERT
	AS
	BEGIN 
		DECLARE @count int -- khai báo count
		SET @count = (SELECT COUNT(*) FROM inserted) -- count đếm số dữ liệu đã insert
		PRINT CAST(@count as varchar(max)) + ' customers are successfully inserted' -- in ra 
	END

	INSERT INTO Customers VALUES ('KH17', 'NGUYEN VAN A', 'HA NOI', '0123456789', '')

--2.	Trigger for the insertion of a product into an order (insert into OrderItems),
--		if SellPrice < Price then do not allow the insertion (use after or for in this trigger).
	CREATE TRIGGER trg_2_LAB5B on OrderItems
	AFTER INSERT 
	AS
	BEGIN 
		-- khai báo biến @count để đếm những sản phẩm có giá lớn hơn giá bán
		DECLARE @count int = (SELECT COUNT(*) FROM inserted i JOIN Products p 
		on i.ProductCode = p.ProductCode
		WHERE p.Price > i.SellPrice )
		IF(@count > 0) -- nếu count lớn hơn 0 thì 
		BEGIN
		print 'khong duoc insert'
			ROLLBACK 
		END
	END
	INSERT INTO OrderItems VALUES ('OR001', 'P03', 15, NULL, 100)

/*
--c2 - của BÌNH
create trigger str_Question2 on OrderItems
after insert
as
begin
	select i.*,p.price into #temp from inserted i join Products p
	on i.ProductCode = p.ProductCode

	
	declare @OrderId varchar(max),@ProductCode varchar(max),@price float,@SellPrice float
	
	while(select count(*) from #temp)>0
	begin
		select top 1 @price = price,@SellPrice = SellPrice,@OrderId = OrderId,@ProductCode=ProductCode from #temp
		if(@SellPrice < @price) rollback tran
		delete from #temp where OrderID = @OrderId and ProductCode = @ProductCode
	end 
end
*/

--3.	Trigger for the update of SellPrice in OrderItems, if SellPrice < Price, then do not 
--		allow the update (use instead of in this trigger).

	CREATE TRIGGER TRG_3 on OrderItems
	INSTEAD OF UPDATE 
	AS
	BEGIN
		-- Tạo bảng tạm #temp1 lưu trữ những inserted của update mà Sellprice < Price
			SELECT i.* INTO #temp1 FROM inserted i JOIN Products p
			ON i.ProductCode = p.ProductCode
			WHERE i.SellPrice < p.Price

		-- Tạo bảng tạm #temp2 lưu trữ những inserted của những update mà SellPrice > Price
			SELECT * INTO #temp2 FROM inserted i JOIN Products p
			ON i.ProductCode = p.ProductCode
			WHERE i.SellPrice >= p.Price

		-- Khai báo biến @count
			DECLARE @count int = (SELECT count(*) FROM #temp1)

		-- #temp1 có thì không update 
			IF @count > 0 PRINT 'UPDATE NOT SUCCESS'

		--	#temp1 không có dòng nào thì ta sẽ update dùng 
		--  dữ liệu ở bảng temp2 update cho OrderItems
			ELSE 
				DECLARE @OrderId nvarchar(MAX), @ProductCode nvarchar(MAX), @SellPrice float
				BEGIN
					WHILE (SELECT COUNT(*) FROM #temp2) > 0
					BEGIN
					 -- Chọn ra TOP 1 của bảng #Temp2
						SELECT TOP 1 @OrderId = OrderID,@ProductCode = ProductCode,@SellPrice = SellPrice  FROM #temp2
					 -- UPDATE 
						UPDATE OrderItems SET SellPrice = @SellPrice WHERE  OrderID = @OrderId and ProductCode = @ProductCode
					 -- Xóa đối tượng vừa Update
						DELETE FROM #temp2 WHERE OrderID = @OrderId and ProductCode = @ProductCode
					END
				END
	END

	--------------------------------------
	--C2: 
	drop trigger trg_UpdateOrderItemsForPrice
	create trigger trg_UpdateOrderItemsForPrice on OrderItems
	INSTEAD OF UPDATE as
	BEGIN 
		DECLARE @count int = (SELECT COUNT(*) FROM inserted i JOIN Products p 
		on i.ProductCode = p.ProductCode
		WHERE p.Price > i.SellPrice )
		IF(@count > 0)
		BEGIN
			print 'Insert Error'	
		END
		else 
		begin 
			select * 
			into #temp
			from (select orderID,productcode,SellPrice from inserted) t
			declare @ID varchar(max),@code varchar(max),@sell float;
			while (select count(*) from #temp) >0
			begin 
				select top 1 @ID = orderID,@code = Productcode,@sell = sellprice from #temp
				update OrderItems set SellPrice = @sell where OrderID = @ID and ProductCode = @code
				delete from #temp where OrderID = @ID and ProductCode = @code
			end

		end
	END
	update OrderItems set SellPrice = '500' where OrderID = 'Or007'
