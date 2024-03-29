﻿--Save as with name: Script_SE1613_CreateDB
--Câu lệnh sử dụng một DB nào đó
use master 

-- Create database
create database SaleDB1

-- Delete database
drop database SaleDB1

use SaleDB1 

-- các thao tác liên quan đến Database SaleDB1
-- 1. Tạo table
-- Tạo table Supplier
create table Supplier(
	SupplierCode varchar(10) not null primary key, 
	SupplierName varchar(30) not null,
-- Vì address trùng từ khóa của SQL nên mình dùng thêm 1 dấu ngoặc vuông 
	[Address] varchar(max)
)
-- Không cho phép insert null SupplierCode
insert into Supplier (SupplierCode, SupplierName, [Address])
values ('S01','Samsung' ,'Korea')
insert into Supplier 
values ('S02','LG' ,'Korea')
insert into Supplier 
values ('S03','Panasonic' ,'Japan')
insert into Supplier 
values ('S04','Apple' ,'England')
insert into Supplier 
values ('S05','Dell' ,'America')
insert into Supplier 
values ('S06','Asus' ,'ThaiLand')
insert into Supplier 
values ('S07','Lenovo' ,'France')
insert into Supplier 
values ('S08','HP' ,'Brazil')
insert into Supplier 
values ('S09','ThinkPad' ,'Colombia')
insert into Supplier 
values ('S10','XGame' ,'China')
-- ở SupplierCode là empty chứ không phải null
-- Phân biệt giữa empty và null
-- null: không tồn tại 
-- empty: tồn tại nhưng không có giá trị 
insert into Supplier 
values (null,'LG' ,'') -- Không cho phép insert null SupplierCode

-- Xóa dữ liệu trong 1 bảng 
--Xóa supplier mà code = ''
delete from Supplier

--Update dữ liệu = xóa + insert
-- Cách 1: xóa xong insert lại 
-- Cách 2: update 

update Supplier set SupplierName = 'Panasonic', Address = 'Japan'
where SupplierCode = 'S03'

-- Add thêm constrain vào 1 bảng đã tạo
-- Thêm consstrain để k có  SupplierName nào bị trùng lặp
alter table Supplier  -- sửa cấu trúc của bảng Supplier
add constraint unique_name unique(SupplierName)


--Xóa cấu trúc bảng 
drop table Product

-- Các thao tác tạo bảng Product
create table Product (
	ProductCode varchar (10) not null,
	Name  nvarchar(30) not null, --nvarchar là tên tiếng việt
	PurchasePrice real not null,
	SellPrice real not null,
	Type varchar(10) not null, 
	SupplierCode varchar(10) not null,
	primary key(ProductCode), --khóa chính của bảng ProductCode 
	foreign key(SupplierCode) references Supplier(SupplierCode)	--
)

-- Giả sử ở phần create Product chưa tạo primary key thì sẽ làm như sau:
alter table Product 
add constraint PrimaryKey_ProductCode primary key(ProductCode)

--Giả sử ở phần create Product chưa tạo foreign key thì:
alter table Product 
add constraint ForeignKey_SupplierCode foreign key(SupplierCode)
references Supplier(SupplierCode)
-- insert dữ liệu cho bảng Product
insert into Product values('P01', 'Laptop Samsung', 100, 190,'Laptop', 'S01')
insert into Product values('P02', 'Laptop Dell', 100, 190,'Laptop1', 'S02')
insert into Product values('P03', 'Laptop HP', 100, 190,'Laptop2', 'S03')
insert into Product values('P04', 'Laptop ThinkPad', 100, 190,'Laptop3', 'S04')
insert into Product values('P05', 'Laptop Lenovo', 100, 190,'Laptop4', 'S05')
insert into Product values('P06', 'Laptop LG', 100, 190,'Laptop5', 'S06')
insert into Product values('P07', 'Laptop DMX', 100, 190,'Laptop6', 'S07')
insert into Product values('P08', 'Laptop Dell', 100, 190,'Laptop7', 'S08')
insert into Product values('P09', 'Laptop Apple', 100, 190,'Laptop8', 'S09')
insert into Product values('P10', 'Laptop USA', 100, 190,'Laptop9', 'S10')

-- Add thêm constrain Purchase  <= Sell
alter table Product -- câu lệnh dùng để sửa trong bảng Product
add constraint check_SellPrice check(PurchasePrice <= SellPrice) -- add thêm constraint để bảng đúng điều kiện Purchase <= Sell

delete from Product
select * from Product
select * from Supplier -- xem xem trong bảng đã có dữ liệu chưa 


--Các thao tác tạo và insert dữ liệu cho Employee
create table Employee (
	EmployeeID varchar (10) not null primary key,
	FullName nvarchar(25) not null, 
	Gender varchar(6) not null check(Gender = 'Male' or Gender ='Female'),
	--gender chỉ được nhập male or female
	BirthDate smalldatetime not null check (Birthdate < getdate()), 
	-- getdate là hàm trả về ngày hiện tại 
	Address varchar (max)
)
insert into Employee 
values ('E1','Cao Văn Tài' ,'Male', 02/02/2001, 'Nghe An')
insert into Employee 
values ('E2','Cao Văn Tú' ,'Male', 06/06/1976, 'Nghe An')
insert into Employee 
values ('E3','Cao Văn Tình' ,'Male', 05/05/2007, 'Nghe An')
insert into Employee 
values ('E4','Cao Văn Lâm' ,'Male', 05/05/1994, 'Nghe An')
insert into Employee 
values ('E5','Cao Xuân Hoan' ,'Male', 08/08/1992, 'Nghe An')
insert into Employee 
values ('E6','Cao Xuân Hùng' ,'Male', 02/01/1956, 'Nghe An')
insert into Employee 
values ('E7','Cao Thị Thanh Loan' ,'Female', 02/02/1989, 'Nghe An')
insert into Employee 
values ('E8','Cao Thị Xuân' ,'Female', 08/08/1950, 'Nghe An')
insert into Employee 
values ('E9','Cao Nguyễn Đăng Khôi' ,'Male', 02/02/2017, 'Nghe An')
insert into Employee 
values ('E10','Cao Nguyễn Ngọc Hân' ,'Female', 08/08/2021, 'Nghệ An')

select * from Employee
select * from Product
select * from Supplier 
--Practice
-- Bổ sung để 3 cái bảng đã tạo sẽ có ít nhất là 10 dòng dữ liệu