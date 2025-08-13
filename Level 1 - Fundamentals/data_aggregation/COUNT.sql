/*
SQL COUNT Function

It does exactly what its name suggests: it counts things. Whether you need to count the total number of users, the number of videos per creator, the quantity of non-null entries in a column, or the variety of interaction types in your database, COUNT is your go-to tool.
*/

-- SQL COUNT Variations Explained

-- 1. COUNT(*) - Counting All Rows
-- This is the most common form. COUNT(*) counts all rows returned by the query, including rows with NULL values in some or all columns and duplicate rows. It simply counts the number of rows in the result set defined by the FROM and WHERE clauses.
-- Count the total number of interaction records
SELECT COUNT(*) AS total_interactions
FROM interactions;

-- 2. COUNT(column_name) - Counting Non-NULL Values
-- When you specify a column name inside COUNT(), it counts the number of rows where the specified column_name is not NULL. It ignores rows where that particular column has a NULL value.
-- Count how many interactions include actual comment text
-- (Assuming comment_text is NULL for likes/shares)
SELECT COUNT(comment_text) AS number_of_comments
FROM interactions;

-- 3. COUNT(DISTINCT column_name) - Counting Unique Non-NULL Values
-- To count the number of unique, non-NULL values within a specific column, use the DISTINCT keyword before the column name.
-- Count how many unique users have uploaded videos
SELECT COUNT(DISTINCT user_id) AS distinct_uploaders
FROM videos;

-- 4. COUNT(1) or COUNT(constant) - Counting All Rows (Alternative)
-- COUNT(1) (or COUNT(0), COUNT('any_constant')) behaves identically to COUNT(*). It counts every row returned by the query because the constant expression 1 is never NULL.
-- Count all videos in the platform using COUNT(1)
SELECT COUNT(1) AS total_videos
FROM videos;

-- Conditional Counting (CASE within COUNT)
-- Use CASE expressions inside COUNT to count based on conditions within the same aggregation scope. This is powerful for pivoting or creating summary statistics.
-- Count different interaction types in a single pass
SELECT
  COUNT(*) AS total_interactions,
  COUNT(CASE WHEN interaction_type = 'like'    THEN 1 ELSE NULL END) AS like_count,
  COUNT(CASE WHEN interaction_type = 'comment' THEN 1 ELSE NULL END) AS comment_count,
  COUNT(CASE WHEN interaction_type = 'share'   THEN 1 ELSE NULL END) AS share_count
FROM Interactions;

-- Counting with Conditions (WHERE Clause)
-- Use the WHERE clause to apply conditions before counting
-- Count videos uploaded in 2023 with more than 1000 views
SELECT COUNT(*) AS popular_2023_videos
FROM Videos
WHERE views > 1000
  AND SUBSTR(upload_date, 1, 4) = '2023'; -- Assuming YYYY-MM-DD format
-- The CASE statement returns 1 (a non-NULL value) when the condition is met, and NULL otherwise. COUNT(expression) only counts the non-NULL results, giving us separate counts for each type.

