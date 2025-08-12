/*
SQL SUM Function

The SUM function is a fundamental SQL aggregate function used for calculating the total sum of values in a specified numeric column. It's essential for financial reporting, performance analysis, inventory tracking, and any scenario where you need to aggregate quantitative data.
*/

-- SUM Function Basics

-- Simple Total Calculation
-- At its core, SUM adds all non-NULL values in the specified column for the rows selected by the query.
-- Calculate the total views across all videos
SELECT SUM(views) AS total_platform_views
FROM videos;

-- SUM with Conditions (WHERE Clause)
-- Use the WHERE clause to filter rows before applying the SUM function, allowing you to calculate totals for specific subsets of your data.
-- Calculate total views just for videos uploaded by user_id 5
SELECT SUM(views) AS user_5_total_views
FROM videos
WHERE user_id = 5;

-- SUM and NULL Value Handling
-- Crucially, the SUM function ignores NULL values. It sums only the non-NULL numeric values it encounters. If all values in the column for the selected rows are NULL, SUM typically returns NULL (or sometimes 0, depending on the database system and context, though NULL is standard SQL behavior).
-- To treat NULLs as 0 in a sum, you often need to use a function like COALESCE or IFNULL. For example: SUM(COALESCE(bonus_points, 0)).
-- Example: If 'bonus_points' can be NULL
SELECT SUM(views) AS total_views
FROM videos;
-- This only sums rows where views is not NULL.

-- Using SUM with GROUP BY
-- The real analytical power of SUM emerges when combined with the GROUP BY clause. This allows you to calculate subtotals for different categories or groups within your data.

-- Calculating Subtotals by Group
-- Calculate total views per user (creator)
SELECT
  user_id,
  SUM(views) AS total_views_per_user
FROM videos
GROUP BY user_id
ORDER BY total_views_per_user DESC;

-- Combining with Joins for Richer Grouping
-- Join tables to group by descriptive names rather than just IDs
-- Calculate total views by username
SELECT
  u.username,
  SUM(COALESCE(v.views, 0)) AS total_views
FROM users u
LEFT JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
ORDER BY total_views DESC;

-- Filtering Groups Based on SUM (HAVING Clause)
-- Use the HAVING clause to filter the results based on the calculated sum for each group. The HAVING clause acts after the grouping and summation, allowing us to select only the high-performing user groups based on their total views.
-- Find users whose videos have collectively received more than 10,000 views
SELECT
  u.username,
  SUM(v.views) AS total_views
FROM users u
JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
HAVING SUM(v.views) > 10000
ORDER BY total_views DESC;

-- Advanced SUM Techniques

-- Multiple Aggregations (SUM, COUNT, AVG)
-- Combine SUM with other aggregate functions like COUNT and AVG for more comprehensive summaries.
-- User content performance summary
SELECT
  u.username,
  COUNT(v.video_id) AS number_of_videos,
  SUM(v.views) AS total_views_generated,
  AVG(v.views) AS average_views_per_video,
  MAX(v.views) AS highest_view_count
FROM users u
LEFT JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
ORDER BY total_views_generated DESC;

-- SUM with Expressions
-- You can apply SUM to expressions involving columns, not just single columns.
-- Example: Calculate total potential revenue (views * estimated_ad_rate)
-- Assuming an 'estimated_ad_rate' column or variable exists
SELECT
  user_id,
  SUM(views * 0.001) AS estimated_revenue
FROM videos
GROUP BY user_id;


/*
QUIZ
----

Question 1
----------
True or False: The SUM function in SQL can be used to add values in columns containing text data. Explain your reasoning.

Solution 1
----------
The SUM function in SQL is designed to operate on numeric data types (like INTEGER, REAL, DECIMAL, FLOAT, etc.). Attempting to use it on non-numeric types like strings will indeed result in an error.

Question 2
----------
Fill in the blank.
The SUM function ignores _____ values. If all values in a column are _____, the SUM function will return _____.

Solution 2
----------
The SUM function ignores NULL values. If all values in a column are NULL, the SUM function will return NULL (or sometimes 0, depending on the database system and context, though NULL is standard SQL behavior).

Question 3
----------
Write a SQL query that calculates the total price from the products table, but only for products where the category is 'Electronics'.

Solution 3
----------
*/
SELECT SUM(price) AS total_price
FROM products
WHERE category = 'Electronics';