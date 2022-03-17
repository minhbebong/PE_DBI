use master

create database ProductOrders 
use  ProductOrders
----------------------------------------------------------------------------
--Creat table Customers
Create table Customers(
	CustormerID nvarchar(5) not null primary key,
	Name nvarchar(30) not null check(Name <> ''),
	Address nvarchar(50), 
	Phone nvarchar(10),
	Email nvarchar(30)
)
--Insert data
	insert into Customers values('C01', 'NGUYEN THI BE', 'TAN BINH', '08457895', 'bnt@yahoo.com')
	insert into Customers values('C02', 'LE HOANG NAM', 'BINH CHANH', '09878987' ,'namlehoang @abc.com.vn')
	insert into Customers values('C03', 'TRAN THI CHIEU', 'TAN BINH','08457895','')
	insert into Customers values('C04', 'MAI THI QUE ANH', 'BINH CHANH','','')
	insert into Customers values('C05', 'LE VAN SANG', 'QUAN 10','' ,'sanglv@hcm.vnn.vn')
	insert into Customers values('C06', 'TRAN HOANG KHAI', 'TAN BINH', '08457897','')
----------------------------------------------------------------------------
--Creat table Products
Create table Products(
	ProductCode nvarchar(5) not null primary key check (ProductCode <> ''),
	Name nvarchar(30) not null check(Name <> ''), 
	Price float, 
	StockQuantity int
)
--Insert data
	insert into Products values ('P01', 'Paper A4 EPSON', 10, 5000)
	insert into Products values ('P02', 'Keyboard', 15, 480)
	insert into Products values ('P03', 'Mouse', 12, 800)
	insert into Products values ('P04', '17’’ LCD Monitor', 119, 800)
	insert into Products values ('P05', '21’’ LCD Monitor', 219, 100)
	insert into Products values ('P06', 'USB 8G', 45, 150)
	insert into Products values ('P07', 'USB 16G', 60, 500)

----------------------------------------------------------------------------
--Creat table Orders
Create table Orders(
	OrderID nvarchar(10) not null primary key check (OrderID <> ''),
	Date date, 
	CustomerID nvarchar(5) not null,
	Amount float,
	foreign key(CustomerID) references Customers(CustormerID)
)
--Insert data
	insert into Orders(OrderID, Date, CustomerID) values ('Or001', '2000/05/12','C01')
	insert into Orders(OrderID, Date, CustomerID) values ('Or002',	'2000/05/25','C02')
	insert into Orders(OrderID, Date, CustomerID) values ('Or003',	'2000/05/25','C01')
	insert into Orders(OrderID, Date, CustomerID) values ('Or004',	'2000/05/25','C04')
	insert into Orders(OrderID, Date, CustomerID) values ('Or005',	'2000/05/26','C04')
	insert into Orders(OrderID, Date, CustomerID) values ('Or006',	'2000/06/02','C03')
	insert into Orders(OrderID, Date, CustomerID) values ('Or007',	'2000/06/22','C04')
	insert into Orders(OrderID, Date, CustomerID) values ('Or008',	'2000/06/25','C03')
	insert into Orders(OrderID, Date, CustomerID) values ('Or009',	'2000/08/15','C04')
	insert into Orders(OrderID, Date, CustomerID) values ('Or010',	'2000/09/30','C01')
	insert into Orders(OrderID, Date, CustomerID) values ('Or011',	'2000/12/27','C06')
	insert into Orders(OrderID, Date, CustomerID) values ('Or012',	'2000/12/27','C01')
----------------------------------------------------------------------------
--Creat table OrderItems
Create table OrderItems(
	OrderID nvarchar(10) not null check (OrderID <> '') foreign key references Orders(OrderID), 
	ProductCode nvarchar(5) not null check (ProductCode <> '') foreign key references Products(ProductCode), 
	Quantity int, 
	Discount float, 
	SellPrice float check (SellPrice > 0), 
	primary key (OrderID, ProductCode),
)
--Insert data
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or001', 'P01', 5 , 12  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or001', 'P05', 10, 300 )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or002', 'P03', 4 , 13  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or003', 'P02', 20, 16  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or004', 'P03', 3 , 13  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or004', 'P04', 10, 120 )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or005', 'P05', 10, 309 )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or005', 'P06', 15, 46.6)
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or005', 'P07', 20, 70  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or006', 'P04', 10, 120 )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or007', 'P04', 20, 125 )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or008', 'P01', 2 , 11.5)
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or008', 'P02', 20, 16  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or009', 'P02', 25, 17  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or010', 'P01', 25, 11.5)
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or011', 'P01', 20, 12  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or011', 'P02', 20, 17  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or012', 'P01', 20, 12  )
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or012', 'P02', 10, 16.5)
	insert into OrderItems(OrderID, ProductCode, Quantity, SellPrice) values ('Or012', 'P03', 1 , 13.5)
----------------------------------------------------------------------------
-- Select all data in 4 tables
	Select * from Customers
	Select * from Products
	Select * from Orders
	Select * from OrderItems
--Delete all data in 4 tables 
	Delete Customers
	Delete Products
	Delete Orders
	Delete OrderItems
-----------------------------------------------------------------------------
--I. Simple SQL Queries
--In the database “ProductOrders” created in the previous exercise, write the following queries:

--01.	Find all Products in the database
	Select * from Products

--02.	Find the name and the phone number of all customers who live in ‘BINH CHANH’
	Select Name, Phone from Customers where Address = 'BINH CHANH'

--03.	Show the Name, Price, StockQuantity and Amount (which is equal to StockQuantity * Price) of all Products having Amount < 20000.
	Select Name, Price, StockQuantity, Amount = (StockQuantity * Price) from Products
	where (StockQuantity * Price > 2000)

--04.	Find all customers who lives in ‘BINH CHANH’ or ‘TAN BINH’
	Select * from Customers where Address = 'BINH CHANH' or Address = 'TAN BINH'

--05.	Find all Products having 10<= Price <= 45
	Select * from Products where Price >= 10 and Price <= 45

--06.	Find all customers who have a phone number.
	Select * from Customers where Phone != '' and Phone is not null

--07.	Find months and years in which customer ‘C01’ made at least an order.
	Select MONTH(Date) as 'Month', YEAR(Date) as'Year' from Orders where CustomerID = 'C01'

--08.	Find all customers whose name begin with ‘TRAN ‘.
	Select * from Customers where Name LIKE 'TRAN%'

--09.	Find all LCD monitor products.
	Select * from Products where Name LIKE '%LCD monitor'

--10.	Find the CustomerID of all customer who made orders in May 2000. 
-- Sử dụng DISRINCT để các kết quả không bị trùng nhau
	Select  DISTINCT CustomerID from Orders where MONTH(Date) = 5 and YEAR(Date) = 2000 
	Select * from Orders
--11.	List all Products by descending order of Price.
	Select * from Products 
	ORDER BY Price DESC
--12.	List all customer by descending order of Address, with customers having same address we order by ascending order of Name.
	Select * from Customers	ORDER BY Address DESC, Name ASC 
--13.	Find the product with the highest Price.
	Select * From Products
	Where Price = (Select MAX(Price) From Products);


--II. Queries involving more than one relations 
--In the database “ProductOrders” created in the previous exercise, write the following queries:

--1.	Find OrderID, Date, CustomerID, CustomerName, Address, Phone, Email of all orders.
		Select OrderID, Date, CustomerID, Name, Address, Phone, Email
		from Customers c
		JOIN Orders o on c.CustormerID = o.CustomerID

--2.	List all orders of all customers including CustomerID, CustomerName, OrderID, Date. 
--		Order the result by descending order of CustomerName (Note that we need to know also the customer who have no order). 
--		Try to use left outer join for this question.
		Select CustomerID, Name, OrderID, Date from Customers c LEFT JOIN Orders o
		on c.CustormerID = o.CustomerID
		order by [Name] desc

--3.	Same as Question 2 but using right outer join for this exercise.
		Select CustomerID, Name, OrderID, Date from Orders o Right JOIN Customers c
		on c.CustormerID = o.CustomerID
		order by [Name] desc

--4.	List CustomerID of all customers who have never bought any product.
		select CustormerID from Customers c
		where c.CustormerID not in (select CustomerID from Orders) 
																	
--5.	Do the intersect between the list of 
--		CutomerID from Customers and the list of CustomerID from Orders? 
--		How many rows in the output?
		--Cách 1: 
		Select count (distinct CustomerID) from Customers c JOIN Orders o
		on c.CustormerID = o.CustomerID
		--Cách 2: 
		with a as 
			(SELECT CustormerID FROM Customers
			 intersect
			 SELECT CustomerID FROM Orders)
		SELECT COUNT(*) FROM a
use ProductOrders
--6-.	Do the union between the list of 
--		CutomerID from Customers and the list of CustomerID from Orders? 
--      How many rows in the output?
		with c6 as 
			(SELECT CustormerID FROM Customers
			 UNION 
			 SELECT CustomerID FROM Orders)
		SELECT COUNT(*) FROM c6
use ProductOrders		
--7.	Do the union all between the list of CutomerID from Customers and the list of CustomerID from Orders? 
--      How many rows in the output?
		With c7 as 
			(Select CustormerID from Customers
			 UNION ALL
			 Select CustomerID from Orders)
		Select COUNT(*) From c7

--8.	List all orders of ‘NGUYEN THI BE’ and ‘LE VAN SANG’, 
--		including CustomerID, CustomerName, OrderID, Date; ordered by CustomerName.
		-- Cách 1: 
		Select c.CustormerID, c.Name, o.OrderID, o.Date from Customers c JOIN Orders o 
		on c.CustormerID = o.CustomerID 
		where c.Name = 'NGUYEN THI BE' OR c.Name = 'LE VAN SANG'
		ORDER BY c.Name
		-- Cách 2: 
		Select c.CustormerID, c.Name, o.OrderID, o.Date from Customers c JOIN Orders o
		on c.CustormerID = o.CustomerID
		where c.Name like 'NGUYEN THI BE' or  c.Name like 'LE VAN SANG'

--9.	List OrderID, ProductCode, ProductName, Price, SellPrice, SoldQuantity, 
--      Profit ((SellPrice - Price)*SoldQuantity) by ascending order of OrderID.-
		Select oi.OrderID, oi.ProductCode, p.Name, p.Price, oi.SellPrice, 
		oi.Quantity, ((oi.SellPrice - p.Price)*oi.Quantity) as 'Profit' 
		from OrderItems oi JOIN Products p
		on oi.ProductCode = p.ProductCode
		ORDER BY OrderID 
		

--10.	List CustomerID, CustomerName, OrderID, ProductCode, ProductName, Price,
--		SellPrice, SoldQuantity, Profit ((SellPrice - Price)*SoldQuantity) 
--		by ascending order of CustomerName.
		Select cu.CustormerID, cu.Name, oi.OrderID, oi.ProductCode, p.Name, p.Price, oi.SellPrice, 
		oi.Quantity, ((oi.SellPrice - p.Price)*oi.Quantity) as 'Profit'
		from Products p
		JOIN OrderItems oi on p.ProductCode = oi.ProductCode
		JOIN Orders     o  on o.OrderID = oi.OrderID
		JOIN Customers  cu on cu.CustormerID = o.CustomerID
		

--11.	List 5 OrderItems having the highest profit (profit = (SellPrice - Price)*SoldQuantity).
		Select top 5 oi.* from OrderItems oi JOIN Products p
		on oi.ProductCode = p.ProductCode
		ORDER BY ((oi.SellPrice - p.Price)*oi.Quantity) desc 

--12.	List all products (ProductCode, ProductName) 
--		bought by both ‘NGUYEN THI BE’ and ‘MAI THI QUE ANH’.
		select distinct p.ProductCode, p.Name from Customers as c
		join Orders as o on c.CustormerID = o.CustomerID
		join OrderItems as oi on o.OrderID = oi.OrderID
		join Products as p on p.ProductCode= oi.ProductCode
		where (c.Name != 'NGUYEN THI BE' and c.Name = 'MAI THI QUE ANH')
		Intersect
		select distinct p.ProductCode, p.Name from Customers as c
		join Orders as o on c.CustormerID = o.CustomerID
		join OrderItems as oi on o.OrderID = oi.OrderID
		join Products as p on p.ProductCode= oi.ProductCode
		where (c.Name = 'NGUYEN THI BE' and c.Name != 'MAI THI QUE ANH')
--13.	List all products with highest price (Note that there could have many products with the highest price).
--		You should not use the aggregate function max().
		select * from Products
		where price = (select top 1 price from Products order by price DESC)

