
# Order Delay Analytics (SQL Project)

This project simulates order-level data from a quick commerce/delivery platform and uses SQL to analyze delays, delivery performance, and root causes.

## 📦 Dataset

The dataset includes 100+ order records with fields:
- `order_id`
- `city`
- `sku`
- `order_date`
- `expected_delivery_date`
- `actual_delivery_date`
- `delay_reason`

## 🧠 Objectives

- Calculate average delay days per city  
- Identify most common delay reasons  
- Classify orders as On-Time, Slightly Delayed, or Severely Delayed  
- Count delayed vs on-time orders  
- Analyze SLA breaches (more than 3 days late)

## 🔍 Sample SQL Queries

### 1. Calculate Delay Days
```sql
SELECT 
  order_id,
  DATEDIFF(actual_delivery_date, expected_delivery_date) AS delay_days
FROM orders
WHERE actual_delivery_date > expected_delivery_date;
```

### 2. Average Delay per City
```sql
SELECT 
  city,
  AVG(DATEDIFF(actual_delivery_date, expected_delivery_date)) AS avg_delay
FROM orders
WHERE actual_delivery_date > expected_delivery_date
GROUP BY city;
```

### 3. Top Delay Reasons
```sql
SELECT 
  delay_reason,
  COUNT(*) AS delay_count
FROM orders
WHERE delay_reason IS NOT NULL
GROUP BY delay_reason
ORDER BY delay_count DESC
LIMIT 3;
```

### 4. Delivery Status Classification
```sql
SELECT 
  order_id,
  CASE 
    WHEN actual_delivery_date <= expected_delivery_date THEN 'On Time'
    WHEN DATEDIFF(actual_delivery_date, expected_delivery_date) <= 3 THEN 'Slightly Delayed'
    ELSE 'Severely Delayed'
  END AS delivery_status
FROM orders;
```

### 5. On-Time vs Delayed Orders
```sql
SELECT 
  CASE 
    WHEN actual_delivery_date <= expected_delivery_date THEN 'On Time'
    ELSE 'Delayed'
  END AS delivery_status,
  COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status;
```

## 🛠 Tools Used

- SQL (MySQL / PostgreSQL-compatible syntax)
- Excel for data generation
- Simulated dataset with realistic delivery patterns

## ✅ Outcome

This project demonstrates how SQL can be used to analyze operational performance, classify delays, and uncover patterns in quick-commerce delivery data.
