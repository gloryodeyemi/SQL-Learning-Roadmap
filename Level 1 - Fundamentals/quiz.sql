-- Quiz
-- 1. True or False: Using SELECT * in production code is generally a good practice because it ensures you retrieve all possible data from a table. 
-- Explain why.

-- Write a SQL query to select only the video_title and upload_date columns from a table named Videos.
SELECT video_title, upload_date
FROM videos;

-- You want to retrieve a list of unique customer IDs from a table named Orders. How would you write the SQL query to accomplish this, and why is 
-- it important to retrieve distinct values?
SELECT DISTINCT customer_id
FROM Orders