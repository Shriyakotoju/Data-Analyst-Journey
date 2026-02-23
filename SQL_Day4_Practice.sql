DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Ram', 'Hyderabad'),
(2, 'Sita', 'Mumbai'),
(3, 'John', 'Delhi'),
(4, 'Anjali', 'Chennai'),
(5, 'David', 'Bangalore');

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, 500),
(102, 2, 800),
(103, 1, 300),
(104, 3, 1200),
(105, 2, 400),
(106, 4, 700),
(107, 5, 1500),
(108, 3, 200),
(109, 4, 300),
(110, 5, 1000);

--TASK 1
--Show customer name and total amount spent

SELECT customers.name, SUM(orders.amount) AS total_spent
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.name;
--(Order is not guaranteed because you didn’t use ORDER BY.)

--If you want results ordered by total_spent (highest first), use:
SELECT customers.name, SUM(orders.amount) AS total_spent
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.name
ORDER BY total_spent DESC;

--if you want order_id wise
SELECT customers.name, SUM(orders.amount) AS total_spent
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.name
ORDER BY order_id ASC;

--QUESTION & ANSWER
 --(We can only ORDER BY grouped columns or aggregated values after GROUP BY.”)
--Why can’t we order by order_id after GROUP BY customer?

--TASK 2 
--Show:
--customer name
--number of orders
--total amount
--Sort by number of orders (descending).
SELECT customers.name, COUNT(orders.order_id) AS number_of_orders,
SUM(orders.amount) AS total_amount
FROM customers
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id
GROUP BY customers.name
ORDER BY number_of_orders DESC;

SELECT 
    c.name,
    COUNT(o.order_id) AS number_of_orders,
    SUM(o.amount) AS total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY number_of_orders DESC, total_aount DESC;

--TASK 3
--Find the customer who spent the highest total amount
--Show only one row
SELECT customers.name , SUM(orders.amount) as total amount
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.name
ORDER BY total_amount DESC
limit 1;

--QUESTION & ANSWER
--Why didn’t you use MAX?”
--“MAX(amount) gives the highest single order, not the highest total spending per customer. So we must use SUM and then sort.”
--Why INNER JOIN?
--Because we only need customers who have orders. Customers without orders are irrelevant for spending analysis.
--Why LEFT JOIN?
--To ensure all customers are included, even if they haven’t placed any orders.
--JOIN by default means INNER JOIN.
--INNER JOIN
--Shows only matching records in both tables.
--If a customer has no orders, they will NOT appear.
--LEFT JOIN
--Shows ALL customers.
--Even if a customer has 0 orders, they will still appear.
--Orders will show NULL.
--WHY Did we use inner join in TASK 3?
--If someone has no orders, they can’t have highest spending.


--TASK 4
--Show customer name and total amount spent
 --Only show customers who spent more than 700
 --Sort by highest spender first

SELECT customers.name, SUM(orders.amount) AS total_amount_spent
 From customers
 LEFT JOIN orders
 ON customers.customer_id = orders.customer_id
 GROUP BY customers.name 
 HAVING total_amount_spent > 700 
 ORDER BY total_amount_spent DESC;

 --Why HAVING not WHERE?
--Because:
--WHERE filters rows
--HAVING filters aggregated results (SUM)

--SQL runs in this order (simplified):
--FROM
--JOIN
--WHERE
--GROUP BY
--HAVING
--SELECT
--ORDER BY
--The key point:
--WHERE runs BEFORE GROUP BY
--HAVING runs AFTER GROUP BY

--SIMPLE EXAMPLE Imagine:
--You have marks of students.
--WHERE = filtering individual subject marks
--HAVING = filtering total marks after calculating them