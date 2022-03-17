--Select tức là lấy dữ liệu mà chúng ta mong muốn 
--cú pháp tổng quát: 
-- SELECT [danh sách muốn hiển thị]
-- FORM	[tên bảng]
-- WHERE [điều kiện lọc]
-- ORDER BY [cột muốn order] ASC|DESC
-- GROUP BY[những cột muốn group]
-- HAVING [điều kiện]

-- Lấy ra thông tin của bảng Products

select * from Products

-- Lấy ra mã, tên, giá, số lượng trong kho của tất cả sản phẩm

	select 
		ProductID, 
		ProductName, 
		UnitPrice, 
		UnitsInStock 
	from Products

--	Lấy ra mã, tên, giá, số lượng trong kho của tất cả sản phẩm đổi tên thành tiếng Việt
	select 
		ProductID as 'Mã Sản Phẩm', 
		ProductName 'Tên Sản Phẩm', 
		UnitPrice 'Giá', 
		UnitsInStock 'Số Lượng'
	from Products
-- những câu lệnh  trên là câu lệnh Rename

-----------------------------------------------------------
-- Hiển thị 10 sản phẩm đầu tiên
	select top 10 * from Products

--Hiển thị thông tin và thành tiền của từng order detail

	select *, UnitPrice*Quantity as 'Amount' from [Order Details]

--Hiển thị thông tin và thành tiền của từng order detail nhưng giá > 20
	
	select *, UnitPrice*Quantity as 'Amount' from [Order Details]
	where UnitPrice > 20

-- Lấy ra tất cả orderID của bảng Order Detail
-- SELECT DISTINCT chỉ chọn 1 cái làm sao để bảng select không bị trùng
	
	select distinct OrderID from [Order Details]

-- Có bao nhiêu sản phẩm trong bảng Products

	select Count(*) from Products
--Tương tự hàm Count thì có các hàm sau đây
-- Max, Min, Sum, Avg(TRUNG BÌNH CỘNG)
--Pracrtice:
--1.Có bao nhiêu sản phẩm trong kho (SUM)
--2.Giá bán cao nhất của tất cả sản phẩm (MAX)
--3.Thành tiền thấp nhất của tất cả order detail (MIN)
--4.Trung bình giá bán của tất cả các sản phẩm đã bán (AVG)
	select * from Products
	select * from [Order Details]
	select SUM(UnitsInStock) as'SUM UnitsInStock'  from Products
	select MAX(UnitPrice) as'MAX UnitPrice' from Products
	select MIN(UnitPrice*Quantity) as 'MIN Amount' from [Order Details]
	select AVG(UnitPrice*Quantity) as 'AVERAGE Amount' from [Order Details]

--5.Hiển thị những nhân viên có ngày sinh trước ngày 1/1/1950
	select * from Employees 
	where BirthDate < '1/1/1950'
--6.Hiển thị những hóa đơn đặt sau ngày 1/10/1996
	select * from Orders 
	where OrderDate > '10/1/1996'
--7.Hiển thị những nhân viên có tên là Andrew
	select * from Employees 
	where FirstName = 'Andrew'


--MỆNH ĐỀ WHERE
--Nếu có từ 2 điều kiện trở lên, sử dụng: and, or
-- Toán tử so sánh: ...
-- Ví dụ 1: Hiển thị những mặt hàng có giá trị thuộc (50, 100]
	select * from Products
	where UnitPrice > 50 and UnitPrice <= 100

-- Toán tử Between number1, number2
	select * from Products
	where UnitPrice between 51 and 100

-- Từ khóa Like, Not Like
-- Ví dụ 1: Hiển thị các nhân viên có first name là Nancy
	Select * from Employees
	where FirstName  = 'Nancy'

	Select * from Employees
	where FirstName LIKE 'Nancy'
-- Ví dụ 2: Hiển thị những nhân viên có họ bắt đầu bằng chữ 'D'
	Select * from Employees
	where LastName like 'D%'
-- Ví dụ 3: Hiển thị những nhân viên có tên kết thúc là 'n'
	Select * from Employees
	where FirstName like '%n'
-- Ví dụ 4: Hiển thị những nhân viên mà ký tư thứ 2 của họ là 'u'
	Select * from Employees
	where LastName like '_u%'
-- Ví dụ 5: Hiển thị những nhân viên có tên chứa 2 kí tự 'a' mà giữa 2 kí tự này
-- mà giữa 2 kí tự này có 1 kí tự m hoặc n
-- Cách 1:
	Select * from Employees
	where LastName like '%ama%' or LastName like '%ana%'
-- Cách 2: 
	Select * from Employees
	where LastName like '%a[mn]a%'	
-- Từ khóa IN/NOT IN
-- Ví dụ 1: Hiển thị ra những nhân viên sinh vào tháng 1, 5, 8, 9
--Cách 1: 	
	Select * from Employees
	where MONTH(BirthDate) = 1
	or    MONTH(BirthDate) = 5
	or    MONTH(BirthDate) = 8
	or    MONTH(BirthDate) = 9
--Cách 2: 
	Select *from Employees
	where MONTH(BirthDate) IN (1,5,8,9)

-- Ví dụ 2: Hiển thị ra những nhân viên không sinh vào ngày 1, 5, 12, 19, 21, 23
	Select *from Employees
	where DAY(BirthDate) NOT IN (1, 5, 12, 19, 21, 23)

-- Ví dụ 3: Những nhan viên đã bán hàng trước ngày 1996/07/10
-- Cách 1:
	Select *from Employees
	where EmployeeID  IN (Select EmployeeID from Orders where OrderDate < '1996/07/10')

-- Cách 2: Sử dụng JOIN 

-- Cách 2.1: Từ khóa JOIN
	Select distinct e.* from Orders o
	JOIN Employees e on o.EmployeeID = e.EmployeeID
	where o.OrderDate < '1996/07/10'
	ORDER BY LastName DESC

-- Cách 2.2: Không dùng từ khóa JOIN
	Select distinct e.* from Orders o, Employees e
	where o.EmployeeID = e.EmployeeID
	and o.OrderDate < '1996/07/10'
	ORDER BY LastName DESC

-- UNION - PHÉP HỢP 
--Ví dụ 1: Hiển thị 3 sản phẩm có giá cao nhất
	Select top 3 * from Products 
	ORDER BY UnitPrice desc

-- Ví dụ 3: Hiển thị 3 sản phẩm có giá trị thấp nhất và 3 giá trị cao nhất 
-- theo thứ tự từ thấp đến cao 

	WITH B as (Select top 3 * from Products ORDER BY UnitPrice desc ),
	T as (Select top 3 * from Products ORDER BY UnitPrice)
	SELECT * FROM B UNION SELECT * FROM T
	ORDER BY UnitPrice 

-- Các hàm hay dùng: Month, Year, Day, Len, GetDate(), Max, Min, SUM, COUNT
--Practise : 
--1. Tìm những khách hàng đến từ Đức 
	Select * from Customers
	where Country LIKE 'Germany'
--2.Tìm những khách hàng đã order Hàng 
	Select distinct* from Orders
--3. Hiển thị những hóa đơn Order vào tháng lẻ
	Select distinct* from Orders
	where MONTH(OrderDate) IN (1, 3, 5, 7, 9, 11)
	ORDER BY (OrderDate) 
--4. Có bao nhiêu khách hàng order vào ngày chẵn
	--Cách 1:
	Select COUNT(*) from Orders o
	JOIN Customers c on o.CustomerID = c.CustomerID
	where DAY(o.OrderDate) in (2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30)
	--Cách 2: 
	Select Count(*) from Orders o
	JOIN Customers c on o.CustomerID = c.CustomerID
	where Day(o.OrderDate) % 2 = 0

--5. Số lượng sản phẩm có giá nằm trong khoảng [50, 100)
--6. Sản phẩm nào có giá cao nhất
--7. Sản phẩm có số lượng trong kho thấp nhất 
--8. Tính tuổi trung bình của những nhân viên có tên bắt đầu 'M'
--9. Nhân viên nào nhiều tuổi nhất
--10. Có bao nhiêu nhân viên trẻ tuổi nhất 


--GROUP BY && HAVING: Dùng để thống kê thông tin theo từng group 
-- thưởng đi với các hàm cout, min, mã, sum, avg
--Gom nhóm nhân viên theo từng country

	Select Country from Employees
	group by Country

--Gom nhóm nhân viên theo cách xưng hô 
	Select TitleOfCourtesy from Employees
	group by TitleOfCourtesy

-- Tìm xem số lượng nhân viên ở mỗi country
	Select Country, COUNT(*) from Employees
	group by Country

--Tìm số lượng nhân viên của mỗi nhóm xưng hô
	Select TitleOfCourtesy, count(*)from Employees
	group by TitleOfCourtesy

--Hiển thị country và số lượng nhân viên của từng country mà có số lượng > 4

--Cách 1: 
	Select Country, COUNT(*) from Employees
	where COUNT(*) > 4 -- KHÔNG SỬ DỤNG KẾT QUẢ THÔNG KÊ CỦA GROUP LÀM ĐIỀU KIỆN WHERE
	group by Country
--Cách 2: 
	Select Country, COUNT(*) from Employees
	group by Country
	having COUNT(*) > 4 -- ĐƯỢC SỬ DỤNG COUNT(*) TRONG MỆNH ĐỀ

--Hiển thị cách xưng hô MR or MRS và số lượng nhân viên tương ứng
	--Cách 1: DÙNG WHERE
	Select TitleOfCourtesy, count(*)from Employees
	where TitleOfCourtesy in ('Mr.', 'Mrs.')
	group by TitleOfCourtesy
	--Cách 2: 
	Select TitleOfCourtesy, count(*)from Employees
	group by TitleOfCourtesy
	having TitleOfCourtesy in ('Mr.', 'Mrs.')

--Hiển thị cách xưng hô và số lượng của từng nhóm xưng hô của những nhân ở USA
	--Cách 1:
	Select TitleOfCourtesy, count(*)from Employees
	where Country in ('USA')
	group by TitleOfCourtesy
	-- Cách 2: 
	Select TitleOfCourtesy, count(*)from Employees
	group by TitleOfCourtesy
	having Country in ('USA')

--PRACTICE: 
--1: Hiển thị tên thành phố và số lượng Customer của từng thành phố đó 
--   với điều kiện là số lượng customer > 5
	Select City, COUNT(*)   from Customers
	group by City
	having  COUNT(*) > 5
--2: Hiển thị tên country và số lượng customer của country đó
	Select Country, COUNT(*)   from Customers
	group by Country
	order by COUNT(*) 

--3: Hiển thị orderid và tổng sản phẩm bán được trong mỗi order đó
	Select OrderID, SUM(Quantity) from [Order Details]
	group by OrderID 
--4: Hiển thị orderid và tổng thành tiền của mỗi order đó
	Select OrderID, SUM(Quantity*UnitPrice) from [Order Details]
	group by OrderID 
	
--5: Hiển thị productcode, productname và số lượng đã bán của sản phẩm tương ứng
	Select p.ProductID, p.ProductName, SUM(od.Quantity) from Products p
	left join [Order Details] od on p.ProductID = od.ProductID
	group by p.ProductName, p.ProductID

