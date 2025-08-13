/*
SQL GROUP BY Clause

The GROUP BY clause is a fundamental part of SQL used to group rows that have the same values in one or more specified columns into a summary row. Think of it as creating categories or buckets based on shared characteristics.
*/

-- GROUP BY Fundamentals

-- Simple Grouping and Aggregation
-- Group rows based on a single column and apply an aggregate function.
-- Count the number of videos created by each user
SELECT
  user_id, -- Column we are grouping by
  COUNT(*) AS number_of_videos -- Aggregate function applied to each group
FROM Videos
GROUP BY user_id; -- Group rows with the same user_id together

-- Including Descriptive Columns
-- To show descriptive information alongside aggregated values, join tables and include the necessary columns in both SELECT and GROUP BY.
-- Count videos per user, showing username
SELECT
  u.user_id, -- Grouping column (often PK)
  u.username, -- Non-aggregated column, must be in GROUP BY
  COUNT(v.video_id) AS number_of_videos -- Aggregate function
FROM Users u
LEFT JOIN Videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username -- Include all non-aggregated selected columns
ORDER BY number_of_videos DESC;

-- Grouping by Expressions
-- You can group by the result of an expression or function applied to a column.
-- Count users by the year they joined
SELECT
  STRFTIME('%Y', join_date) AS join_year, -- Extract year (syntax varies by DB)
  COUNT(*) AS users_joined
FROM Users
WHERE join_date IS NOT NULL
GROUP BY join_year -- Group by the derived year value
ORDER BY join_year;

-- Grouping by Multiple Columns
-- Grouping by more than one column creates groups based on the unique combination of values across all specified grouping columns.

-- Creating Finer-Grained Groups
-- Each unique combination of the grouping columns forms a distinct group.
-- Count interactions of each type ('like', 'comment') per video
SELECT
  video_id,         -- Grouping column 1
  interaction_type, -- Grouping column 2
  COUNT(*) AS count_per_type
FROM Interactions
GROUP BY video_id, interaction_type -- Group by the combination
ORDER BY video_id, interaction_type;

-- Multi-Column Grouping with Joins
-- Combine joins with multi-column grouping for detailed categorical summaries.
-- Calculate average views per user per month of upload
SELECT
  v.user_id,
  u.username,
  STRFTIME('%Y-%m', v.upload_date) AS upload_month, -- Grouping expression
  COUNT(v.video_id) AS videos_in_month,
  AVG(v.views) AS avg_views_in_month
FROM Videos v
JOIN Users u ON v.user_id = u.user_id
WHERE v.upload_date IS NOT NULL
GROUP BY v.user_id, u.username, upload_month -- Group by user AND month
ORDER BY v.user_id, upload_month;

-- How GROUP BY Handles NULL Values

-- NULL Values Form Their Own Group
-- In SQL, NULL represents an unknown or missing value. When grouping, all NULL values are considered equal to each other and are placed into a single group.
-- Example with NULL values in the interaction_type column
SELECT
  interaction_type,
  COUNT(*) AS interaction_count
FROM Interactions
GROUP BY interaction_type
ORDER BY interaction_type;

-- Handling NULL Values in GROUP BY
-- Replace NULL interaction types with 'Unknown' for more readable output
SELECT
  COALESCE(interaction_type, 'Unknown') AS interaction_category,
  COUNT(*) AS interaction_count
FROM Interactions
GROUP BY COALESCE(interaction_type, 'Unknown')
ORDER BY 
  CASE WHEN interaction_category = 'Unknown' THEN 1 ELSE 0 END,
  interaction_category;

-- Filtering Groups with HAVING
-- The HAVING clause is specifically designed to filter results *after* the GROUP BY clause has been applied and aggregate functions have been calculated. It filters based on the aggregated values.

-- Filtering Based on Aggregate Results
-- Find users who have uploaded more than 3 videos
SELECT
  user_id,
  COUNT(*) AS number_of_videos
FROM Videos
GROUP BY user_id
HAVING COUNT(*) > 3 -- Filter based on the result of COUNT()
ORDER BY number_of_videos DESC;

/*
QUIZ
----

Question 1
----------
True or False: The GROUP BY clause is used to group rows that have the same values in one or more columns into a summary row. Explain your reasoning.

Solution 1
----------
True. The GROUP BY clause does indeed group rows with the same values in specified columns into a summary row, which is often used to create categories.

Question 2
----------
Imagine you have a table named orders with columns customer_id and order_date. Write a SQL query that uses GROUP BY to find the number of orders placed by each customer.

Question 3
----------
In a SQL query that includes WHERE, GROUP BY, and HAVING clauses, what is the order in which these clauses are processed?

Solution 3
----------
FROM -> WHERE -> GROUP BY -> Aggregation -> HAVING
*/

-- Solution 2
SELECT 
    customer_id,
    COUNT(order_date)
FROM orders
GROUP BY customer_id;