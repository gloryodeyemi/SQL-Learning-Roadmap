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

-- SQL OR Operator
-- The OR operator in SQL is used to combine multiple conditions in a WHERE clause or HAVING clause. For a row to be included in the results, at 
-- least one of the conditions joined by OR must evaluate to TRUE.

-- Basic OR Usage
-- Find videos with titles containing either 'tutorial' or 'guide'
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' OR title LIKE '%guide%';

-- Find videos with high views or recent uploads
SELECT * FROM Videos 
WHERE views > 10000 OR upload_date >= '2023-01-01';

-- Find users with specific email providers
SELECT * FROM Users 
WHERE email LIKE '%gmail.com' OR email LIKE '%yahoo.com' OR email LIKE '%hotmail.com';

-- Combining Multiple OR Conditions
-- Find videos matching any of several criteria
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' 
   OR views > 10000 
   OR upload_date >= '2023-01-01' 
   OR title LIKE '%viral%';

-- Find users who meet any qualifying condition
SELECT * FROM Users 
WHERE username LIKE 'admin%' 
   OR email LIKE '%vip%' 
   OR user_id < 100 
   OR join_date < '2022-01-01';

-- OR with Other Logical Operators
-- Order of Operations: OR and AND
-- Without parentheses - AND is evaluated first
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' OR title LIKE '%guide%' AND views > 1000;

-- Equivalent to:
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' OR (title LIKE '%guide%' AND views > 1000);

-- Use parentheses to explicitly control the order of evaluation when combining OR and AND.
-- Find tutorials OR guides, but only with high views
SELECT * FROM Videos 
WHERE (title LIKE '%tutorial%' OR title LIKE '%guide%') 
  AND views > 1000;

-- Different from:
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%' 
   OR (title LIKE '%guide%' AND views > 1000);

-- Combining OR with NOT
-- Use NOT with OR to create complex filtering conditions.
-- Find videos that don't have 'tutorial' in the title OR have high views
SELECT * FROM Videos 
WHERE NOT title LIKE '%tutorial%' OR views > 10000;

-- Find users with specific conditions
SELECT * FROM Users 
WHERE NOT username LIKE 'test%' OR email LIKE '%admin%';
-- Tip: When using NOT with OR, remember that NOT (A OR B) is equivalent to (NOT A) AND (NOT B) - this is De Morgan's Law.

-- Practical SQL OR Examples
-- Example 1: Multi-Keyword Content Search
-- Find videos matching different keyword patterns
SELECT 
  video_id,
  title,
  user_id,
  views,
  upload_date
FROM 
  Videos
WHERE 
  title LIKE '%tutorial%' 
  OR title LIKE '%guide%' 
  OR title LIKE '%how to%'
ORDER BY 
  views DESC;
-- Optimization Tip: For searching across many values in the same column, consider using the IN operator instead of multiple OR conditions. 
-- Example: WHERE title IN ("tutorial", "guide", "how to")

-- Example 2: Flexible Content Discovery
-- Find popular videos using various metrics
SELECT 
  video_id,
  title,
  views,
  user_id,
  upload_date
FROM 
  Videos
WHERE 
  views > 10000 
  OR title LIKE '%viral%' 
  OR upload_date >= '2023-07-01'
ORDER BY 
  views DESC;

-- Example 3: Complex Filtering with OR and AND
-- Find content matching specific pattern with proper parentheses
SELECT 
  video_id,
  title,
  user_id,
  upload_date,
  views
FROM 
  Videos
WHERE 
  (
    title LIKE '%tutorial%' 
    OR title LIKE '%education%'
  )
  AND 
  (
    views < 1000 
    OR views > 50000
  )
  AND 
  upload_date >= '2023-01-01'
ORDER BY 
  views DESC;
-- Translation: This query finds videos that are: (1) either about tutorials OR education, AND (2) either have few views (< 1000) OR are very 
-- popular (> 50000 views), AND (3) uploaded this year.

-- OR vs. IN Operator
-- When checking a column against multiple possible values, you can use either OR or the IN operator. The IN operator is generally more concise 
-- and often performs better.

-- SQL NOT Operator
-- The NOT operator in SQL is used to negate a condition in a WHERE clause or HAVING clause. It reverses the result of the condition that follows 
-- it, making TRUE conditions FALSE and FALSE conditions TRUE.
-- Find videos that don't have 'tutorial' in the title
SELECT * FROM Videos 
WHERE NOT title LIKE '%tutorial%';

-- Find users with non-gmail emails
SELECT * FROM Users 
WHERE NOT email LIKE '%gmail.com';

-- Find videos not uploaded this year
SELECT * FROM Videos 
WHERE NOT upload_date >= '2023-01-01';

-- NOT with Other Comparison Operators
-- You can often replace NOT with the opposite comparison operator for clearer code.
-- These are equivalent
SELECT * FROM Videos 
WHERE NOT title LIKE '%tutorial%';

SELECT * FROM Videos 
WHERE title NOT LIKE '%tutorial%';

-- These are also equivalent
SELECT * FROM Videos 
WHERE NOT views > 1000;

SELECT * FROM Videos 
WHERE views <= 1000;

-- NOT with Other Logical Operators
-- When combining NOT with AND or OR, you can apply De Morgan's Laws to simplify the logic.
-- These are equivalent
SELECT * FROM Videos 
WHERE NOT (title LIKE '%tutorial%' AND views > 1000);

SELECT * FROM Videos 
WHERE title NOT LIKE '%tutorial%' OR views <= 1000;

-- These are also equivalent
SELECT * FROM Videos 
WHERE NOT (title LIKE '%tutorial%' OR title LIKE '%guide%');

SELECT * FROM Videos 
WHERE title NOT LIKE '%tutorial%' AND title NOT LIKE '%guide%';

-- NOT IN Operator
-- NOT can be combined with IN to exclude rows where a column matches any value in a list.
-- Find users NOT in a specific list of IDs
SELECT * FROM Users 
WHERE user_id NOT IN (1, 2, 3, 10, 25);

-- Equivalent to
SELECT * FROM Users 
WHERE user_id != 1 
  AND user_id != 2 
  AND user_id != 3 
  AND user_id != 10 
  AND user_id != 25;

-- NOT LIKE Operator
-- Use NOT with LIKE to find strings that don't match a pattern.
-- Find videos without "Tutorial" in the title
SELECT * FROM Videos 
WHERE title NOT LIKE '%Tutorial%';

-- Find usernames that don't start with 'a'
SELECT * FROM Users 
WHERE username NOT LIKE 'a%';

-- NOT NULL Handling
-- Use IS NOT NULL to find non-null values in a column.
-- Find interactions with comments
SELECT * FROM Interactions 
WHERE comment_text IS NOT NULL;

-- Note: This is NOT the same as
SELECT * FROM Interactions 
WHERE NOT (comment_text IS NULL);
-- Important: Always use IS NOT NULL rather than NOT IS NULL or NOT column = NULL. The latter are incorrect syntax or will not work as expected.

-- Find content that doesn't match specific popular patterns
SELECT 
  video_id,
  title,
  user_id,
  views,
  upload_date
FROM 
  Videos
WHERE 
  NOT (
    (title LIKE '%tutorial%' AND views > 5000)
    OR 
    (title LIKE '%challenge%' AND views > 1000)
    OR
    (views > 50000)
  )
  AND upload_date >= '2023-01-01'
ORDER BY 
  views DESC;
-- Translation: This query finds recent videos that are NOT (popular tutorials OR popular challenges OR very popular videos).