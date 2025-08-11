/*
SQL COALESCE Function

The COALESCE function in SQL returns the first non-NULL expression in a list of expressions. It's an essential tool for handling NULL values and 
providing default values in your queries.
*/

-- Basic COALESCE Usage
-- Example 1: Simple COALESCE
SELECT COALESCE(NULL, 'Default Value', 'Another Value');
-- Returns: 'Default Value'

-- Example 2: Multiple NULL values
SELECT COALESCE(NULL, NULL, 'First Non-NULL', NULL);
-- Returns: 'First Non-NULL'

-- Example 3: All NULL values
SELECT COALESCE(NULL, NULL, NULL);
-- Returns: NULL (since all values are NULL)

-- Data Type Compatibility
-- Example: Ensure compatible types
SELECT COALESCE(CAST(user_id AS TEXT), username, 'Anonymous') FROM users;
SELECT COALESCE(views, 0) FROM videos;

-- Providing Default Values for Columns
-- One of the most common uses of COALESCE is to provide default values for NULL columns in results.
-- Return a default value when email is NULL
SELECT 
  username, 
  COALESCE(email, 'No email provided') AS email
FROM 
  users;

-- Use multiple fallback options for contact information
SELECT
  user_id,
  COALESCE(email, username, 'No contact info') AS contact_info
FROM
  users;

-- COALESCE vs. IFNULL/NVL
-- COALESCE is more flexible than database-specific NULL-handling functions. Advantage: COALESCE is part of the SQL standard and works across different database systems, whereas functions like IFNULL (MySQL) and NVL (Oracle) are database-specific.
-- MySQL IFNULL (only handles one NULL check)
SELECT IFNULL(email, 'No email') FROM users;

-- Oracle NVL (only handles one NULL check)
SELECT NVL(email, 'No email') FROM users;

-- COALESCE (works across databases and handles multiple checks)
SELECT COALESCE(email, 'No email') FROM users;
SELECT COALESCE(email, username, 'No contact') FROM users; -- Multiple fallbacks

-- Advanced COALESCE Techniques

-- Order of Preference Data Selection
-- COALESCE can implement a preference order for selecting data.
-- Select the preferred user identifier in order of preference
SELECT
  user_id,
  username,
  COALESCE(
    email,
    username,
    'User ID: ' || CAST(user_id AS TEXT),
    'Anonymous User'
  ) AS display_identifier
FROM
  users;

-- Using COALESCE with Aggregates
-- COALESCE works well with aggregate functions to handle NULL values in grouping operations.
-- In this example, if the views column is NULL, it will be replaced with 0 before the aggregation.
-- Sum views with COALESCE to handle NULLs
SELECT
  user_id,
  SUM(COALESCE(views, 0)) AS total_views,
  COUNT(video_id) AS total_videos,
  AVG(COALESCE(views, 0)) AS avg_views
FROM
  videos
GROUP BY
  user_id;

-- Dynamic Default Values
-- The default value in COALESCE can be a dynamic expression or subquery.
-- Use user average as a default for NULL views
SELECT
  v.video_id,
  v.title,
  v.user_id,
  COALESCE(
    v.views,
    (SELECT AVG(views) FROM videos v2 WHERE v2.user_id = v.user_id)
  ) AS view_count
FROM
  videos v;

-- Practical SQL COALESCE Examples

-- Example 1: User Profile Completeness Report
-- Calculate profile completeness percentage
SELECT
  user_id,
  username,
  (
    (CASE WHEN username IS NOT NULL THEN 25 ELSE 0 END) +
    (CASE WHEN email IS NOT NULL THEN 25 ELSE 0 END) +
    (CASE WHEN join_date IS NOT NULL THEN 50 ELSE 0 END)
  ) AS profile_completion_percentage,
  COALESCE(username, 'Anonymous') AS display_name,
  COALESCE(email, 'No email provided') AS contact_email,
  COALESCE(join_date, 'Unknown join date') AS member_since
FROM
  users
ORDER BY
  profile_completion_percentage DESC;

-- Example 2: Video Analytics Dashboard
-- Create a video analytics report with default values for missing metrics
SELECT
  v.video_id,
  v.title,
  v.user_id,
  u.username AS creator,
  COALESCE(v.views, 0) AS views,
  COALESCE(comment_count.count, 0) AS comments,
  COALESCE(like_count.count, 0) AS likes,
  COALESCE(like_count.count, 0) * 100.0 / NULLIF(COALESCE(v.views, 0), 0) AS like_rate,
  (
    COALESCE(v.views, 0) / 10 + 
    COALESCE(comment_count.count, 0) * 2 + 
    COALESCE(like_count.count, 0) * 3
  ) AS engagement_score
FROM
  videos v
LEFT JOIN
  users u ON v.user_id = u.user_id
LEFT JOIN (
  SELECT video_id, COUNT(*) AS count
  FROM interactions
  WHERE interaction_type = 'like'
  GROUP BY video_id
) like_count ON v.video_id = like_count.video_id
LEFT JOIN (
  SELECT video_id, COUNT(*) AS count
  FROM interactions
  WHERE interaction_type = 'comment'
  GROUP BY video_id
) comment_count ON v.video_id = comment_count.video_id
ORDER BY
  engagement_score DESC;

-- Example 3: Payment Processing with Fallbacks
-- Process interaction data with fallbacks
SELECT
  i.interaction_id,
  u.user_id,
  u.username,
  v.video_id,
  v.title,
  i.interaction_type,
  COALESCE(
    i.comment_text,
    'No comment text',
    i.interaction_type || ' interaction'
  ) AS interaction_content,
  COALESCE(
    i.timestamp,
    v.upload_date,
    u.join_date,
    'Unknown date'
  ) AS interaction_time
FROM
  interactions i
JOIN
  users u ON i.user_id = u.user_id
JOIN
  videos v ON i.video_id = v.video_id
WHERE
  i.interaction_type IN ('comment', 'like');

-- QUIZ

/*
Question 1
----------
True or False: The COALESCE function returns the first NULL expression in a list of expressions.

Solution 1
----------
False. The COALESCE function is designed to return the first non-NULL expression it encounters in the list. It only returns NULL if all expressions are NULL.
*/

/*
Question 2
----------
Imagine you have a table named employees with columns name, email, and phone. You want to display a contact method for each employee, prioritizing email if available, otherwise using the phone number.

Write a SQL query using the COALESCE function to achieve this, aliasing the resulting column as contact_method.
*/
SELECT 
    name,
    COALESCE(email, phone) AS "contact_method"
FROM employees;

/*
Question 3
----------
In what ways is COALESCE more advantageous than using database-specific functions like ISNULL (SQL Server) or NVL (Oracle)? Explain your reasoning.

Solution 3
----------
COALESCE is part of the SQL standard, ensuring compatibility across various database systems like MySQL, PostgreSQL, SQL Server, and Oracle. This is a significant advantage because it reduces the need to rewrite queries when migrating or working with different databases. Additionally, COALESCE can handle multiple fallback values, offering more flexibility compared to functions like ISNULL or NVL, which typically only allow for a single fallback.
*/