## Employee and Office Analysis

1. List the top 5 employees with the highest salaries, including their names, departments, and email addresses.
```sql
SELECT 
    CONCAT(First_Name, ' ', Last_Name) AS Employee_Name,
    Department,
    Email,
    Salary
FROM Employees
ORDER BY Salary DESC;
```
2. Calculate the total salary expenditure for each department.
```sql
SELECT 
    Department,
    SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
ORDER BY Total_Salary DESC;
```
3. List all managers and the number of employees reporting to them.
```sql
SELECT
    man.EmployeeID AS Manager_ID,
    CONCAT(man.First_Name, ' ', man.Last_Name) AS Manager_Name,
    man.department AS Manager_Department,
    COUNT(emp.EmployeeID) AS Number_of_Employees,
    man.Hire_Date
FROM Employees emp 
JOIN Employees man 
    ON emp.ManagerID = man.ManagerID
GROUP BY Manager_ID
ORDER BY Number_of_Employees DESC;
```

## Customers and Orders

1. Who are the top customers contributing the most to total sales revenue?
```sql
SELECT 
    c.CustomerID,
    CONCAT(First_Name, ' ', Last_Name) AS CustomerName,
    SUM(Amount) AS TotalSales
FROM Customers c
JOIN Payment p
    ON c.CustomerID = p.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSales DESC
LIMIT 10;
```

2. What is the average order value for each customer segment? 
```sql
SELECT 
    ROUND(AVG(Amount),2) AS AverageOrderValue
FROM Payment p;
```
3. Which locations generate the highest sales volume?
```sql
SELECT
    a.City,
    a.State,
    a.Country,
    SUM(Amount) AS TotalSales
FROM Payment p 
JOIN Customers c
    ON p.CustomerID = c.CustomerID
JOIN Address a
    ON c.AddressID = a.AddressID
GROUP BY a.City, a.State, a.Country
ORDER BY TotalSales DESC;
```
4. Identify months of the year with the highest sales revenue.
```sql
SELECT 
    SUBSTRING(Payment_Date, 1, 7) AS PaymentMonth,
    SUM(Amount) AS TotalSales
FROM Payment
GROUP BY PaymentMonth
ORDER BY TotalSales DESC;
```

## Payments
1. Determine the percentage distribution of each payment status.
```sql
SELECT 
    ps.DESCRIPTION AS PaymentStatus,
    COUNT(*) AS PaymentCount,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM Payment) * 100, 2) AS PaymentPercentage
FROM Payment p
JOIN Payment_Status ps 
    ON p.Payment_Status = ps.Payment_Status_ID
GROUP BY PaymentStatus;
```
## Product Performance
1. Which products category are the best sellers in terms of quantity sold?
```sql
SELECT
    c.description AS category,
    p.Type,
    SUM(op.quantity) AS total_quantity_sold
FROM OrderProducts op 
JOIN Products p 
    ON op.productid = p.productid
JOIN Category c 
    ON p.categoryid = c.categoryid
GROUP BY 1, 2
ORDER BY 3 DESC;
```
2. -- Show all unique combinations of product type, size, and color.
```sql
SELECT 
    Type,
    Size,
    Color
FROM Products
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
```
3. Calculates the total number of unique Size and Color combinations for each product type.
```sql
SELECT 
    Type,
    COUNT(DISTINCT CONCAT(Size, '-', Color)) AS Total_Options
FROM Products
GROUP BY Type
ORDER BY Type ASC;
```