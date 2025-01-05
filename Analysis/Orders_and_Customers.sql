-- Who are the top customers contributing the most to total sales revenue?

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

-- What is the average order value for each customer segment?

    SELECT 
        ROUND(AVG(Amount),2) AS AverageOrderValue
    FROM Payment p;

-- Which locations generate the highest sales volume?

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

-- Identify months of the year with the highest sales revenue.

    SELECT 
        SUBSTRING(Payment_Date, 1, 7) AS PaymentMonth,
        SUM(Amount) AS TotalSales
    FROM Payment
    GROUP BY PaymentMonth
    ORDER BY TotalSales DESC;