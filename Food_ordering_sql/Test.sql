-- test.sql: Advanced SQL queries to test FoodyBro functionality

-- 1. View all users
SELECT * FROM users;

-- 2. View addresses for a user
SELECT * FROM addresses WHERE user_id = 1;

-- 3. View available food items
SELECT * FROM foods WHERE in_stock = TRUE;

-- 4. Join: Cart with food details
SELECT f.name, c.quantity, f.price, f.price * c.quantity AS total_price
FROM cart_items c
JOIN foods f ON f.id = c.food_id
WHERE c.user_id = 1;

-- 5. View order details
SELECT o.id AS order_id, o.total_amount, o.status, o.created_at
FROM orders o
WHERE o.user_id = 1;

-- 6. Join: Order items with food
SELECT f.name, oi.quantity, oi.price_at_order_time
FROM order_items oi
JOIN foods f ON oi.food_id = f.id
WHERE oi.order_id = 1;

-- 7. View payment info
SELECT * FROM payments WHERE order_id = 1;

-- 8. Join: Reviews with food
SELECT f.name AS food, r.rating, r.comment
FROM reviews r
JOIN foods f ON r.food_id = f.id
WHERE r.user_id = 1;

-- 9. Group By: Count of reviews per food
SELECT food_id, COUNT(*) AS review_count
FROM reviews
GROUP BY food_id;

-- 10. Admin logs
SELECT * FROM admin_logs;

-- 11. Aggregation: Total revenue generated
SELECT SUM(total_amount) AS total_revenue FROM orders WHERE payment_status = 'paid';

-- 12. Average rating per food item
SELECT f.name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM reviews r
JOIN foods f ON f.id = r.food_id
GROUP BY f.id, f.name
HAVING COUNT(r.id) >= 1;

-- 13. Orders placed in the last 7 days
SELECT * FROM orders
WHERE created_at >= CURDATE() - INTERVAL 7 DAY;

-- 14. Top 3 most ordered food items
SELECT f.name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN foods f ON oi.food_id = f.id
GROUP BY f.id, f.name
ORDER BY total_quantity DESC
LIMIT 3;

-- 15. Users who have spent more than ₹500
SELECT u.id, u.name, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
HAVING SUM(o.total_amount) > 500;

-- 16. Orders with multiple items (HAVING with COUNT)
SELECT order_id, COUNT(*) AS items_count
FROM order_items
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 17. CASE statement: Categorize food price ranges
SELECT name,
       price,
       CASE
           WHEN price < 100 THEN 'Cheap'
           WHEN price BETWEEN 100 AND 200 THEN 'Moderate'
           ELSE 'Expensive'
       END AS price_category
FROM foods;

-- 18. Nested Subquery: Foods with above-average price
SELECT name, price
FROM foods
WHERE price > (SELECT AVG(price) FROM foods);

-- 19. Correlated Subquery: Latest review per food
SELECT f.name, r.rating, r.comment, r.created_at
FROM reviews r
JOIN foods f ON f.id = r.food_id
WHERE r.created_at = (
    SELECT MAX(r2.created_at)
    FROM reviews r2
    WHERE r2.food_id = r.food_id
);

-- 20. Window Function: Ranking food by popularity
SELECT f.name, SUM(oi.quantity) AS total_ordered,
       RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS popularity_rank
FROM order_items oi
JOIN foods f ON f.id = oi.food_id
GROUP BY f.id, f.name;

-- 21. Window Function: Running total of payments
SELECT order_id, amount,
       SUM(amount) OVER (ORDER BY paid_at) AS running_total
FROM payments;

-- 22. Orders along with their number of items
SELECT o.id AS order_id, COUNT(oi.id) AS item_count, o.total_amount
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id;

-- 23. Most recent order per user
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at DESC) AS rn
    FROM orders
) latest_orders
WHERE rn = 1;

-- 24. Percentage of each payment method
SELECT payment_method,
       COUNT(*) AS count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM payments), 2) AS percentage
FROM payments
GROUP BY payment_method;

-- 25. Orders with food items costing more than 200
SELECT o.id AS order_id, f.name, oi.price_at_order_time
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN foods f ON oi.food_id = f.id
WHERE oi.price_at_order_time > 200;
