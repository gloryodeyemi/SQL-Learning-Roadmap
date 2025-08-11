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