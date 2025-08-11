-- ORDER BY Clause
-- The ORDER BY clause organizes the rows in your result set in a specific sequence. It sorts data based on one or more columns, 
-- making it easier to analyze and work with your results.

-- Ascending vs. Descending Order
-- By default, ORDER BY sorts in ascending order (ASC), but you can explicitly specify descending order (DESC)
-- Sort users by join date (newest first)
SELECT username, join_date 
FROM Users
ORDER BY join_date DESC;

-- Sort videos by title alphabetically (A to Z)
SELECT title, views 
FROM Videos
ORDER BY title ASC;  -- ASC is optional here

-- Sorting by Multiple Columns
-- SQL applies each ORDER BY column in the sequence you list them.
-- Find interactions, sorted by video_id and then timestamp
SELECT video_id, user_id, interaction_type, timestamp
FROM Interactions
ORDER BY video_id ASC, timestamp DESC;

-- Sorting by Column Position
-- Instead of column names, you can use column positions (starting at 1) in the ORDER BY clause.
-- Sort users by join date using column position
SELECT username, email, join_date
FROM Users
ORDER BY 3 DESC;  -- 3 refers to join_date (the third column)

-- Sorting by Calculated Values
-- Find videos and sort by length of title (shortest first)
SELECT 
  video_id,
  title,
  views
FROM 
  Videos
ORDER BY 
  LENGTH(title) ASC;

-- Handling NULL Values
-- NULL values are special in SQL. When sorting, NULLs generally come either first or last (depending on your database). 
-- You can control this behavior
-- Sort interactions by comment text, with NULLs last
SELECT 
  interaction_id,
  user_id,
  video_id,
  comment_text
FROM 
  Interactions
ORDER BY 
  comment_text IS NULL ASC,   -- False (0) comes before True (1)
  comment_text ASC;           -- Then sort non-NULL values normally

/*
Database Differences Alert!
Different database systems handle NULLs differently in ORDER BY:

MySQL & PostgreSQL: NULLs first with ASC, last with DESC
Oracle & SQL Server: NULLs last with ASC, first with DESC
To guarantee consistent results across all databases, use the NULL handling technique shown above!
*/

-- Example 1: Finding Trending Videos
-- TokTuk's product team wants to identify the most popular content by view count. This query creates a "trending videos" list, showing the 5 
-- most-viewed videos on the platform.
-- Find top-performing videos
SELECT 
  title,
  views,
  upload_date
FROM 
  Videos
ORDER BY 
  views DESC
LIMIT 5;

-- Example 2: Creating a User Activity Timeline
-- TokTuk's analytics team wants to see a chronological history of a user's activity. This creates a timeline of user activity – perfect for a 
-- "Your Activity" page in the TokTuk app, showing the most recent interactions first.
-- Show all interactions for user_id = 3 in reverse chronological order
SELECT 
  i.interaction_type,
  v.title AS video_title,
  i.timestamp,
  i.comment_text
FROM 
  Interactions i
JOIN
  Videos v ON i.video_id = v.video_id
WHERE 
  i.user_id = 3
ORDER BY 
  i.timestamp DESC;

-- Example 3: Grouping and Sorting Interactions by Type
-- The TokTuk community team wants to analyze user engagement patterns. This query groups all likes together and all comments together 
-- (alphabetically, comments first), then orders each group by most recent. It's like organizing your email inbox by category, then by date.
-- First group by interaction_type, then order newest first
SELECT 
  interaction_type,
  video_id,
  user_id,
  timestamp
FROM 
  Interactions
ORDER BY 
  interaction_type ASC,
  timestamp DESC;

-- ORDER BY Best Practices and Tips

-- 1. Use Clear Direction Indicators
-- Even though ASC is the default, explicitly include ASC or DESC for each column in your ORDER BY clause. This improves code readability and 
-- prevents confusion, especially with multiple sort columns.
-- Clear and explicit sorting directions
SELECT username, join_date FROM Users
ORDER BY join_date DESC, username ASC;

-- 2. Consider Performance with Large Datasets
-- Sorting large tables can be resource-intensive. If possible, create indexes on columns you frequently sort by. It's like adding a table of 
-- contents to a book – it makes finding things much faster!

-- Common ORDER BY Mistakes to Avoid
-- Mistake #1: Ordering by a Column Not in the SELECT List
-- Some databases allow you to sort by columns that aren't in your SELECT list, while others require those columns to be included. For maximum 
-- compatibility, include all ORDER BY columns in your SELECT list, especially in database-agnostic code.
-- More compatible across database systems
SELECT title, upload_date, views FROM Videos
ORDER BY views DESC;

-- Might not work in all database systems
SELECT title, upload_date FROM Videos
ORDER BY views DESC;

-- Mistake #2: Forgetting That ORDER BY Executes Last
-- ORDER BY is one of the last clauses to execute in the query pipeline, after SELECT, FROM, WHERE, GROUP BY, and HAVING. This means you can reference aliases created in your SELECT clause:
-- This works because ORDER BY happens after SELECT
SELECT 
  title,
  views / 1000 AS views_thousands
FROM 
  Videos
ORDER BY 
  views_thousands DESC;  -- Using the alias created in SELECT

-- Think of SQL like an assembly line, with each clause processing the data in sequence. By the time ORDER BY runs, those aliases already exist!

-- Mistake #3: Case-Sensitivity Confusion
-- Sorting text data can be tricky because of case sensitivity. For example, in some databases "Z" comes before "a" when sorting. If you want 
-- case-insensitive sorting:
-- Case-insensitive sorting (implementation varies by database)
SELECT username FROM Users
ORDER BY LOWER(username) ASC;

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

-- LIMIT Clause
-- It restricts the number of rows returned, making your queries more efficient and your results more manageable.

-- Basic LIMIT Usage
-- Restrict your result set to the first N rows
-- Get only the first 5 users
SELECT username, email, join_date 
FROM Users
LIMIT 5;

-- LIMIT with OFFSET
-- Skip a certain number of rows before starting to return rows
-- Skip the first 5 videos and return the next 5
SELECT video_id, title, views 
FROM Videos
LIMIT 5 OFFSET 5;
-- Think of OFFSET like skipping a few pages in a book before you start reading. This is perfect for implementing pagination in applications!
-- SQLite requires explicit OFFSET keyword

-- Example 1: Finding the Top Performing Videos
-- Want to see which TokTuk videos are trending? Use LIMIT with ORDER BY
-- Get the top 3 most-viewed videos
SELECT 
  video_id,
  title,
  views
FROM 
  Videos
ORDER BY 
  views DESC
LIMIT 3;

-- Example 2: Implementing Pagination for User Feeds
-- Ever wonder how social media feeds load content as you scroll?
-- Get videos for page 2 (assuming 4 videos per page)
SELECT 
  v.video_id,
  v.title,
  u.username AS creator,
  v.views
FROM 
  Videos v
JOIN
  Users u ON v.user_id = u.user_id
ORDER BY 
  v.upload_date DESC
LIMIT 4 OFFSET 4;  -- Page 2 (items 5-8)

/*
LIMIT Best Practices and Performance Considerations

1. Always Combine with ORDER BY
Without ORDER BY, the database returns rows in an arbitrary order, making LIMIT unpredictable. Always pair LIMIT with ORDER BY for consistent 
results.

2. Be Careful with High OFFSET Values
While LIMIT 10 OFFSET 1000000 is valid SQL, it forces the database to scan and discard the first million rows! For deep pagination, consider using 
"keyset pagination" instead (filtering based on the last seen ID).

3. Use LIMIT During Development and Testing
When writing complex queries, add a LIMIT clause during development to avoid accidentally returning millions of rows. Your development database 
(and your patience) will thank you!
*/

/*
LIMIT vs TOP: Understanding the Differences
While LIMIT is the standard in PostgreSQL, MySQL, and SQLite, the TOP clause is the traditional method in SQL Server environments.
SQL Server TOP syntax

Key Differences
LIMIT is placed at the end of the query, while TOP appears right after SELECT
TOP can use WITH TIES to include rows with identical values in the ordering column
LIMIT is standard in PostgreSQL, MySQL, and SQLite, while TOP is specific to SQL Server
*/
SELECT TOP 10 username, email 
FROM Users;

-- TOP with ties
SELECT TOP 10 WITH TIES username, salary 
FROM Employees 
ORDER BY salary DESC;