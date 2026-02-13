-- SQL Day 1 Practice
-- Data Analyst Portfolio

-- Create Table
CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    customer_name TEXT,
    city TEXT,
    category TEXT,
    sales INT,
    payment_method TEXT
);

-- Insert Data
INSERT INTO sales VALUES
(1001, '2024-01-05', 'Arun Kumar', 'Chennai', 'Electronics', 25000, 'UPI'),
(1002, '2024-01-06', 'Priya Sharma', 'Mumbai', 'Furniture', 18000, 'Card'),
(1003, '2024-01-08', 'Ravi Verma', 'Delhi', 'Electronics', 32000, 'Cash'),
(1004, '2024-01-10', 'Amit Patel', 'Mumbai', 'Accessories', 12000, 'UPI'),
(1005, '2024-01-12', 'Pooja Sharma', 'Chennai', 'Furniture', 22000, 'Card'),
(1006, '2024-01-15', 'Arun Kumar', 'Chennai', 'Electronics', 28000, 'UPI');

-- View all data
SELECT * FROM sales;

-- Show only specific columns 
SELECT order_id, customer_name, sales FROM sales;

-- Total sales
SELECT SUM(sales) AS total_sales FROM sales;

-- Average sales
SELECT AVG(sales) AS average_sales FROM sales;

-- Sales by city
SELECT city, SUM(sales) AS total_sales
FROM sales
GROUP BY city;

-- Sales by category
SELECT category, SUM(sales) AS total_sales
FROM sales
GROUP BY category;

-- Highest sales order
SELECT *
FROM sales
ORDER BY sales DESC
LIMIT 1;

-- Number of Orders per Category
SELECT category, COUNT(*) AS total_orders
FROM sales
GROUP BY category;

- Filter data
SELECT *FROM sales
WHERE city = 'Chennai';

-- Orders Above 25,000
SELECT *
FROM sales
WHERE sales > 25000;

-- Multiple Conditions (AND)
SELECT *FROM sales
WHERE city = 'Mumbai'
AND sales > 15000;

--Sort Data (ORDER BY)
SELECT *FROM sales
ORDER BY sales DESC;

SELECT *FROM sales
ORDER BY sales ASC;


--deletes the table safely
DROP TABLE if EXISTS sales;

--DELETE TABLE
DROP TABLE sales;

--How many columns are listed (check table structure)
PRAGMA table_info(sales);


