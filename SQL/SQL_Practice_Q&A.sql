--Show all employees.
SELECT *FROM employees;

--Show employees earning more than 70000.
SELECT name, salary
FROM employees
WHERE salary > 70000;

--Show employees sorted by salary descending.
SELECT name, salary
FROM employees
ORDER BY salary DESC;

--Count total employees.
SELECT count(*) AS total_employees
FROM employees;

--Show average salary.
SELECT AVG(salary) AS average_salary
FROM employees;

--Show total salary per department.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

--Show department with highest average salary.
SELECT department, AVG(salary)AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

--Count employees in each department.
SELECT department, count(*) AS total_employees
FROM employees
GROUP BY department;

--Show departments where total salary > 120000.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING total_salary > 120000;

--Show highest salary in each department.
SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

--Show employee name and their project name.
SELECT e.name, p.project_name
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id;

--Show employees who are not assigned to any project.
SELECT e.name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

--Show total project budget handled by each employee.
SELECT e.name, SUM(p.project_budget) AS total_budget
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
GROUP BY e.name;

--Show employee who handles the highest project budget.
SELECT e.name, SUM(p.project_budget) AS highest_budget
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
GROUP BY e.name
ORDER BY highest_budget DESC
LIMIT 1;

--Show department-wise total project budget.
SELECT e.department, SUM(p.project_budget) AS total_project_budget
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
GROUP BY e.department;

--Show employees hired after 2020.
SELECT name, hire_date
FROM employees
WHERE hire_date > '2020-12-31';

--Show employee with second highest salary.
SELECT name, MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

--Show top 3 highest paid employees.
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

--Show employees earning more than department average.
SELECT name, salary
FROM employees e
WHERE salary >
(
  SELECT AVG(salary)
  FROM employees
  WHERE department = e.department
  );

--Rank employees by salary (highest first).
SELECT name,
salary,
RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
