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

/*
QUIZ
----

Question 1
----------
True or False: The IN operator in SQL is used to check if a value matches at least one value in a specified list or subquery result. Explain your 
reasoning.

Solution 1
----------
True. The IN operator is designed to see if a value exists within a set of values provided in a list or returned by a subquery. It simplifies the 
process of checking against multiple values.

Question 2
----------
Suppose you want to retrieve all customers located in either 'New York', 'California', or 'Texas'. Write a SQL query using the IN operator to 
achieve this, assuming you have a table named Customers with a column named Location.

Question 3
----------
Imagine you have two tables: Orders and Customers. The Orders table has a CustomerID column, and the Customers table has a CustomerID and a Status 
column. Write a SQL query using the IN operator with a subquery to find all orders placed by customers whose Status is 'VIP'.
*/

-- Solution 2
SELECT *
FROM Customers
WHERE Location IN ('New York', 'California', 'Texas');

-- Solution 3
SELECT *
FROM Orders
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Customers
    WHERE Status = 'VIP'
);