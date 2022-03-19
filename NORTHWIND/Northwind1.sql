--1
SELECT LOWER(e.FirstName + ' '+ e.LastName) AS [Full Name], e.TitleOfCourtesy
FROM dbo.Employees e

--2
SELECT UPPER(e.FirstName+' '+e.LastName) AS [Full name]
FROM dbo.Employees e

--3 
SELECT e.EmployeeID, e.LastName, e.FirstName, e.Title, e.City, e.Country
FROM dbo.Employees e
WHERE e.Country ='USA'

--4
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle, c.Country
FROM dbo.Customers c
WHERE c.Country ='UK'

--5
SELECT c.CustomerID, c.CompanyName, c.Address, c.City, c.Country
FROM dbo.Customers c
WHERE Country='Mexico'

--6
SELECT c.CustomerID, c.CompanyName, c.Phone, c.Address, c.City, c.Country
FROM dbo.Customers c
WHERE Country='Sweden'

--7
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock
FROM dbo.Products p
WHERE p.UnitsInStock BETWEEN 5 AND 10

--8
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.ReorderLevel, p.UnitsOnOrder
FROM dbo.Products p
WHERE p.UnitsOnOrder BETWEEN 60 AND 100

--9
SELECT o.OrderID, DAY(o.OrderDate) AS 'OrderDay', MONTH(o.OrderDate) AS 'OrderMonth', YEAR(o.OrderDate) AS 'Order Year', o.Freight, 
CASE WHEN o.Freight >=100 THEN '10%' ELSE '5%' END AS 'tax',
CASE WHEN o.Freight >=100 THEN o.Freight*0.1+o.Freight ELSE o.Freight*0.05+o.Freight END AS 'Freight with tax'
FROM dbo.Orders o
WHERE o.OrderDate BETWEEN '8/1/1996' AND '8/5/1996'

--10
SELECT e.LastName+' '+e.FirstName, e.TitleOfCourtesy, 
CASE WHEN e.TitleOfCourtesy ='Mr.' OR e.TitleOfCourtesy='Dr.' THEN 'Male' WHEN e.TitleOfCourtesy='Ms.' OR e.TitleOfCourtesy='Mrs.' THEN 'Female' END AS 'Sex'
FROM dbo.Employees e

--11
SELECT e.LastName +' '+e.FirstName AS 'full name', e.TitleOfCourtesy, 
CASE WHEN e.TitleOfCourtesy ='Mr.' OR e.TitleOfCourtesy ='Dr.' THEN 'M' WHEN e.TitleOfCourtesy='Ms.' OR e.TitleOfCourtesy='Mrs.' THEN 'F' END AS 'sex'
FROM dbo.Employees e
