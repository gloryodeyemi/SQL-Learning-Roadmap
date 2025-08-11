/*
SQL CAST Function

The CAST function in SQL allows you to explicitly convert a value from one data type to another. This is essential for ensuring correct calculations, comparisons, and data manipulations in your queries.
*/

-- Common Type Conversions with CAST

-- String to Number Conversions
-- Note: If the string can't be converted to a number (e.g., 'abc'), most databases will raise an error.
-- Convert string to integer
SELECT CAST('123' AS INT);

-- Convert string to decimal
SELECT CAST('123.45' AS DECIMAL(10,2));

-- In a query context - convert string views to integers
SELECT 
  video_id,
  title,
  CAST(views AS INTEGER) AS numeric_views
FROM 
  videos
WHERE 
  CAST(views AS INTEGER) > 1000;

-- Number to String Conversions
-- Converting numbers to strings is useful for concatenation and text operations.
-- Convert number to string
SELECT CAST(123 AS VARCHAR);

-- Format user information with ID
SELECT 
  'User #' || CAST(user_id AS TEXT) AS user_reference,
  username,
  CAST(join_date AS TEXT) AS join_date_string
FROM 
  users;

-- Date and Time Conversions
-- Converting between date/time formats and strings is crucial for working with temporal data.
-- Convert string to date
SELECT CAST('2023-05-15' AS DATE);

-- Convert string to timestamp
SELECT CAST('2023-05-15 14:30:00' AS TIMESTAMP);

-- Convert date to string
SELECT CAST(CURRENT_DATE AS VARCHAR);

-- Extract year from upload dates
SELECT 
  video_id,
  title,
  upload_date,
  CAST(strftime('%Y', upload_date) AS TEXT) AS upload_year
FROM 
  videos;

-- Boolean Conversions
-- Converting to and from boolean values can be useful for conditional logic.
-- Convert numeric to boolean
SELECT CAST(1 AS BOOLEAN);  -- TRUE
SELECT CAST(0 AS BOOLEAN);  -- FALSE

-- Count videos with views higher than average
SELECT 
  COUNT(*) AS total_videos,
  SUM(CAST(views > (SELECT AVG(views) FROM videos) AS INTEGER)) AS above_average_count,
  AVG(CAST(views > (SELECT AVG(views) FROM videos) AS REAL)) AS above_average_percentage
FROM 
  videos;

-- CAST vs. Type-Specific Conversion Functions

-- Database-Specific Type Conversion
-- Different database systems offer their own conversion functions alongside the standard CAST.
-- Standard CAST (works across most databases)
SELECT CAST('123' AS INT);

-- Microsoft SQL Server CONVERT function
SELECT CONVERT(INT, '123');

-- PostgreSQL type notation shorthand
SELECT '123'::INT;

-- MySQL specific conversions
SELECT CONVERT('123', SIGNED);

-- Specialized Conversion Functions
-- Some conversions are better handled by specialized functions than by general CAST.
-- Format dates with specialized functions (PostgreSQL)
SELECT TO_CHAR(current_date, 'Month DD, YYYY');

-- Parse strings to dates with custom formats
SELECT TO_DATE('May 15, 2023', 'Month DD, YYYY');

-- Format numbers with specific currency/decimal formats
SELECT TO_CHAR(12345.67, '$999,999.99');

-- Example: Simple Report with Type Conversions
-- User and video statistics with conversions
SELECT 
  u.user_id,
  u.username,
  COUNT(v.video_id) AS video_count,
  
  -- Format view count for display
  CAST(SUM(v.views) AS TEXT) || ' views' AS total_views,
  
  -- Convert to decimal for average calculation
  CAST(
    AVG(v.views) 
    AS REAL
  ) AS avg_views_per_video,
  
  -- Format join date for display
  CAST(u.join_date AS TEXT) AS join_date_formatted,
  
  -- Days since joining
  CAST(
    julianday('now') - julianday(u.join_date)
    AS INTEGER
  ) AS days_as_member
FROM 
  users u
LEFT JOIN 
  videos v ON u.user_id = v.user_id
GROUP BY 
  u.user_id, u.username, u.join_date
ORDER BY 
  video_count DESC;


/*
QUIZ
----

Question 1
----------
True or False: The CAST function in SQL is used for explicitly converting a value from one data type to another. Explain your reasoning.

Solution 1
----------
True. The CAST function is indeed used for explicit data type conversion in SQL. This is essential for tasks like ensuring correct calculations or comparisons.

Question 2
----------
Why is it generally recommended to use the standard CAST function over database-specific conversion functions when possible? a) CAST is always faster than database-specific functions. b) CAST offers better cross-database compatibility. c) Database-specific functions are harder to use. d) CAST supports more data types than database-specific functions.

Solution 2
----------
b) CAST offers better cross-database compatibility. Using the standard CAST function ensures that your SQL code is more portable and can be easily adapted to different database systems without modification.

Question 3
----------
Let's say you have a column named order_date with a data type of TEXT that stores dates in the format 'YYYY-MM-DD'. Write a SQL query that uses the CAST function to convert the order_date column to the DATE data type and selects only the orders placed in the year 2023.

Solution 3
----------
*/
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM CAST(order_date AS DATE)) = 2023;