/*
SQL BETWEEN Operator

The BETWEEN operator in SQL is used to filter data within a specified range. It tests whether a value falls within an inclusive range defined by 
a minimum and maximum value, making it perfect for filtering numbers, dates, and even strings.
*/

-- BETWEEN with Numbers
-- Find videos with views between 1000 and 5000
SELECT * FROM Videos 
WHERE views BETWEEN 1000 AND 5000;

-- Equivalent to
SELECT * FROM Videos 
WHERE views >= 1000 AND views <= 5000;

-- Find videos with numeric IDs in a specific range
SELECT * FROM Videos 
WHERE video_id BETWEEN 100 AND 200;

-- BETWEEN with Dates
-- Find videos uploaded in January 2023
SELECT * FROM Videos 
WHERE upload_date BETWEEN '2023-01-01' AND '2023-01-31';

-- Find users who joined in the first quarter
SELECT * FROM Users 
WHERE join_date BETWEEN '2023-01-01' AND '2023-03-31';

-- Find recent content
SELECT * FROM Videos 
WHERE upload_date BETWEEN '2023-01-01' AND '2023-12-31';

-- BETWEEN with Strings
-- Find usernames starting with A through M
SELECT * FROM Users 
WHERE username BETWEEN 'A' AND 'N';

-- Find products in categories alphabetically between Electronics and Media
SELECT * FROM Products 
WHERE category BETWEEN 'Electronics' AND 'Media';

-- NOT BETWEEN for Exclusion
-- Find videos outside the 1000-5000 view range
SELECT * FROM Videos 
WHERE views NOT BETWEEN 1000 AND 5000;

-- Equivalent to
SELECT * FROM Videos 
WHERE views < 1000 OR views > 5000;

-- Find events outside normal business hours
SELECT * FROM Events 
WHERE event_time NOT BETWEEN '09:00:00' AND '17:00:00';

-- Edge Cases and Considerations

-- NULL Values
-- BETWEEN does not match NULL values. If a column contains NULL, it won't be included in the results even if it would logically fall within the 
-- range.
-- These rows won't be included in BETWEEN results
SELECT * FROM Videos WHERE upload_date IS NULL;

-- To include NULLs along with a range, use OR
SELECT * FROM Videos 
WHERE upload_date BETWEEN '2023-01-01' AND '2023-12-31'
   OR upload_date IS NULL;

-- Value Order Matters
-- The first value in a BETWEEN condition must be less than or equal to the second value, or no rows will be returned.
-- This will return no rows because the range is inverted
SELECT * FROM Videos 
WHERE views BETWEEN 5000 AND 1000;

-- Correct order
SELECT * FROM Videos 
WHERE views BETWEEN 1000 AND 5000;

-- Data Type Considerations
-- Both values in a BETWEEN condition should be of the same data type as the column being compared, or implicit conversion will occur which might 
-- lead to unexpected results.

-- Performance
-- BETWEEN is typically optimized by databases and can use indexes effectively, similar to using >= and <= conditions.


/*
QUIZ
----

Question 1
----------
True or False: The SQL BETWEEN operator includes both the start and end values in its range. Explain your reasoning.

Solution 1
----------
True. The BETWEEN operator is inclusive except while using it in string because it compares full string.

Question 2
----------
Fill in the blank:
The BETWEEN operator is especially useful for filtering data within ____ ranges.

Solution 2
----------
The BETWEEN operator is especially useful for filtering data within specified ranges. This encompasses numbers, dates, and even strings!

Question 3
----------
Write a SQL query to select all products from a table named products where the price is between 50 and 100 (inclusive). The price column is 
named price.

Solution 3
----------
*/
SELECT *
FROM products
WHERE price BETWEEN 50 AND 100;