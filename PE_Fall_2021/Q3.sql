Select ProductID, LocationID, Quantity from ProductInventory
where LocationID  = 7 and Quantity > 250
Order by Quantity desc

--De khac
SELECT ProductID, Price, 
SellStartDate as'StartDate', SellEndDate as'EndDate'
FROM Product
WHERE YEAR(SellEndDate) = 2003 AND Price < 100
ORDER BY Price DESC