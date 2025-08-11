-- SQL AND Operator
-- The AND operator in SQL is used to combine multiple conditions in a WHERE clause or HAVING clause. For a row to be included in the results, 
-- all conditions joined by AND must evaluate to TRUE.

-- Basic AND Usage
-- Find videos with high views from a specific user
SELECT * FROM Videos 
WHERE views > 1000 AND user_id = 1;

-- Find recent videos with more than 100 views
SELECT * FROM Videos 
WHERE upload_date >= '2023-01-01' AND views > 100;

-- Find users who joined recently with specific usernames
SELECT * FROM Users 
WHERE join_date >= '2023-01-01' AND username LIKE 'admin%';

-- Combining Multiple AND Conditions
-- Find very specific videos matching multiple criteria
SELECT * FROM Videos 
WHERE views > 1000 
  AND user_id = 1 
  AND upload_date >= '2023-01-01' 
  AND title LIKE '%tutorial%';

-- Find users with specific characteristics
SELECT * FROM Users 
WHERE username LIKE 'a%' 
  AND email LIKE '%.com' 
  AND join_date >= '2023-01-01';

-- Example showing NULL behavior
SELECT * FROM Users
WHERE username IS NOT NULL AND join_date > '2023-01-01';

-- Users with NULL join_date will be excluded from results
-- even though it is unknown if they joined after 2023-01-01

-- AND with Other Logical Operators
-- Order of Operations: AND and OR
-- Without parentheses - AND is evaluated first
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' OR title LIKE '%guide%' AND views > 1000;

-- Equivalent to:
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' OR (title LIKE '%guide%' AND views > 1000);

-- Combining AND with OR Using Parentheses
-- Find videos that are either tutorials with high views OR guides with medium views
SELECT * FROM Videos 
WHERE (title LIKE '%tutorial%' AND views > 1000) 
   OR (title LIKE '%guide%' AND views > 500);

-- Find users who are either admins who joined recently OR any user who joined before 2022
SELECT * FROM Users 
WHERE (username LIKE 'admin%' AND join_date >= '2023-01-01') 
   OR (join_date < '2022-01-01');

-- Combining AND with NOT
-- Find videos with high views that do not contain 'tutorial' in the title
SELECT * FROM Videos 
WHERE views > 1000 AND NOT title LIKE '%tutorial%';

-- Equivalent to:
SELECT * FROM Videos 
WHERE views > 1000 AND title NOT LIKE '%tutorial%';

-- Find users with gmail accounts who joined recently
SELECT * FROM Users 
WHERE email LIKE '%gmail.com' AND NOT join_date < '2023-01-01';

-- Practical SQL AND Examples
-- Example 1: Filtering Videos by Multiple Criteria
-- Find popular recent videos about tutorials
SELECT 
  video_id,
  title,
  views,
  upload_date,
  user_id
FROM 
  Videos
WHERE 
  title LIKE '%tutorial%'
  AND views > 1000
  AND upload_date >= '2023-01-01'
ORDER BY 
  views DESC;

-- Example 2: Advanced User Filtering
-- Find users with specific email patterns who joined recently
SELECT 
  user_id,
  username,
  email,
  join_date
FROM 
  Users
WHERE 
  email LIKE '%.com'
  AND email NOT LIKE '%test%'
  AND username LIKE 'user%'
  AND join_date >= '2023-06-01'
ORDER BY 
  join_date DESC;

-- Example 3: Complex Filtering with AND and OR
-- Find videos matching complex criteria
SELECT 
  video_id,
  title,
  views,
  user_id,
  upload_date
FROM 
  Videos
WHERE 
  (
    (title LIKE '%tutorial%' AND views > 10000)
    OR 
    (title LIKE '%game%' AND views > 50000)
  )
  AND 
  upload_date >= '2023-01-01'
  AND
  user_id IN (SELECT user_id FROM Users WHERE username LIKE 'creator%')
ORDER BY 
  views DESC;

-- QUIZ
-- 1. True or False: The SQL AND operator requires all conditions to be TRUE for a row to be included in the result. Explain your reasoning.
-- The AND operator acts as a filter, ensuring that only rows satisfying all specified conditions are included in the result set. If even one 
-- condition is FALSE, the entire expression evaluates to FALSE, and the row is excluded.

-- 2. Imagine you have a table named products with columns price and in_stock. Write a SQL snippet that selects all products that cost more than 
-- 20 dollars and are in stock.
SELECT *
FROM products
WHERE price > 20 AND in_stock = TRUE;

-- 3. How does the AND operator handle NULL values in SQL? Explain what happens when you combine TRUE AND NULL and FALSE AND NULL.
-- When the AND operator encounters a TRUE and NULL, the result is NULL and when it encounters FALSE and NULL, the result is FALSE. Only rows 
-- that are TRUE are returned.
