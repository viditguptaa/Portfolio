-- insert.sql: Insert sample data into FoodyBro database

INSERT INTO users (name, email, password, phone, role) VALUES
('Alice Sharma', 'alice@example.com', 'hashedpass1', '9998887771', 'user'),
('Bob Singh', 'bob@example.com', 'hashedpass2', '8887776662', 'admin');

INSERT INTO addresses (user_id, street, city, state, postal_code, country) VALUES
(1, '123 Main St', 'Delhi', 'Delhi', '110001', 'India'),
(1, '456 Park Ave', 'Mumbai', 'Maharashtra', '400001', 'India');

INSERT INTO foods (name, description, price, category, image_url) VALUES
('Margherita Pizza', 'Classic cheese pizza', 250.00, 'Pizza', 'pizza.jpg'),
('Paneer Butter Masala', 'Spicy and creamy', 180.00, 'Indian', 'paneer.jpg'),
('Veg Burger', 'With fries', 120.00, 'Burger', 'burger.jpg');

INSERT INTO cart_items (user_id, food_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1);

INSERT INTO orders (user_id, address_id, total_amount, status, payment_status, payment_method) VALUES
(1, 1, 620.00, 'pending', 'unpaid', 'cash');

INSERT INTO order_items (order_id, food_id, quantity, price_at_order_time) VALUES
(1, 1, 2, 250.00),
(1, 3, 1, 120.00);

INSERT INTO payments (order_id, amount, payment_method, payment_status, transaction_id, paid_at) VALUES
(1, 620.00, 'cash', 'success', 'TXN123456789', NOW());

INSERT INTO reviews (user_id, food_id, rating, comment) VALUES
(1, 1, 5, 'Delicious!'),
(1, 3, 4, 'Tasty but a bit cold.');

INSERT INTO admin_logs (admin_id, action) VALUES
(2, 'Updated prices of burgers');
