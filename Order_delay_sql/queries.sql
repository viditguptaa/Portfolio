
-- 1. Calculate delivery delay in days
SELECT order_id,
       DATEDIFF(actual_delivery_date, expected_delivery_date) AS delay_days
FROM orders
WHERE actual_delivery_date > expected_delivery_date;

-- 2. Average delay per city
SELECT city,
       AVG(DATEDIFF(actual_delivery_date, expected_delivery_date)) AS avg_delay
FROM orders
WHERE actual_delivery_date > expected_delivery_date
GROUP BY city;

-- 3. Top delay reasons
SELECT delay_reason,
       COUNT(*) AS delay_count
FROM orders
WHERE delay_reason IS NOT NULL
GROUP BY delay_reason
ORDER BY delay_count DESC
LIMIT 3;

-- 4. Classify delivery status
SELECT order_id,
       CASE 
         WHEN actual_delivery_date <= expected_delivery_date THEN 'On Time'
         WHEN DATEDIFF(actual_delivery_date, expected_delivery_date) <= 3 THEN 'Slightly Delayed'
         ELSE 'Severely Delayed'
       END AS delivery_status
FROM orders;

-- 5. On-Time vs Delayed Orders
SELECT 
  CASE 
    WHEN actual_delivery_date <= expected_delivery_date THEN 'On Time'
    ELSE 'Delayed'
  END AS delivery_status,
  COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status;
