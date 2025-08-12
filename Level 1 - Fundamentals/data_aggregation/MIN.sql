/*
SQL MIN Function

The MIN function is a SQL aggregate function designed to return the minimum (smallest) value from a set of values in a specified column. It's incredibly versatile, working not just with numbers but also with dates, times, and strings (based on sort order). Use MIN to identify lowest performance, find the earliest event, or determine the lower bound of your data.
*/

-- MIN Function Basics

-- Finding the Minimum Numeric Value
-- Find the lowest view count achieved by any video
SELECT MIN(views) AS lowest_video_views
FROM videos;

-- Finding the Earliest Date/Timestamp
-- MIN is very useful for finding the earliest date or time in a dataset.
-- Find the date the first user joined the platform
SELECT MIN(join_date) AS earliest_signup_date
FROM users;
-- Result: '2023-01-01' (alice's join date)

-- Find the timestamp of the first interaction
SELECT MIN(timestamp) AS first_interaction
FROM interactions;
-- Result: '2023-02-01' (first likes on 'Funny Cat' video)

-- Finding the Minimum String Value
-- When used with text or string columns, MIN returns the value that comes first in alphabetical (or dictionary) order, according to the database's collation rules.
-- Find the username that comes first alphabetically
SELECT MIN(username) AS first_alphabetical_username
FROM users;
-- Result: 'alice'

-- MIN and NULL Value Handling
-- Similar to SUM and AVG, the MIN function ignores NULL values when determining the minimum. If all values considered are NULL, MIN returns NULL.
-- If views are [100, 500, NULL, 200], MIN(views) returns 100.
SELECT MIN(views) AS min_views
FROM videos;

-- Finding Rows Associated with the MIN Value
-- A common requirement is not just finding the minimum value itself, but retrieving the entire row(s) that contain this minimum value. MIN() alone only returns the value. Here are common patterns to get the full record:

-- Method 1: Using a Subquery in the WHERE Clause
-- This is the most common and intuitive method. First, find the minimum value using a subquery, then select rows where the column equals that minimum value.
-- Find the video(s) with the lowest view count
SELECT video_id, title, user_id, views
FROM videos
WHERE views = (SELECT MIN(views) FROM videos);
-- Result: video_id: 3, title: 'Cooking Tips', user_id: 1, views: 500

-- Method 2 [Advanced]: Using Window Functions
-- Window functions like RANK() or DENSE_RANK() can identify the bottom record(s) without a separate subquery for the MIN value.
-- Find the least viewed video(s) using RANK
WITH RankedVideos AS (
  SELECT
    video_id, title, user_id, views,
    RANK() OVER (ORDER BY views ASC) as rnk
  FROM videos
)
SELECT video_id, title, user_id, views
FROM RankedVideos
WHERE rnk = 1;

-- Method 3: Using ORDER BY and LIMIT (Simple for Bottom 1)
-- If you only need one row containing the minimum value (and don't care about ties), sorting and limiting is the simplest way.
-- Find *one* video with the lowest view count
SELECT video_id, title, user_id, views
FROM videos
ORDER BY views ASC
LIMIT 1;

-- Using MIN with GROUP BY

-- Finding Minimums within Categories
-- Find the lowest view count for videos uploaded by each user
SELECT
  u.username,
  MIN(v.views) AS lowest_views_for_user
FROM users u
LEFT JOIN videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
ORDER BY lowest_views_for_user ASC NULLS LAST;

-- Finding the Earliest Event per Category
-- Find the first interaction timestamp for each video
SELECT
  v.title,
  MIN(i.timestamp) AS first_interaction_time
FROM videos v
LEFT JOIN interactions i ON v.video_id = i.video_id
GROUP BY v.video_id, v.title
ORDER BY first_interaction_time ASC;

-- Filtering Groups Based on MIN (HAVING Clause)
-- Find users whose worst video still has over 1,000 views
SELECT
  u.username,
  MIN(v.views) AS min_views
FROM Users u
JOIN Videos v ON u.user_id = v.user_id
GROUP BY u.user_id, u.username
HAVING MIN(v.views) > 1000 -- Filter groups based on the min value found
ORDER BY min_views ASC;

-- Finding the Nth Minimum Value
-- Finding values other than the absolute minimum often involves window functions or clever subqueries.
-- Find the 2nd lowest view count using subquery
SELECT MIN(views)
FROM Videos
WHERE views > (SELECT MIN(views) FROM Videos);

-- Find the 3rd lowest view count using window functions (more general)
WITH RankedViews AS (
  SELECT
    views,
    DENSE_RANK() OVER (ORDER BY views ASC) as rnk
  FROM Videos
)
SELECT DISTINCT views
FROM RankedViews
WHERE rnk = 3;

-- Finding the Row with MIN Value per Group (Least-N-Per-Group)
-- This is a common, slightly complex task: retrieve the full row corresponding to the minimum value within each group (e.g., find each user's least viewed video details). Window functions are often the most efficient solution.

-- Find details of each user's least viewed video using ROW_NUMBER()
WITH RankedUserVideos AS (
  SELECT
    v.video_id, v.title, v.user_id, v.views, v.upload_date,
    ROW_NUMBER() OVER (PARTITION BY v.user_id ORDER BY v.views ASC, v.video_id DESC) as rn
    -- Partition by user, order by views ascending. Tie-break with video_id if needed.
  FROM Videos v
)
SELECT ruv.video_id, u.username, ruv.title, ruv.views, ruv.upload_date
FROM RankedUserVideos ruv
JOIN Users u ON ruv.user_id = u.user_id
WHERE ruv.rn = 1; -- Select the bottom-ranked video (rn=1) for each user

-- Using ELSE for Defaults and NULL Handling
-- The optional ELSE clause provides a default value if none of the WHEN conditions are met. If ELSE is omitted and no condition matches, the CASE expression returns NULL.
-- Categorize videos by view count
SELECT
  video_id,
  title,
  views,
  CASE 
    WHEN views >= 1500 THEN 'High Views'
    WHEN views >= 1000 THEN 'Medium Views'
    WHEN views > 0 THEN 'Low Views'
    ELSE 'No Views'
  END AS view_category
FROM Videos;