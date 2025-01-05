-- Which products category are the best sellers in terms of quantity sold?
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

-- Show all unique combinations of product type, size, and color.

SELECT 
    Type,
    Size,
    Color
FROM Products
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;

-- Calculates the total number of unique Size and Color combinations for each product type.
SELECT 
    Type,
    COUNT(DISTINCT CONCAT(Size, '-', Color)) AS Total_Options
FROM Products
GROUP BY Type
ORDER BY Type ASC;

