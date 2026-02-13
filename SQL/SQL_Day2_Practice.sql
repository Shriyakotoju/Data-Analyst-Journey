-- ==========================================
-- SQL DAY 2 – SALES ANALYSIS PRACTICE
-- Mammu – Data Analyst Journey
-- ==========================================

-- 1️⃣ Create Table

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    order_id INTEGER PRIMARY KEY,
    order_date TEXT,
    customer_name TEXT,
    city TEXT,
    category TEXT,
    sales INTEGER,
    payment_mode TEXT
);

-- 2️⃣ Insert Data

INSERT INTO sales VALUES
(1001, '2024-01-05', 'Arun Kumar', 'Chennai', 'Electronics', 25000, 'UPI'),
(1002, '2024-01-06', 'Priya Sharma', 'Mumbai', 'Furniture', 18000, 'Card'),
(1003, '2024-01-08', 'Ravi Verma', 'Delhi', 'Electronics', 32000, 'Cash'),
(1004, '2024-01-10', 'Amit Patel', 'Mumbai', 'Accessories', 12000, 'UPI'),
(1005, '2024-01-12', 'Pooja Sharma', 'Chennai', 'Furniture', 22000, 'Card'),
(1006, '2024-01-15', 'Arun Kumar', 'Chennai', 'Electronics', 28000, 'UPI'),
(1007, '2024-01-18', 'Sneha Reddy', 'Hyderabad', 'Furniture', 26000, 'UPI'),
(1008, '2024-01-20', 'Rahul Mehta', 'Delhi', 'Accessories', 15000, 'Cash');

-- ==========================================
-- QUERIES
-- ==========================================

-- 1️⃣ Total Sales
SELECT SUM(sales) AS total_sales FROM sales;

-- 2️⃣ Average Sales
SELECT AVG(sales) AS avg_sales FROM sales;

-- 3️⃣ City-wise Total Sales
SELECT city, SUM(sales) AS total_sales
FROM sales
GROUP BY city;

-- 4️⃣ Orders Between 20000 and 30000
SELECT *
FROM sales
WHERE sales BETWEEN 20000 AND 30000;

-- 5️⃣ Only Chennai and Mumbai Orders
SELECT *
FROM sales
WHERE city IN ('Chennai', 'Mumbai');

-- 6️⃣ Customers Starting with A
SELECT *
FROM sales
WHERE customer_name LIKE 'A%';

-- Customers name ending with Sharma
 SELECT *
 FROM sales
 Where customer_name LIKW '%Sharma':

-- 7️⃣ City Total Sales Greater Than 40000
SELECT city, SUM(sales) AS total_sales
FROM sales
GROUP BY city
HAVING total_sales > 40000;

-- 8️⃣ Category-wise Sales
SELECT category, SUM(sales) AS total_sales
FROM sales
GROUP BY category;

-- 9️⃣ UPI Payments Only
SELECT *
FROM sales
WHERE payment_mode = 'UPI';

-- 🔟 Customers Appearing More Than Once
SELECT customer_name, COUNT(*) AS total_orders
FROM sales
GROUP BY customer_name
HAVING COUNT(*) > 1;

-- 💼 Interview Question
-- Top City by Revenue Excluding Mumbai

SELECT city, SUM(sales) AS total_sales
FROM sales
WHERE city != 'Mumbai'
GROUP BY city
ORDER BY total_sales DESC
LIMIT 1;

-- ==========================================
-- END OF DAY 2
-- ==========================================
