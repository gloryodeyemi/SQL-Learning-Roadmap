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
