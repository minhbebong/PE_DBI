-- Stored procedure: giống như hàm trong lâp trình, chứ 1 hay nhiều câu lệnh sql
-- Loại 1: Không tham số và không có giá trị trả về

Create procedure sp_getCustomer
as
begin 
	select * from Customers
end
--> sử dụng store như thế nào? Chạy store như thế nào
exec sp_getCustomer

--Loại 2: -- Có tham số, không có giá trị  trả về
create procedure sp_getCustomerbyId
@id varchar(10) -- đây là tham số của store
as
begin 
	select * from Customers where CustomerID = @id
end
exec sp_getCustomerbyId 'ANTON'

--Loại 3: có tham số, có giá trị trả về
create procedure sp_countCustomerbyCountry
@country varchar(10), -- tham so truyen vao
@count int output -- gia tri tra ve 
as 
begin 
	set  @count = (select COUNT(*) from Customers where Country = @country)
	return @count
end

--Gọi store trên và in ra kết quả 
declare @c int
exec sp_countCustomerbyCountry 'USA', @count = @c output;
print @c


--Một số cú pháp lập trình cần biết trong SQL
-- Khai báo biến 

	declare @n int ; -- khai báo 
	set @n = 10; -- gán giá trị

--Câu lệnh if
	if @n < 0
		print 'n la so am'
	else 
		if @n > 0 
		print 'n la so duong'
	else 
		print 'n la so 0'

-- Câu lệnh WHILE

	print 'Cac so chan tu 1 den n'
	declare @i int  = 1;
	while @i < @n
	begin 
		if @i % 2 = 0
		print @i
		set @i = @i + 1
	end

--Ví dụ tạo Store nâng cao 
--Input: ProductID
--Output: xóa những product ID ở bảng product tương ứng với id mà 
--chúng ta truyền vào
create procedure sp_deleteProductID
@id varchar (10)
as
begin
	
end

--Ví dụ: làm câu 5 của lab 3
Create procedure sp_Question5
as
begin
	--Tính amount của từng thằng orderid từ bảng orderitems
	with t as (select OrderID, SUM(Quantity * SellPrice) as Amount from OrderItems
			   group by OrderID)

	select * 
	into #Temp
	from t

	declare @id varchar(10)
	declare @amount float
	

	while (select COUNT(*) from #Temp) > 0
	begin 
		select top 1 @id = OrderID, @amount = Amount from #Temp
		update Orders
		set Amount = @amount
		where OrderID = @id
		delete from #Temp where OrderId = @id
	end
	print 'Update Success'
end
-- Thao tác Store
exec sp_Question5 
select * from Orders
select * from OrderItems

--Practice :
--1. Store1:
--Param
--Content: Hiển thị các hóa đơn mua trước ngày 02/06/2000
	create procedure sp_Store1
	as 
	begin 
		Select * from Orders
		where Date < '2000/06/02'
	end
	exec sp_Store1
	select * from Orders

--2.Store2:
--Param:SellDate
--Content: Trả về số lượng của những hóa đơn mua sau ngày param
	create procedure sp_Store2
	@SellDate date,
		@Count int output 
	as 
	begin 
		Select * from OrderItems os join Orders o
		on o.OrderID = os.OrderID 

		return @count
	end
	exec sp_Store2
	Select * from OrderItems
	Select * from Orders

--3.SP3:
--  Param: Name, gender
--  Content: Get tat ca Employee co Name va Gender
--           nhu tham so truyen vao

--4. SP4:
--  Param: Address
--  Content: Get ra nhung Employee co dia chi
--           la "Address" va da tung lap hoa don