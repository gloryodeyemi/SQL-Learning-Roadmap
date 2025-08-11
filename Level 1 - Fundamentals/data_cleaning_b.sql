-- SQL LIKE Operator
-- The LIKE operator in SQL is used for pattern matching in text fields. It allows you to search for specific patterns within string values, 
-- making it essential for flexible text searching and filtering.

-- The % Wildcard: Match Any Number of Characters
-- The percent sign (%) represents zero, one, or multiple characters in a LIKE pattern.

-- Find videos with titles starting with "How to"
SELECT * FROM Videos 
WHERE title LIKE 'How to%';

-- Find videos with "tutorial" anywhere in the title
SELECT * FROM Videos 
WHERE title LIKE '%tutorial%';

-- Find videos with titles ending in "Challenge"
SELECT * FROM Videos 
WHERE title LIKE '%Challenge';

-- Multiple wildcards: Find titles with "SQL" followed later by "beginner"
SELECT * FROM Videos 
WHERE title LIKE '%SQL%beginner%';

-- The _ Wildcard: Match a Single Character
-- The underscore (_) represents exactly one character in a LIKE pattern.

-- Find videos that are exactly 5 characters long
SELECT * FROM Videos 
WHERE title LIKE '_____';

-- Find usernames where the second character is 'a'
SELECT * FROM Users 
WHERE username LIKE '_a%';

-- Find videos with specific pattern in title
SELECT * FROM Videos 
WHERE title LIKE 'SQL__';

-- Find titles containing a specific year
SELECT * FROM Videos 
WHERE title LIKE '%202_';

-- Combining % and _ Wildcards
-- You can use both wildcards together for more complex pattern matching.

-- Find videos with the pattern: [any text] + "SQL" + [single character] + [any text]
SELECT * FROM Videos 
WHERE title LIKE '%SQL_%';

-- Find videos with titles that have exactly 3 characters between "Part" and "Tutorial"
SELECT * FROM Videos 
WHERE title LIKE '%Part___Tutorial%';

-- Prefix Matching (Starts With)
-- Find strings that start with a specific pattern.

-- Find videos with titles starting with specific phrases
SELECT * FROM Videos 
WHERE title LIKE 'Learn%';

-- Find users with usernames starting with 'a'
SELECT * FROM Users 
WHERE username LIKE 'a%';

-- Suffix Matching (Ends With)
-- Find strings that end with a specific pattern.

-- Find videos with titles ending in specific words
SELECT * FROM Videos 
WHERE title LIKE '%Tutorial';

-- Find videos ending with specific years
SELECT * FROM Videos 
WHERE title LIKE '%2023';

-- Substring Matching (Contains)
-- Find strings that contain a specific pattern anywhere.

-- Find videos with specific keywords anywhere in the title
SELECT * FROM Videos 
WHERE title LIKE '%SQL%';

-- Find users with 'smith' anywhere in their names
SELECT * FROM Users 
WHERE full_name LIKE '%smith%';

-- Pattern Escaping
-- When you need to search for the wildcard characters themselves (% or _), use the ESCAPE clause.

-- Search for titles containing percentage symbols
SELECT * FROM Videos 
WHERE title LIKE '%10\%%' ESCAPE '\';

-- Search for titles containing underscore characters
SELECT * FROM Videos 
WHERE title LIKE '%FAQ\_%' ESCAPE '\';

-- Case-Insensitive Matching
-- Perform case-insensitive pattern matching using database-specific features.

-- PostgreSQL: Use ILIKE for case-insensitive matching
SELECT * FROM Videos 
WHERE title ILIKE '%tutorial%';

-- Other databases: Convert both sides to same case
SELECT * FROM Videos 
WHERE LOWER(title) LIKE '%tutorial%';

-- ILIKE Operator
-- The ILIKE operator is a PostgreSQL-specific extension that performs case-insensitive matching. It works exactly like LIKE but ignores the 
-- case of letters.

-- Using NOT ILIKE for case-insensitive exclusion
SELECT * FROM Videos 
WHERE title NOT ILIKE '%beginner%';

-- Combining ILIKE with other conditions
SELECT * FROM Videos 
WHERE 
  views > 1000 
  AND (
    title ILIKE '%learn%' 
    OR title ILIKE '%course%'
  );

-- ILIKE with multiple patterns
SELECT * FROM Users
WHERE 
  email ILIKE '%.edu' 
  AND username ILIKE '%smith%';

-- NOT LIKE for Exclusion
-- Exclude rows that match a specific pattern.

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