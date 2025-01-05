-- Determine the percentage distribution of each payment status.
SELECT 
    ps.DESCRIPTION AS PaymentStatus,
    COUNT(*) AS PaymentCount,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM Payment) * 100, 2) AS PaymentPercentage
FROM Payment p
JOIN Payment_Status ps 
    ON p.Payment_Status = ps.Payment_Status_ID
GROUP BY PaymentStatus;