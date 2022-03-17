
--1.	Stored procedure for showing the details of all customers.

		CREATE PROC SP_ShowAllCustomers
		AS
		BEGIN 
			SELECT * FROM Customers
		END

		EXECUTE SP_ShowAllCustomers

--2.	Stored procedure for showing the details of all customers 
--		by using “with encryption” option

		CREATE PROC SP_WithEncryption
		(
			@CustormerID nvarchar(5)
		)
		WITH ENCRYPTION
		AS 
		BEGIN 
			SELECT * FROM Customers
			WHERE CustormerID = @CustormerID
		END

		EXECUTE SP_WithEncryption @CustormerID = 'C01'
		EXECUTE SP_WithEncryption @CustormerID = 'C02'
		EXECUTE SP_WithEncryption @CustormerID = 'C03'
		EXECUTE SP_WithEncryption @CustormerID = 'C04'
		EXECUTE SP_WithEncryption @CustormerID = 'C05'
		EXECUTE SP_WithEncryption @CustormerID = 'C06'

--3.	Stored procedure for showing the list of orders
--      of a given customer where CustomerID is an input parameter of the procedure.

		CREATE PROC SP_ListOrdersByInput
		(
			@Parameter nvarchar(10) = 'C01' -- Có thể thay thế parameter
		)
		AS 
		BEGIN
			SELECT * FROM Customers c RIGHT JOIN Orders o ON c.CustormerID = o.CustomerID
			WHERE O.CustomerID = @Parameter
		END

		EXECUTE SP_ListOrdersByInput

--4.	Stored procedure for calculating the number of orders of a given customer where 
--		CustomerID is an input parameter of the procedure and NumberOfOrder is the output
--		parameter of the procedure.

		CREATE PROC SP_CalTheNumberOrderInputOutPut
		(
			@CustomerID nvarchar(10),
			@NumberOfOrder int output
		)
		AS
		BEGIN
			SET @NumberOfOrder = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID)
			RETURN @NumberOfOrder
		END

		DECLARE @n INT
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C01', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C02', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C03', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C04', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C05', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C06', @NumberOfOrder = @n output
		PRINT @n

--5.	Write an example using TRY...CATCH for handling errors.
		
		CREATE PROC SP_UsingTryCatch
		AS 
		BEGIN TRY
			select 1 /0 as Error
		END TRY

		BEGIN CATCH
		select
			ERROR_LINE() AS ErrorLine;
		END CATCH

		exec SP_UsingTryCatch

--6.	Write an example using stored procedure in a query using OPENQUERY

--  OPENQUERY (linked_server ,'query')  

/*
7.	Stored procedure having CustomerID as an input parameter:
a.	Display the list (OrderID, OrderDate, ProductCode, ProductName, 
	Quantity, SellPrice) of a given customer.
b.	Calculate the total amount of all orders of the given customer 
	and return as an output parameter.
c.	Calculate the number of orders of the given customer and return
	as an output parameter.
*/
	CREATE PROC SP_CustomerID
	(
		@CustomerID nvarchar(max),
		@totalamount float output,
		@count int output
	)
	AS
	BEGIN
		WITH A AS(SELECT o.OrderID, o.Date, p.ProductCode, p.Name, oi.Quantity, oi.SellPrice 
					FROM Orders o LEFT JOIN OrderItems oi 
					on o.OrderID = oi.OrderID
					LEFT JOIN Products p 
					on oi.ProductCode = p.ProductCode)
		SELECT * INTO #TEMP FROM A
		SET @totalamount = (SELECT SUM(Quantity*SellPrice) FROM #TEMP)
		SET @count = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @customerid)
		SELECT * FROM #Temp
	END 

	DECLARE @t float, @c int
	EXECUTE SP_CustomerID 'C01', @totalamount = @t output, @count = @c output
	PRINT @t
	PRINT @c

--8.	Function for calculating the total amount of an order, where orderID 
--		is an input parameter of the function and TotalAmount is the returning
--		value of the function.
	CREATE FUNCTION [dbo].[fu_amount]  -- CREATE FUNCTION
	(@id varchar(10))	-- input parameter
	RETURNS int -- return giá trị int
	AS
	BEGIN
		DECLARE @amount int -- khai báo biến @amount
		SET @amount = (SELECT SUM(i.Quantity*i.SellPrice) FROM Orders o
		join OrderItems i on i.OrderID = o.OrderID
		WHERE o.CustomerID = @id)
		RETURN @amount
	END

	select [dbo].[fu_amount]('C01')

--9.	Function returning the list (ProductCode, ProducttName, TotalQuantity) 
--		of all products that a customer bought, where CustomerID is the input 
--		parameter of the function.

	CREATE FUNCTION [dbo].[fu_return] -- Tạo function
	(@CustomerID nvarchar(max)) -- input parameter
	RETURNS TABLE -- return table
	AS
	RETURN
	(
		SELECT p.ProductCode,p.Name, SUM(oi.Quantity) as 'TotalQuantity' FROM Products p LEFT JOIN OrderItems oi
		on p.ProductCode = oi.ProductCode 
		LEFT JOIN Orders o
		on oi.OrderID = o.OrderID
		WHERE o.CustomerID = @CustomerID
		GROUP BY p.ProductCode, p.Name
	);

	select * from [dbo].[fu_return] ('C01') -- input ở trong ngoặc mới hợp lệ
