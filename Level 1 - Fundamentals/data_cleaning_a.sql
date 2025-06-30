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