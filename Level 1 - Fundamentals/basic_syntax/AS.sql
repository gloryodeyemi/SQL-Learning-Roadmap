-- AS Keyword (Aliasing)
-- The AS clause in SQL is used to rename columns or tables with aliases, making your queries more readable and maintainable. It's like giving a 
-- nickname to your columns or tables!

-- Basic Column Aliasing
-- Give your columns more meaningful names in the result set:
SELECT 
  first_name AS given_name,
  last_name AS family_name
FROM users;

-- Aliasing Expressions
-- Make complex calculations more understandable
-- Aliasing calculated columns
SELECT 
  product_name,
  unit_price * (1 - discount) AS final_price,
  units_in_stock * unit_price AS inventory_value
FROM products;

-- Using Spaces in Aliases
-- Using quotes for aliases with spaces
SELECT 
  first_name || ' ' || last_name AS "Full Name",
  email AS "Contact Email"
FROM employees;

-- Basic Table Aliasing
-- Simplify references to table names, especially in joins
-- Using table aliases in joins
SELECT 
  c.customer_name,
  o.order_date,
  p.product_name
FROM 
  customers AS c
  JOIN orders AS o ON c.customer_id = o.customer_id
  JOIN products AS p ON o.product_id = p.product_id;

-- Self Joins with Aliases
-- Table aliases are essential when joining a table with itself
SELECT 
  e1.first_name AS employee_name,
  e2.first_name AS manager_name
FROM 
  employees AS e1
  LEFT JOIN employees AS e2 ON e1.manager_id = e2.employee_id;

-- Subquery Aliases
-- Give meaningful names to derived tables
-- Aliasing subqueries
SELECT 
  dept_summary.department_name,
  dept_summary.avg_salary
FROM (
  SELECT 
    d.department_name,
    AVG(e.salary) as avg_salary
  FROM 
    departments d
    JOIN employees e ON d.department_id = e.department_id
  GROUP BY 
    d.department_name
) AS dept_summary
WHERE 
  dept_summary.avg_salary > 50000;

-- Common Table Expressions (CTEs) with AS
-- Using AS in CTEs
WITH high_value_orders AS (
  SELECT 
    customer_id,
    COUNT(*) as order_count,
    SUM(total_amount) as total_spent
  FROM orders
  GROUP BY customer_id
  HAVING SUM(total_amount) > 10000
)
SELECT 
  c.customer_name,
  hvo.order_count,
  hvo.total_spent
FROM 
  customers c
  JOIN high_value_orders hvo ON c.customer_id = hvo.customer_id;

-- Common Pitfalls and Solutions
-- 1. Using Aliases in WHERE Clauses

-- This will NOT work
SELECT 
  unit_price * quantity AS total_cost
FROM order_details
WHERE total_cost > 1000;

-- This WILL work
SELECT 
  unit_price * quantity AS total_cost
FROM order_details
WHERE unit_price * quantity > 1000;
-- Remember that WHERE clauses are processed before SELECT, so column aliases aren't available yet.

-- 2. Forgetting to Use Table Aliases in Complex Joins
-- Ambiguous column reference
SELECT 
  employee_id,  -- Error: ambiguous column
  department_name
FROM 
  employees
  JOIN departments ON department_id = department_id;  -- Error: ambiguous join

-- Fixed with aliases
SELECT 
  e.employee_id,
  d.department_name
FROM 
  employees e
  JOIN departments d ON e.department_id = d.department_id;

-- QUIZ
-- 1. True or False: The AS keyword is required when aliasing columns or tables in SQL. Explain your reasoning.
-- While many databases don't strictly require the AS keyword, using it improves the clarity and readability of your SQL queries. It's a good 
-- practice to adopt.

-- 2. Write a SQL query that selects the customer_id and order_date from the orders table. Alias the customer_id column as CustomerID and the 
-- order_date column as OrderDate.
SELECT customer_id AS CustomerID, order_date AS OrderDate
FROM orders;

-- 3. Can you use column aliases in the WHERE clause? Explain why or why not.
-- Column aliases cannot be used in the WHERE clause because the WHERE clause is processed before the SELECT statement where the alias is defined. 
-- Table aliases, on the other hand, can be used in the WHERE clause because the FROM clause (where table aliases are defined) is processed before 
-- the WHERE clause.