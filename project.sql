-- =========================================
-- ONLINE SHOPPING SYSTEM DATABASE PROJECT
-- =========================================

-- Create Database
CREATE DATABASE OnlineShoppingSystem;

-- Use Database
USE OnlineShoppingSystem;

-- =========================================
-- 1. USERS TABLE
-- =========================================

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- =========================================
-- 2. PRODUCTS TABLE
-- =========================================

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- =========================================
-- 3. CART TABLE
-- =========================================

CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT DEFAULT 1,

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- =========================================
-- 4. ORDERS TABLE
-- =========================================

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),

    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- =========================================
-- 5. PAYMENTS TABLE
-- =========================================

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date DATE,

    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =========================================
-- INSERT SAMPLE DATA INTO USERS
-- =========================================

INSERT INTO Users (full_name, email, password, phone, address)
VALUES
('Ali Khan', 'ali@gmail.com', 'ali123', '03001234567', 'Mardan'),
('Ahmed Shah', 'ahmed@gmail.com', 'ahmed123', '03111234567', 'Peshawar');

-- =========================================
-- INSERT SAMPLE DATA INTO PRODUCTS
-- =========================================

INSERT INTO Products (product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 120000, 10),
('Mobile Phone', 'Electronics', 50000, 15),
('Headphones', 'Accessories', 3000, 25);

-- =========================================
-- INSERT SAMPLE DATA INTO CART
-- =========================================

INSERT INTO Cart (user_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1);

-- =========================================
-- INSERT SAMPLE DATA INTO ORDERS
-- =========================================

INSERT INTO Orders (user_id, order_date, total_amount, order_status)
VALUES
(1, '2026-05-20', 126000, 'Pending'),
(2, '2026-05-20', 50000, 'Shipped');

-- =========================================
-- INSERT SAMPLE DATA INTO PAYMENTS
-- =========================================

INSERT INTO Payments (order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'Credit Card', 'Paid', '2026-05-20'),
(2, 'Cash on Delivery', 'Pending', '2026-05-20');

-- =========================================
-- DISPLAY ALL PRODUCTS
-- =========================================

SELECT * FROM Products;

-- =========================================
-- PRODUCT SEARCH
-- =========================================

SELECT *
FROM Products
WHERE product_name LIKE '%Laptop%';

-- =========================================
-- VIEW USER CART
-- =========================================

SELECT
    Users.full_name,
    Products.product_name,
    Cart.quantity,
    Products.price
FROM Cart
JOIN Users
    ON Cart.user_id = Users.user_id
JOIN Products
    ON Cart.product_id = Products.product_id;

-- =========================================
-- ORDER TRACKING
-- =========================================

SELECT
    Orders.order_id,
    Users.full_name,
    Orders.order_date,
    Orders.total_amount,
    Orders.order_status
FROM Orders
JOIN Users
    ON Orders.user_id = Users.user_id;

-- =========================================
-- PAYMENT DETAILS
-- =========================================

SELECT
    Payments.payment_id,
    Orders.order_id,
    Payments.payment_method,
    Payments.payment_status
FROM Payments
JOIN Orders
    ON Payments.order_id = Orders.order_id;

-- =========================================
-- TRANSACTION EXAMPLE
-- =========================================

START TRANSACTION;

INSERT INTO Orders(user_id, order_date, total_amount, order_status)
VALUES(1, CURDATE(), 3000, 'Pending');

UPDATE Products
SET stock = stock - 1
WHERE product_id = 3;

COMMIT;

-- If any error occurs:
-- ROLLBACK;

-- =========================================
-- LEFT JOIN EXAMPLE
-- =========================================

SELECT
    Users.full_name,
    Orders.order_id
FROM Users
LEFT JOIN Orders
    ON Users.user_id = Orders.user_id;
