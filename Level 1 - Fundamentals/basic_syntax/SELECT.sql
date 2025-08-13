-- SQL SELECT Statement
-- It retrieves specific columns of data from one or more tables in a database.

-- Example 1: Retrieve interaction information from the Interactions table
SELECT 
    interaction_id,
    user_id,
    video_id,
    interaction_type,
    timestamp
FROM 
    Interactions;

-- Example 2: Retrieve video information from the Videos table
SELECT 
    video_id,
    title AS "Video Title",
    views AS "View Count",
    upload_date AS "Published On"
FROM 
    Videos;

-- QUIZ
-- 1. True or False: Using SELECT * in production code is generally a good practice because it ensures you retrieve all possible data from a table. 
-- Explain why.

-- 2. Write a SQL query to select only the video_title and upload_date columns from a table named Videos.
SELECT video_title, upload_date
FROM videos;

-- 3. You want to retrieve a list of unique customer IDs from a table named Orders. How would you write the SQL query to accomplish this, and why 
-- is it important to retrieve distinct values?
SELECT DISTINCT customer_id
FROM Orders;