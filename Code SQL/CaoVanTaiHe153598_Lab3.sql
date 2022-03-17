create database ProductOrdersDemo
drop database ProductOrders

use ProductOrdersDemo

--Tạo và thao tác các bảng
delete from Customers
drop table Customers

create table Customers (
	CustomerID nvarchar(5) not null primary key,
	Name nvarchar(30) not null, 
	Address nvarchar(50), 
	Phone nvarchar(10), 
	Email nvarchar(30)
)
-- add constraint not null for Phone
alter table Customers
alter column Phone nvarchar(10) not null;
ALTER TABLE Customers
ADD  CONSTRAINT Phone_notempty check(Phone <> '')

--update phone cho cus dang co sdt empty
update Customers set Phone ='0234656789'
where Phone = '' or Phone = null
-- xoa cau truc bang
drop table Customers

-- Nhập dữ liệu cho bảng Customers
insert into Customers values('C01', 'NGUYEN THI BE', 'TAN BINH', '08457895', 'bnt@yahoo.com')
insert into Customers values('C02', 'LE HOANG NAM', 'BINH CHANH', '09878987' ,'namlehoang @abc.com.vn')
insert into Customers values('C03', 'TRAN THI CHIEU', 'TAN BINH','08457895','')
insert into Customers values('C04', 'MAI THI QUE ANH', 'BINH CHANH','','')
insert into Customers values('C05', 'LE VAN SANG', 'QUAN 10','' ,'sanglv@hcm.vnn.vn')
insert into Customers values('C06', 'TRAN HOANG KHAI', 'TAN BINH', '08457897',''	)

create table Products(
	ProductCode nvarchar(5) not null primary key,
	Name nvarchar(30) not null, 
	Price float check(Price > 0),
	StockQuantity int check(StockQuantity >= 0)
)
delete from Products 

-- Nhập dữ liệu cho bảng Products
insert into Products values ('P01', 'Paper A4 EPSON', 10, 5000)
insert into Products values ('P02', 'Keyboard', 15, 480)
insert into Products values ('P03', 'Mouse', 12, 800)
insert into Products values ('P04', '17’’ LCD Monitor', 119, 800)
insert into Products values ('P05', '21’’ LCD Monitor', 219, 100)
insert into Products values ('P06', 'USB 8G', 45, 150)
insert into Products values ('P07', 'USB 16G', 60, 500)


create table Orders(
	OrderID nvarchar(10) not null primary key, 
	Date date check(Date < getDate()), 
	CustomerID nvarchar(5),
	Amount float,
	foreign key(CustomerID) references Customers(CustomerID)
)
Alter table Orders 
drop column Amount

delete from Orders
-- Nhập dữ liệu cho bảng Orders
insert into Orders values ('Or001', '2000/05/12',   'C01', 0)
insert into Orders values ('Or002',	'2000/05/25',	'C02', null )
insert into Orders values ('Or003',	'2000/05/25',	'C01', null )
insert into Orders values ('Or004',	'2000/05/25',	'C04', null )
insert into Orders values ('Or005',	'2000/05/26',	'C04', null )
insert into Orders values ('Or006',	'2000/06/02',	'C03', null )
insert into Orders values ('Or007',	'2000/06/22',	'C04', null )
insert into Orders values ('Or008',	'2000/06/25',	'C03', null )
insert into Orders values ('Or009',	'2000/08/15',	'C04', null )
insert into Orders values ('Or010',	'2000/09/30',	'C01', null )
insert into Orders values ('Or011',	'2000/12/27',	'C06', null )
insert into Orders values ('Or012',	'2000/12/27',	'C01', null )


create table OrderItems(
	OrderID nvarchar(10),
	ProductCode nvarchar(5),
	Quantity int check (Quantity > 0), 
	Discount float, 
	SellPrice float,
	foreign key(OrderID) references Orders(OrderID),
	foreign key(ProductCode) references Products(ProductCode)
	primary key ( OrderID, ProductCode)
)

--add constraint sellpirce not null and not empty
alter table OrderItems 
add constraint Check_SellPrice check (SellPrice is not null and SellPrice <> '')

insert into OrderItems values ('Or001', 'P02', 5, null, null)
delete from OrderItems
-- Nhập dữ liệu cho bảng OrderItems
insert into OrderItems values ('Or001', 'P01', 5, null, 12)
insert into OrderItems values ('Or001', 'P05', 10, null,300)
insert into OrderItems values ('Or002', 'P03', 4, null, 13)
insert into OrderItems values ('Or003', 'P02', 20, null, 16)
insert into OrderItems values ('Or004', 'P03', 3, null, 13)
insert into OrderItems values ('Or004', 'P04', 10, null, 120)
insert into OrderItems values ('Or005', 'P05', 10, null, 309)
insert into OrderItems values ('Or005', 'P06', 15, null, 46.6)
insert into OrderItems values ('Or005', 'P07', 20, null, 70)
insert into OrderItems values ('Or006', 'P04', 10, null, 120)
insert into OrderItems values ('Or007', 'P04', 20, null, 125)
insert into OrderItems values ('Or008', 'P01', 2, null, 11.5)
insert into OrderItems values ('Or008', 'P02', 20, null, 16)
insert into OrderItems values ('Or009', 'P02', 25, null, 17)
insert into OrderItems values ('Or010', 'P01', 25, null, 11.5)
insert into OrderItems values ('Or011', 'P01', 20, null, 12)
insert into OrderItems values ('Or011', 'P02', 20, null, 17)
insert into OrderItems values ('Or012', 'P01', 20, null, 12)
insert into OrderItems values ('Or012', 'P02', 10, null, 16.5)
insert into OrderItems values ('Or012', 'P03', 1, null, 13.5)
insert into OrderItems values ('Or007', 'P05', 20, null, 125)
--------------------------------------------------------------
----------------------------------------------------

select * from Customers
select * from Products
select * from Orders
select * from OrderItems
select * from Discount

----------------------------------------------------
----------------------------------------------------
--Modifications in SQL
--1.Insert a new Product(‘P08’, ‘Pen’, 0.25, 2000) 
--where 0.25 is the Price and 2000 is the StockAmount of the product

Insert into Products
values ('P08', 'Pen', 0.25, 2000)

select * from Products

--2.Create a table CustomerProducts && insert data
drop table CustomerProducts
delete from CustomerProducts
create table CustomerProducts(
	CustomerID nvarchar(5) not null primary key foreign key references Customers(CustomerID),
	CustomerName nvarchar(30),	
	ProductCode nvarchar(5) not null foreign key references Products(ProductCode), 
	ProductName nvarchar(30), 
	TotalQuantity int, 
	TotalAmount float,
)

-- insert data
insert into CustomerProducts
values ('C01', 'NGUYEN THI BE', 'P01', 'Laptop', 70, 0)
insert into CustomerProducts
values ('C02', 'LE HOANG NAM', 'P02', 'Mobile', 1000, 20)
insert into CustomerProducts
values ('C03', 'TRAN THI CHIEU', 'P03', 'TV', 30, 0)
insert into CustomerProducts
values ('C04', 'NGUYEN THI BE', 'P04', 'Fan', 700, 10)

select * from CustomerProducts

--3. Update email of NGUYEN THI BE to nguyenthibe@yahoo.com
--Câu lệnh mẫu
--update Supplier set SupplierName = 'Panasonic', Address = 'Japan'
--where SupplierCode = 'S03'

update Customers set Email = 'nguyenthibe@yahoo.com'
where Name = 'NGUYEN THI BE'

select * from Customers

update OrderItems set Discount = null
--4.Update Discount of OrderItems so that 
--(create the table Discount for storing the corresponding information 
--and use this table in the update statement). 

select * into Discount from OrderItems

--if 0<= Quantity < 5 then Discount = 0,
update Discount set Discount = 0
where (Quantity >= 0) and ( Quantity < 5)

--if 5<= Quantity < 10 then Discount = 0.05, 
update Discount set Discount = 0.05
where (Quantity >= 5) and ( Quantity < 10) 

--if 10<= Quantity < 20 then Discount = 0.1 and
update Discount set Discount = 0.1
where (Quantity >= 10) and ( Quantity < 20)
--if 20<= Quantity < 900000 then Discount = 0.15 
update Discount set Discount = 0.15
where (Quantity >= 20) and ( Quantity < 900000) 

 


select * from OrderItems
select * from Discount

--5.Update the Amount of each order as the total amount of all products 
--sold in the corresponding order.
--The Amount of each product in each order is calculated as
--(1-Discount)*SellPrice*Quantity.


--6.Delete rows corresponding to customers ‘NGUYEN THI BE’ from table CustomerProducts.
-- Xóa dữ liệu trong 1 bảng 

delete from CustomerProducts
where CustomerName = 'NGUYEN THI BE'

select * from CustomerProducts

--7.Delete order ‘Or012’ from the table Orders.
Delete from OrderItems 
where OrderID = 'Or012'
delete from Orders 
where OrderID = 'Or012'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
select * from OrderItems
select * from Orders
