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
**Do not attempt to contact the email's below. They are mock data and are simply for instructional purposes.**
| Employee Name       | Department | Email                              | Salary     |
|---------------------|------------|------------------------------------|------------|
| Kendall Heppenspall | IT         | kheppenspall57@kickstarter.com     | 85,365.28  |
| Tina Jeannequin     | Marketing  | tjeannequin17@slate.com            | 85,365.28  |
| Wakefield Ambrogio  | Finance    | wambrogio7r@creativecommons.org    | 67,652.35  |
| Valentine Thomerson | Finance    | vthomerson6s@dell.com              | 65,890.44  |
| Valina Thomerson    | Finance    | vthomerson6s@dell.com              | 60,365.28  |

![Figure 1](assets/figure1.png)

2. Calculate the total salary expenditure for each department.
```sql
SELECT 
    Department,
    SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
ORDER BY Total_Salary DESC;
```
| Department | Total Salary  |
|------------|---------------|
| Finance    | 299,273.35    |
| HR         | 146,095.84    |
| Marketing  | 120,730.56    |
| IT         | 85,365.28     |
| Sales      | 35,365.28     |

![Figure 2](assets/figure2.png)

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
| Manager_ID                              | Manager_Name        | Manager_Department | Number_of_Employees | Hire_Date           |
|-----------------------------------------|---------------------|---------------------|----------------------|---------------------|
| 015a3810-f371-42af-8d24-4275d937cbzp    | Griselda Grigoire   | Finance             | 4                    | 2024-01-01 13:04:20 |
| 436d1965-bfb1-4a7d-9336-3cbdbdb7d244    | Cass Bruton         | Sales               | 4                    | 2024-02-09 22:27:11 |
| d96aed0c-aa4f-4230-9bf2-3ef8ba26cd47    | Kendall Heppenspall | IT                  | 4                    | 2024-11-06 11:55:39 |
| dd12cc5b-6278-4aed-b534-cd3321111ee7    | Tina Jeannequin     | Marketing           | 4                    | 2024-02-27 09:56:47 |
| 04f97f6f-6c7d-4eac-adf5-d6704ba9d94d    | Valina Thomerson    | Finance             | 3                    | 2024-09-13 13:04:20 |
| 0a6cadc8-973a-4233-9550-82ff0dd5df7e    | Wakefield Ambrogio  | Finance             | 3                    | 2024-11-11 01:01:01 |
| 760d8158-bc3e-463a-9777-c3bfa97761c3    | Basile Geistman     | HR                  | 3                    | 2024-01-06 23:39:19 |
| 87f97f6f-6c7d-4eac-adf5-d6784ba9d69d    | Valentine Thomerson | Finance             | 3                    | 2024-05-30 13:28:34 |
| 8c5f5468-7107-45af-8a7a-4b661efe312e    | Donal Malley        | HR                  | 3                    | 2024-02-12 22:16:46 |
| f8153238-b1fa-441b-a2c6-e2629f5c39ef    | Kevin Chabau        | HR                  | 3                    | 2024-02-12 22:16:46 |
| b5ac9d30-a08a-4278-b6db-d48f49c2429d    | Quill Sword         | Marketing           | 1                    | 2024-07-31 09:22:20 |

![Figure 3](assets/figure3.png)

## Customers and Orders

4. Who are the top customers contributing the most to total sales revenue?
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
| Customer ID                              | Customer Name        | Total Sales |
|------------------------------------------|----------------------|-------------|
| 1fd300d3-f3d7-430f-8f53-13464948eb47     | Cassaundra Joselson  | 482.49      |
| 7bc5a65c-567d-4288-833e-7c048c53e9f2     | Brendin Josebury     | 482.45      |
| 4c5e3ee9-00a0-4809-a10d-060737a7258a     | Tad Duesbury         | 477.41      |
| 93f709e2-97cc-4a85-a380-82e3229f6cdb     | Phyllys Horsell      | 462.16      |
| b8e22c91-04e5-4181-9b52-e291c9b478fb     | Atalanta Binnion     | 447.11      |
| d9817ef7-e882-4afa-8096-9276711c73b3     | Lin Toon             | 433.15      |
| a6af23f1-1e38-4273-b694-0b8df43dd571     | Clementius Everil    | 432.06      |
| a4e7953b-efc3-451c-918e-8b7dd92ea7e6     | Marilee Vedekhin     | 421.16      |
| 079132bc-2c27-4c12-9c82-ebeca20289a7     | Allyce Rahlof        | 420.70      |
| e1bc16c5-f833-43fa-a856-f13fe4e3f83c     | Cherianne Orpwood    | 411.23      |


5. What is the average order value for each customer segment? 
```sql
SELECT 
    ROUND(AVG(Amount),2) AS AverageOrderValue
FROM Payment p;
```
| Metric              | Value   |
|---------------------|---------|
| Average Order Value | 129.08  |


6. Which locations generate the highest sales volume?
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
| City                | State | Country       | Total Sales |
|---------------------|-------|---------------|-------------|
| Washington          | DC    | United States | 3626.65     |
| New York City       | NY    | United States | 3080.55     |
| Houston             | TX    | United States | 2830.42     |
| Atlanta             | GA    | United States | 2142.35     |
| Dallas              | TX    | United States | 2019.47     |
| Louisville          | KY    | United States | 1840.58     |
| Cincinnati          | OH    | United States | 1830.50     |
| Las Vegas           | NV    | United States | 1674.60     |
| Saint Louis         | MO    | United States | 1597.74     |
| Chicago             | IL    | United States | 1596.55     |
| ... (trimmed for brevity)                                              |


7. Identify months of the year with the highest sales revenue.
```sql
SELECT 
    SUBSTRING(Payment_Date, 1, 7) AS PaymentMonth,
    SUM(Amount) AS TotalSales
FROM Payment
GROUP BY PaymentMonth
ORDER BY TotalSales DESC;
```
| Payment Month | Total Sales  |
|---------------|--------------|
| 2024-12       | 12974.09     |
| 2024-07       | 11882.95     |
| 2024-08       | 11346.62     |
| 2024-11       | 11184.28     |
| 2024-03       | 11005.50     |
| 2024-10       | 10813.17     |
| 2024-05       | 10174.28     |
| 2024-06       | 9780.47      |
| 2024-09       | 9680.27      |
| 2024-01       | 9598.17      |
| 2024-04       | 9577.24      |
| 2024-02       | 9369.06      |
| 2025-01       | 1693.26      |

![Figure 7](assets/figure7.png)

## Payments
8. Determine the percentage distribution of each payment status.
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
| Payment Status     | Payment Count | Payment Percentage |
|--------------------|---------------|---------------------|
| In Progress        | 151           | 15.10%             |
| Payment Accepted   | 577           | 57.70%             |
| Payment Declined   | 272           | 27.20%             |


## Product Performance
9. Which products category are the best sellers in terms of quantity sold?
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
| Category          | Product Type   | Total Quantity Sold |
|-------------------|----------------|----------------------|
| All Things Denim  | Jeans          | 227                  |
| Windbreakers      | Windbreaker    | 224                  |
| All Things Denim  | Jean Jacket    | 214                  |
| Plaid Skirts      | Plaid Skirt    | 190                  |
| All Things Denim  | Skirt          | 189                  |
| Plaid Skirts      | Plaid Jacket   | 179                  |
| All Things Striped| Striped Shirt  | 167                  |
| Graphic Tees      | Graphic Tee    | 154                  |
| Plaid Skirts      | Plaid Sweater  | 146                  |
| Cargo Pants       | Cargo Pants    | 144                  |
| Accessories       | Necklace       | 142                  |
| Bandana Headbands | Bandana        | 138                  |
| Crop Shirts       | Crop Shirt     | 134                  |
| Accessories       | Ring           | 127                  |
| Baggy Jeans       | Baggy Jeans    | 99                   |


10. -- Show all unique combinations of product type, size, and color.
```sql
SELECT 
    Type,
    Size,
    Color
FROM Products
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
```
11. Calculates the total number of unique Size and Color combinations for each product type.
```sql
SELECT 
    Type,
    COUNT(DISTINCT CONCAT(Size, '-', Color)) AS Total_Options
FROM Products
GROUP BY Type
ORDER BY Type ASC;
```
| Product Type     | Total Options |
|------------------|---------------|
| Baggy Jeans      | 37            |
| Bandana          | 37            |
| Cargo Pants      | 46            |
| Crop Shirt       | 39            |
| Graphic Tee      | 39            |
| Jean Jacket      | 41            |
| Jeans            | 48            |
| Necklace         | 39            |
| Plaid Jacket     | 42            |
| Plaid Skirt      | 37            |
| Plaid Sweater    | 40            |
| Ring             | 36            |
| Skirt            | 44            |
| Striped Shirt    | 44            |
| Windbreaker      | 46            |
