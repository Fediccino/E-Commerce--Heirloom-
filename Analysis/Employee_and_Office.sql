-- List the top 5 employees with the highest salaries, including their names, departments, and email addresses.

SELECT 
    CONCAT(First_Name, ' ', Last_Name) AS Employee_Name,
    Department,
    Email,
    Salary
FROM Employees
ORDER BY Salary DESC;

-- Calculate the total salary expenditure for each department.

SELECT 
    Department,
    SUM(Salary) AS Total_Salary
FROM Employees
GROUP BY Department
ORDER BY Total_Salary DESC;

-- List all managers and the number of employees reporting to them.

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