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

-- FROM Clause
-- The FROM clause is a fundamental component of SQL SELECT statements that specifies which table(s) to retrieve data from. It defines the source 
-- of the data for your query.

-- Query data from the Users table
SELECT user_id, username, email 
FROM Users;

-- Using a table alias
SELECT u.user_id, u.username, u.email 
FROM Users AS u;

-- Simple join between Users and Videos
SELECT u.username, v.title 
FROM Users u
JOIN Videos v ON u.user_id = v.user_id;

-- WHERE Clause
-- The WHERE clause is used in SQL to filter the results returned by a query. It allows you to specify conditions that rows must satisfy to be 
-- included in the result set.

-- Basic SQL Comparison Operators
-- compare values in WHERE clauses.
-- Equal to
SELECT * FROM Videos WHERE user_id = 1;

-- Not equal to
SELECT * FROM Videos WHERE views != 1000;

-- Alternative syntax
SELECT * FROM Videos WHERE views <> 1000;

-- Greater than
SELECT * FROM Videos WHERE views > 1000;

-- Less than
SELECT * FROM Videos WHERE views < 1000;

-- Greater than or equal to
SELECT * FROM Videos WHERE views >= 1000;

-- Less than or equal to
SELECT * FROM Videos WHERE views <= 1000;

-- SQL Logical Operators
-- Combine multiple conditions using logical operators.
-- AND: Both conditions must be true
SELECT * FROM Videos 
WHERE views > 1000 AND user_id = 1;

-- OR: At least one condition must be true
SELECT * FROM Videos 
WHERE title LIKE '%Cat%' OR title LIKE '%Dog%';

-- NOT: Negates a condition
SELECT * FROM Users 
WHERE NOT username = 'alice';

-- Combining operators with parentheses
SELECT * FROM Videos 
WHERE (title LIKE '%Challenge%' OR title LIKE '%Tutorial%') 
      AND views > 500;

-- SQL BETWEEN Operator
-- Test if a value falls within a range (inclusive).
-- Find videos with views between 500 and 1000
SELECT * FROM Videos 
WHERE views BETWEEN 500 AND 1000;

-- Equivalent to
SELECT * FROM Videos 
WHERE views >= 500 AND views <= 1000;

-- Can also be used with dates
SELECT * FROM Videos 
WHERE upload_date BETWEEN '2023-02-01' AND '2023-02-10';

-- SQL IN Operator
-- Test if a value matches any value in a list.
-- Find users with specific IDs
SELECT * FROM Users 
WHERE user_id IN (1, 2, 3);

-- Equivalent to
SELECT * FROM Users 
WHERE user_id = 1 
   OR user_id = 2 
   OR user_id = 3;

-- Can also use subqueries with IN
SELECT * FROM Videos 
WHERE user_id IN (
  SELECT user_id 
  FROM Users 
  WHERE join_date >= '2023-01-05'
);

-- SQL LIKE Operator for Pattern Matching
-- Used for pattern matching with wildcards.

-- % wildcard: matches any sequence of characters
SELECT * FROM Videos 
WHERE title LIKE 'Funny%';  -- Titles starting with "Funny"

SELECT * FROM Videos 
WHERE title LIKE '%Tutorial%';  -- Titles containing "Tutorial"

-- _ wildcard: matches any single character
SELECT * FROM Users 
WHERE username LIKE '_lice';  -- Usernames like "alice" (with first letter variable)

-- SQL NULL Value Handling
-- Test for NULL values (absence of data).

-- Find interactions with no comment text
SELECT * FROM Interactions 
WHERE comment_text IS NULL;

-- Find interactions with comments
SELECT * FROM Interactions 
WHERE comment_text IS NOT NULL;

-- Note: You cannot use the = operator with NULL values. Always use IS NULL or IS NOT NULL.

-- Example 1: Filtering Videos by Views and Upload Date
-- Find popular videos uploaded in the last month
SELECT 
    video_id,
    title,
    views,
    upload_date
FROM 
    Videos
WHERE 
    views > 1000
    AND upload_date >= '2024-02-01'
ORDER BY 
    views DESC;

-- Example 2: Complex Filtering with Multiple Conditions
-- Find specific types of videos based on multiple criteria
SELECT 
  video_id,
  title,
  views,
  upload_date
FROM 
  Videos
WHERE 
  views >= 500
  AND (title LIKE '%Tutorial%' OR title LIKE '%Guide%')
  AND upload_date >= '2023-01-01'
  AND user_id IN (1, 2, 3)
ORDER BY 
  views DESC;

-- Good: Clear precedence with parentheses
SELECT * FROM Videos 
WHERE views > 1000 
  AND (category = 'Tutorial' OR category = 'Guide');

-- Bad: Unclear precedence can lead to unexpected results
SELECT * FROM Videos 
WHERE views > 1000 
  AND category = 'Tutorial' OR category = 'Guide';