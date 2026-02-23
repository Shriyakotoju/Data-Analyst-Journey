--SUBQUERIES
--Single Row subquery
--Find employees earning more than average salary.
SELECT name, salary
FROM employees
WHERE salary > (
  SELECT AVG(salary)
  FROM employees
  );
  --inner query runs first
  --outer query compares

--Correlated SUBQUERY
--Find employees earning more than their department average.
SELECT e.name, e.salary, d.dept_name
FROM employees e
JOIN departments d 
ON e.dept_id = d.dept_id
WHERE e.salary > (
  SELECT AVG(salary)
  FROM employees 
  WHERE dept_id = e.dept_id
  );

--CASE STATEMENT (Business Logic)
--Categorize Salary Above 80000 → High 
--60000–80000 → Medium
--Below 60000 → Low
SELECT name, 
salary,
CASE 
WHEN salary > 80000 THEN 'High'
WHEN salary BETWEEN 60000 AND 80000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees;


--DATE FUNCTIONS  
'''Every database has different functions:
Database	Function
MySQL	TIMESTAMPDIFF
PostgreSQL	AGE
SQLite	STRFTIME / JULIANDAY'''

--Years of Experience
--MySQL Version
SELECT name,
       hire_date,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience_years
FROM employees;

--PostgreSQL Version
SELECT name,
       AGE(CURRENT_DATE, hire_date) AS experience
FROM employees;
--sqlite Version
SELECT name,
       hire_date,
       (strftime('%Y', 'now') - strftime('%Y', hire_date)) AS experience_years
FROM employees;
(OR)
SELECT name,
       hire_date,
       CAST((julianday('now') - julianday(hire_date)) / 365 AS INT) 
       AS experience_years
FROM employees;

--MULTIPLE JOIN THINKING
--Show department, employee name, project name, project budget
SELECT d.dept_name,
       e.name,
       p.project_name,
       p.budget
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.emp_id = p.emp_id;

--Find employee with 3rd highest salary
(Use window function)
SELECT name, salary
FROM( SELECT name,
     salary,
     DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
     FROM employees
     )
     WHERE rnk = 3;

--Show employees earning more than their department average
(Use correlated subquery)
SELECT e.name, e.salary, d.dept_name
FROM employees e 
JOIN departments d 
ON e.dept_id = d.dept_id
WHERE e.salary > ( 
  SELECT AVG(salary)
  FROM employees
  WHERE dept_id = e.dept_id
  );

--Show departments where average salary > overall company average salary
(Double aggregation logic)
SELECT d.dept_name, AVG(e.salary) AS dept_avg
FROM employees e 
JOIN departments d 
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > (
  SELECT AVG(salary) FROM employees);

--Show employees who are handling more than 1 project
(Join + GROUP BY + HAVING)
SELECT e.name, COUNT(p.project_id) AS total_projects
FROM employees e 
JOIN projects p 
ON e.emp_id = p.emp_id
GROUP BY e.emp_id
HAVING COUNT(p.project_id) > 1;

--Show highest paid employee in each department
(Window function or subquery)
SELECT dept_name, name, salary
FROM (
    SELECT d.dept_name,
           e.name,
           e.salary,
           RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS rnk
    FROM employees e
    JOIN departments d 
  ON e.dept_id = d.dept_id
)
WHERE rnk = 1;

--Rank employees inside each department by salary (highest first)
(Partition by department)
SELECT d.dept_name,
e.name,
e.salary,
RANK() OVER (PARTITION BY d.dept_name ORDER BY salary DESC) AS dept_rnk
FROM employees e 
JOIN departments d 
ON e.dept_id = d.dept_id;

--Show running total of salary ordered by salary descending
(Window function cumulative sum)
SELECT name,
salary,
SUM(salary) OVER (ORDER BY salary DESC) AS running_total
FROM employees;


--Show department-wise total project budget
(3 table join)
SELECT d.dept_name,
SUM(p.budget) AS total_budget
FROM employees e 
JOIN departments d 
ON e.dept_id = d.dept_id
JOIN projects p 
ON e.emp_id = p.emp_id
GROUP BY d.dept_name;

--Show employees hired in last 3 years
(Date logic)
SELECT name, hire_date
FROM employees
WHERE CAST(strftime('%Y', hire_date) AS INT) >= 
      CAST(strftime('%Y', 'now') AS INT) - 3;
      (OR)
SELECT name, hire_date
FROM employees
WHERE hire_date >= date('now', '-3 years', 'start of year');

 (OR)
 SELECT name, hire_date
FROM employees
WHERE hire_date >= date('now', '-3 years');


--Show employees who do NOT have any project
(LEFT JOIN logic)
SELECT e.name
FROM employees e 
LEFT JOIN projects p 
ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

'''
Subquery → Query inside query
Correlated → Runs per row
Window function → Calculates without removing rows
OVER → Defines calculation area
PARTITION → Split into groups
RANK → Ranking with gaps
DENSE_RANK → Ranking without gaps
ROW_NUMBER → Always unique numbers
Date function → Work with dates
JOIN condition → Connect tables
GROUP BY → Summarize data
'''