/*
SQL MAX Function

The MAX function is a SQL aggregate function designed to return the maximum (largest) value from a set of values in a specified column. It's incredibly versatile, working not just with numbers but also with dates, times, and strings (based on sort order). Use MAX to identify peak performance, find the latest event, or determine the upper bound of your data.
*/

-- MAX Function Basics

-- Finding the Maximum Numeric Value
-- Find the highest view count achieved by any video
SELECT MAX(views) AS highest_video_views
FROM videos;

-- Finding the Latest Date/Timestamp
-- MAX is very useful for finding the most recent date or time in a dataset.
-- Find the date the last user joined the platform
SELECT MAX(join_date) AS latest_signup_date
FROM users;

-- Find the timestamp of the most recent interaction
SELECT MAX(timestamp) AS most_recent_interaction
FROM interactions;

-- Finding the Maximum String Value
-- When used with text or string columns, MAX returns the value that comes last in alphabetical (or dictionary) order, according to the database's collation rules.
-- Find the username that comes last alphabetically
SELECT MAX(username) AS last_alphabetical_username
FROM users;

-- MAX and NULL Value Handling
-- Similar to SUM and AVG, the MAX function ignores NULL values when determining the maximum. If all values considered are NULL, MAX returns NULL.
-- MAX ignores NULLs
-- If views are [100, 500, NULL, 200], MAX(views) returns 500
SELECT MAX(views) AS max_views
FROM videos;

-- Finding the Nth Maximum Value
-- Find the 2nd highest view count using subquery
SELECT MAX(views)
FROM videos
WHERE views < (SELECT MAX(views) FROM videos);

-- Find the 3rd highest view count using window functions
WITH RankedViews AS (
  SELECT
    views,
    DENSE_RANK() OVER (ORDER BY views DESC) as rnk
  FROM videos
)
SELECT DISTINCT views
FROM RankedViews
WHERE rnk = 3;

-- Finding the Row with MAX Value per Group (Greatest-N-Per-Group)
-- This is a common, slightly complex task: retrieve the full row corresponding to the maximum value within each group (e.g., find each user's most viewed video details).
-- Find details of each user's most viewed video using ROW_NUMBER()
WITH RankedUserVideos AS (
  SELECT
    v.video_id, v.title, v.user_id, v.views, v.upload_date,
    ROW_NUMBER() OVER (PARTITION BY v.user_id ORDER BY v.views DESC, v.video_id DESC) as rn
  FROM videos v
)
SELECT ruv.video_id, u.username, ruv.title, ruv.views, ruv.upload_date
FROM RankedUserVideos ruv
JOIN users u ON ruv.user_id = u.user_id
WHERE ruv.rn = 1;

/*
QUIZ
----

Question 1
----------
True or False: The MAX function in SQL can only be used with numeric data types.

Solution 1
----------
False. The MAX function is versatile and can be used with numeric, date/time, and string data types.

Question 2
----------
How does the MAX function handle NULL values when determining the maximum value in a column? a) It returns NULL if any value is NULL b) It includes NULL as a possible maximum value c) It ignores NULL values d) It treats NULL as zero

Solution 2
----------
c) The MAX function ignores NULL values when determining the maximum. If all values in the column are NULL, then MAX will return NULL.

Question 3
----------
Imagine you have a table named products with columns category and price. Write a SQL query that uses MAX along with GROUP BY to find the highest price for each product category.

Solution 3
----------
*/
SELECT
    category,
    MAX(price)
FROM products
GROUP BY category;