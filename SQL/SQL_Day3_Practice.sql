CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Ram', 'Hyderabad'),
(2, 'Sita', 'Mumbai'),
(3, 'John', 'Delhi');

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, 500),
(102, 2, 800),
(103, 1, 300);

--Show customer name & order amount(USE INNER JOIN)

SELECT customers.name, orders.amount
FROM customers 
INNER JOIN orders 
ON customers.customer_id = orders.customer_id;

--Show all customers with their orders(USE LEFT JOIN)

SELECT customers.name, orders.amount
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id;

--Show total amount spent by each customer

SELECT customers.name, SUM(orders.amount) AS total_spent
FROM customers c
LEFT JOIN orders o
ON customers.customer_id = orders.customer_id
GROUP BY customers.name;

