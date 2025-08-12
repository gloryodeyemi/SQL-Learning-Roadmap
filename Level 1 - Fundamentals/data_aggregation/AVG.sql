/*
SQL AVG Function

The AVG function is a core SQL aggregate function used to calculate the average (arithmetic mean) value of a set of numbers. It sums the values in a specified numeric column and divides by the count of non-NULL values, providing a crucial measure of central tendency for your data.
*/

-- AVG Function Basics

-- Simple Average Calculation
-- AVG calculates the mean by summing the non-NULL values in the column and dividing by the count of those non-NULL values.
-- Calculate the average view count across all videos
SELECT AVG(views) AS average_platform_views
FROM videos;

-- AVG and NULL Value Handling
-- This is a critical point: AVG ignores NULL values entirely. It does not treat them as zero or include them in the count when calculating the average.
SELECT
  SUM(views) AS total_sum,
  COUNT(views) AS non_null_count,
  AVG(views) AS average_val
FROM videos;

-- Formatting AVG Results (ROUND)
-- Since AVG often produces results with decimal places (even when averaging integers, depending on the database), using ROUND, CAST, or specific formatting functions is common for presentation.
-- Calculate average views, rounded to the nearest whole number
SELECT ROUND(AVG(views)) AS rounded_average_views
FROM videos;

-- Calculate average views, formatted to 2 decimal places
SELECT ROUND(AVG(views), 2) AS formatted_average_views
FROM videos;

-- Using AVG with GROUP BY

-- Calculating Averages per Category
-- Calculate the average view count per user
SELECT
  user_id,
  AVG(views) AS average_views_per_user
FROM videos
GROUP BY user_id
ORDER BY average_views_per_user DESC;

-- Combining AVG with Other Aggregates
-- Show username, video count, and average views per user
SELECT
  u.username,
  COUNT(v.video_id) AS number_of_videos,
  AVG(COALESCE(v.views, 0)) AS average_views
FROM users u
LEFT JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
ORDER BY average_views DESC;

-- Filtering Groups Based on AVG (HAVING Clause)
-- Use the HAVING clause to select only those groups whose average meets a certain criterion.
-- Find users whose average video views exceed 5000
SELECT
  u.username,
  AVG(v.views) AS average_views
FROM users u
JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
HAVING AVG(v.views) > 5000
ORDER BY average_views DESC;

/*
QUIZ
----

Question 1
----------
True or False: The AVG function in SQL calculates the average of all values in a column, including NULL values. Explain your reasoning.

Solution 1
----------
False. AVG ignores NULL values entirely. It sums the non-NULL values and divides by the count of the non-NULL values.

Question 2
----------
Imagine you have a table named products with a column named price. Write a SQL query to calculate the average price of all products in the table.

Question 3
----------
Suppose you have a table named sales with columns region and revenue. Write a SQL query that calculates the average revenue for each region. Also, only include regions where the average revenue is greater than 50000.
*/

-- Solution 2
SELECT AVG(price) AS avg_price
FROM products;

-- Solution 3
SELECT 
    region,
    AVG(revenue) AS avg_revenue
FROM sales
GROUP BY region
    HAVING AVG(revenue) > 50000;