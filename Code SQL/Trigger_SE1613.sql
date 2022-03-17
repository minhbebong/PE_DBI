--Sử dụng DB của Lab3
Use ProductOrders

/*
	TRIGGER sẽ được tự động thực thi khi chúng ta kích hoạt các thao tác sửa đổi dât
	Các thao tác sửa đổi data: Insert, delete, update(xóa -> insert)
	Khi INSERT dữ liệu thì dữ liệu được cho vào 1 bảng tạm có tên là INSERTED
	Khi DELETE dữ liệu thì dữ liệu được cho vào 1 bảng tạm có tên là DELETED
	Khi UPDATE dữ liệu thì dữ liệu được cho vào 2 bảng tạm có tên là DELETED VÀ INSERTED
*/

-- Ví dụ 1: Khi insert dữ liệu vào bằng Customers thì tự động hiển thị những dòng insert

	CREATE TRIGGER trg_insertCustomer on Customers
	AFTER INSERT 
	AS
	BEGIN 
		SELECT * FROM inserted
	END

	INSERT INTO Customers VALUES 
	('KH11', 'NGUYEN VAN A', 'HA NOI', '0123456789', '')


--Ví dụ 2: Khi xóa dữ liệu trong bảng Customers thì tự động hiển thị những data vừa xóa 
--		và hiển thị số lượng data đã xóa

	CREATE TRIGGER trg_deleteCustomer on Customers
	AFTER DELETE
	AS
	BEGIN 
		SELECT * FROM deleted
		DECLARE @COUNT INT = (SELECT COUNT(*) FROM deleted)
		IF @COUNT > 0
		BEGIN
			PRINT @COUNT + ' DELETE THANH CONG'
			
		END
		ELSE 
			PRINT 'THANG NGU, CO CAI GI DAU MA XOA'
	END

	DELETE FROM Customers WHERE CustormerID ='KH04' or CustormerID ='KH11'

/*
Pratice 
1. Tạo trigger, khi update dữ liệu của bảng Customer thì tự động hiển thị thông tin 
	trước và sau khi update 
2. Tạo trigger, khi thay đổi thông tin hóa đơn thì trigger thực hiện: 
	Insert dữ liệu vào bảng hist_Order (chưa có, nên tự tạo ngoài trigger): thông tin order, editdate
3. Tạo trigger, khi thay đổi thông tin trong bảng product
	thì sẽ kiểm tra xem nếu price <stockquantity thì sẽ k cho thay đổi (rollback)
*/

--1: 
	CREATE TRIGGER trg_updateCustomer on Customers
	AFTER UPDATE
	AS 
	BEGIN
		SELECT * FROM deleted
		SELECT * FROM inserted
	END

	UPDATE Customers SET CustormerID = 'KH13'
	WHERE CustormerID = 'KH11'

--2: 
CREATE TABLE hist_Oders
(
	OrderID nvarchar(10) not null, 
	Date smalldatetime
)

select * from Orders