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
-- 