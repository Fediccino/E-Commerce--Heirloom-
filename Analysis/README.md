# The Analysis Results
Each query for this project aimed at investigating specific aspects of our database. Here's how I approached each question:

## Customers and Orders
### 1. Identify months of the year with the highest sales revenue.
To identify the months with the highest sales revenue, we need to use a `SUBSTRING` function to extract the only the year and month value from the Payment table, which is formatted in a `DATETIME` Data Type. We also utilize a `SUM` aggregate function to retrieve the Total Sales revenue for each particular month.

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

- **Historical Trend:** We see that the company revenue for the year 2024, maintained a steady growth in revenue sales while experiencing some peak performance in Dec 2024, July 2024, and Aug 2024. We *may* be able to attribute these peaks in revenue to *seasonality*, such as during Holidays America sees a increase in consumer purchasing.

![Figure 7](/assets/figure7.jpg)
*This is mock data and not a accurate representation of business sales*

### 2. Which locations generate the highest sales volume?
In this scenario we want to identify cities and states that have the top sales revenue. This will allow us particular insights that the Marketing team would be able to utilize and capitalize, to then develop campaigns that target the states that are average performing. We would also be able to, if data allowed, to view the correlational effectiveness of marketing campaigns in the designated City and State, by measuring **Churn** and **First- and Last- Touch Attributions.**
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
- **Graphical Data:** Here we see the areas in the United States where the company experienced highest revenue sales for the year of 2024.

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

*This is mock data and not a accurate representation of business sales*

- **Run** the `html` file to be taken to an interactive map chart allowing you to see the highest sales volumes in the the City and States.

![Interactive Map Chart](/assets/interactive_us_sales_map.html)

## Payments
### 3. What is the distribution of each payment status?
This question allows us to calculate the percentage of total payments that each status represents in the overall data. **Finance** departments can use this to further investigate any unpaid invoices. We can begin to retrieve this information by using a `LEFT JOIN` to join the Payments, Customers, and Payment Status, and filter it by `Payment Declined` values to retrieve the invoices which have unfulfilled invoices.

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
### 4. Which products category are the best sellers in terms of quantity sold?
Our goal is to present a breakdown of the best sellers item(s). The company can make *critical* business decisions as to which products to offer, based on the historical data representing the most sold items and categories. Allowing them to capetilize on their already growing clientbase and market.

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

![Figure 9](/assets/figure9.jpg)

## Operations and Expenses
### 5. What is the total salary expenditure per department?
The company wants to see the overall *Operating Expenses.* By selecting the Department from the Employees table and `GROUP BY`, we can `SUM` the salary to view the total salary for each department.

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
*This is fictitious data. Not be interpreted as accurate representation of salaries.*
![Figure 2](/assets/figure2.jpg)

### 6. Who are the managers of the organization? And how many employees are under their management?
Very large organizations have too many employees to be able to properly know them all. With this beginning query, we can begin to see the breakdown of the overall Management relations within the company. The query retrieves for us the names of the Managers in the organization, along with how many individuals are under their management. Included, is each individual managers `Hire Date` and their unique Employee ID, as `Manager ID`

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

- **Department** Here we see the total number of employees that are managed within each department. Allowing us to see the distribution of employees across the organization, as a whole.
![Figure 3](/assets/figure3.jpg)