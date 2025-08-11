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