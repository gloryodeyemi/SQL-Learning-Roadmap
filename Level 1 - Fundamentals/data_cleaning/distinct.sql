-- SQL DISTINCT Keyword
-- The DISTINCT keyword in SQL eliminates duplicate values from your query results, returning only unique values.

-- Single Column DISTINCT
SELECT DISTINCT title
FROM Videos;

-- Multi-Column DISTINCT
-- DISTINCT can be applied to multiple columns, returning unique combinations of values across those columns. This means rows are considered 
-- duplicates only when they have the same values in all specified columns.
SELECT DISTINCT user_id, video_id
FROM Interactions;

-- DISTINCT with COUNT
-- Count unique titles
SELECT COUNT(DISTINCT title) AS unique_titles
FROM Videos;

-- DISTINCT vs. GROUP BY
-- Using DISTINCT
SELECT DISTINCT user_id, video_id
FROM Interactions;

-- Equivalent using GROUP BY
SELECT user_id, video_id
FROM Interactions
GROUP BY user_id, video_id;

-- Count distinct users per video
SELECT 
  video_id, 
  COUNT(DISTINCT user_id) AS viewer_count
FROM 
  Interactions
GROUP BY 
  video_id
ORDER BY 
  viewer_count DESC;

-- QUIZ

-- 1. True or False: The DISTINCT keyword in SQL is used to eliminate duplicate values from your query results. Explain your reasoning.
-- The DISTINCT keyword does indeed eliminate duplicate values, ensuring that only unique entries are returned in the result set.

-- 2. Imagine you have a table named products with a column named category. Write a SQL query that returns a list of all unique categories in the 
-- products table.
SELECT DISTINCT category
FROM products;

-- 3. You have a table named sales with columns product_id, customer_id, and sale_date. You want to find out how many unique customers purchased  
-- each product. How would you use DISTINCT in combination with COUNT and GROUP BY to achieve this? Explain your approach.
SELECT product_id, COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY product_id;