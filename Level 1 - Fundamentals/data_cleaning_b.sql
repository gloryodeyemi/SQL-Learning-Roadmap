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
