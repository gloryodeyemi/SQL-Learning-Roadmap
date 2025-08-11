/*
SQL IN Operator

The IN operator in SQL allows you to check if a value matches any value in a specified list or subquery result. It provides a concise way to test 
against multiple values without using multiple OR conditions.
*/

-- IN with a Value List
-- Find videos with specific user IDs
SELECT * FROM Videos 
WHERE user_id IN (1, 2, 3, 10);

-- Find users with specific usernames
SELECT * FROM Users 
WHERE username IN ('admin', 'moderator', 'editor', 'contributor');

-- Find interactions with specific video IDs
SELECT * FROM Interactions 
WHERE video_id IN (1001, 1002, 1010, 1054);

-- IN vs. Multiple OR Conditions
-- Using IN operator
SELECT * FROM Videos 
WHERE user_id IN (1, 2, 3);

-- Equivalent using OR
SELECT * FROM Videos 
WHERE user_id = 1 
   OR user_id = 2 
   OR user_id = 3;

-- IN with Subqueries
-- Find videos from users who joined recently
SELECT * FROM Videos 
WHERE user_id IN (
  SELECT user_id 
  FROM Users 
  WHERE join_date >= '2023-01-01'
);

-- Find interactions on popular videos
SELECT * FROM Interactions 
WHERE video_id IN (
  SELECT video_id 
  FROM Videos 
  WHERE views > 10000
);

-- NOT IN for Exclusion
-- Find videos NOT made by certain users
SELECT * FROM Videos 
WHERE user_id NOT IN (1, 2, 3);

-- Find users not with specific usernames
SELECT * FROM Users 
WHERE username NOT IN ('test', 'demo', 'temp');

-- Find interactions not related to specific videos
SELECT * FROM Interactions 
WHERE video_id NOT IN (
  SELECT video_id 
  FROM Videos 
  WHERE title LIKE '%spam%'
);

-- Multi-Column IN with Row Constructors
-- In some database systems, you can use row constructors with IN for multi-column comparisons:
-- Note: This syntax is supported in PostgreSQL, MySQL, and some other database systems, but not all.
-- Find specific user/video combinations
SELECT 
  interaction_id,
  user_id,
  video_id,
  interaction_type,
  timestamp
FROM 
  Interactions
WHERE 
  (user_id, video_id) IN (
    (1, 100),
    (2, 101),
    (3, 102),
    (4, 103)
  )
ORDER BY 
  timestamp DESC;

-- Using IN with Dynamic Values
-- Pseudo-code for a parameterized query with IN
SELECT * FROM Videos 
WHERE category IN (
  -- This list would be dynamically generated in application code
  :selectedCategories
);