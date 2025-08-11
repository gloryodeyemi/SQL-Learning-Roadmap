/*
SQL CASE WHEN Statement

The CASE WHEN expression in SQL provides a way to add conditional logic to your queries. It works like an if-then-else statement, allowing you to 
evaluate conditions and return different values based on the results.
*/

-- Two Forms of CASE Expressions

-- Simple CASE Expression
-- The simple CASE form compares an expression to a set of values for equality. Simple CASE is useful when comparing a single expression against 
-- multiple possible values.

-- Categorize videos based on view count
SELECT 
  video_id,
  title,
  CASE 
    WHEN views < 1000 THEN 'Low Views'
    WHEN views < 10000 THEN 'Medium Views'
    ELSE 'High Views'
  END AS view_category
FROM Videos;

-- Searched CASE Expression
-- The searched CASE form evaluates a list of conditions and returns a result for the first condition that is true. Searched CASE is useful when 
-- evaluating different expressions with different operators in each WHEN clause.
-- Classify videos based on view count

SELECT 
  video_id,
  title,
  views,
  CASE
    WHEN views >= 1000000 THEN 'Viral'
    WHEN views >= 100000 THEN 'Popular'
    WHEN views >= 10000 THEN 'Growing'
    WHEN views > 0 THEN 'New'
    ELSE 'No views'
  END AS popularity
FROM Videos;

-- Using CASE WHEN in Different SQL Clauses

-- CASE in SELECT Clause
-- Transform output values
SELECT
  username,
  email,
  CASE
    WHEN join_date <= '2020-01-01' THEN 'Early Adopter'
    WHEN join_date <= '2022-01-01' THEN 'Regular User'
    ELSE 'New User'
  END AS user_status
FROM Users;

-- CASE in WHERE Clause
-- Find videos with engagement based on their views
SELECT *
FROM Videos
WHERE
  CASE
    WHEN views >= 10000 AND upload_date >= '2023-01-01' THEN 1
    WHEN views >= 50000 THEN 1
    ELSE 0
  END = 1;

-- CASE in ORDER BY Clause
-- Custom sort order for videos
SELECT
  video_id,
  title,
  views,
  upload_date
FROM
  Videos
ORDER BY
  CASE
    WHEN upload_date >= date('now', '-7 day') THEN 0  -- New videos first
    WHEN views > 50000 THEN 1       -- Then high-view videos
    ELSE 2                          -- Then everything else
  END,
  views DESC;  -- Secondary sort by views

-- CASE in GROUP BY Clause
-- Group videos by custom view categories
SELECT
  CASE
    WHEN views < 1000 THEN 'Under 1K'
    WHEN views < 10000 THEN '1K-10K'
    WHEN views < 100000 THEN '10K-100K'
    ELSE 'Over 100K'
  END AS view_category,
  COUNT(*) AS video_count,
  AVG(views) AS average_views
FROM
  Videos
GROUP BY
  CASE
    WHEN views < 1000 THEN 'Under 1K'
    WHEN views < 10000 THEN '1K-10K'
    WHEN views < 100000 THEN '10K-100K'
    ELSE 'Over 100K'
  END;

-- CASE WHEN with Aggregate Functions

-- Conditional Counting
-- Use CASE with COUNT to count rows that meet specific conditions.
-- Count videos in different view ranges by user
SELECT
  user_id,
  COUNT(*) AS total_videos,
  COUNT(CASE WHEN views < 1000 THEN 1 END) AS low_view_count,
  COUNT(CASE WHEN views BETWEEN 1000 AND 10000 THEN 1 END) AS medium_view_count,
  COUNT(CASE WHEN views > 10000 THEN 1 END) AS high_view_count
FROM
  Videos
GROUP BY
  user_id;
-- We use COUNT(CASE WHEN...) rather than SUM(CASE WHEN...) because COUNT ignores NULLs, which is what we want for rows that don't match our 
-- condition.

-- Conditional Summing
-- Use CASE with SUM to calculate totals based on conditions.
-- Sum views by upload date periods
SELECT
  user_id,
  SUM(CASE WHEN upload_date >= '2023-01-01' THEN views ELSE 0 END) AS current_year_views,
  SUM(CASE WHEN upload_date BETWEEN '2022-01-01' AND '2022-12-31' THEN views ELSE 0 END) AS last_year_views,
  SUM(CASE WHEN upload_date < '2022-01-01' THEN views ELSE 0 END) AS older_views
FROM
  Videos
GROUP BY
  user_id;

-- Pivot Tables with CASE
-- Create pivot tables by combining CASE with aggregate functions.
-- Create a monthly view count pivot by user
SELECT
  user_id,
  SUM(CASE WHEN substr(upload_date, 6, 2) = '01' THEN views ELSE 0 END) AS jan_views,
  SUM(CASE WHEN substr(upload_date, 6, 2) = '02' THEN views ELSE 0 END) AS feb_views,
  SUM(CASE WHEN substr(upload_date, 6, 2) = '03' THEN views ELSE 0 END) AS mar_views,
  SUM(CASE WHEN substr(upload_date, 6, 2) = '04' THEN views ELSE 0 END) AS apr_views
FROM
  Videos
WHERE
  substr(upload_date, 1, 4) = '2023'
GROUP BY
  user_id;

-- Example 1: Dynamic Date Formatting
-- Format dates based on recency
SELECT
  video_id,
  title,
  upload_date,
  CASE
    WHEN upload_date = date('now') THEN 'Today'
    WHEN upload_date = date('now', '-1 day') THEN 'Yesterday'
    WHEN upload_date > date('now', '-7 days') THEN 
      'Last week'
    WHEN upload_date > date('now', '-30 days') THEN
      'Last month'
    ELSE
      upload_date
  END AS formatted_date
FROM
  Videos
ORDER BY
  upload_date DESC;

-- Example 2: User Engagement Classification
-- Classify users based on engagement metrics
SELECT
  u.user_id,
  u.username,
  COUNT(v.video_id) AS videos_uploaded,
  COUNT(DISTINCT i.video_id) AS videos_interacted,
  COUNT(CASE WHEN i.interaction_type = 'comment' THEN 1 END) AS comments_made,
  COUNT(v.video_id) * 10 + COUNT(CASE WHEN i.interaction_type = 'comment' THEN 1 END) * 2 + COUNT(DISTINCT i.video_id) AS engagement_score,
  CASE
    WHEN COUNT(v.video_id) * 10 + COUNT(CASE WHEN i.interaction_type = 'comment' THEN 1 END) * 2 + COUNT(DISTINCT i.video_id) > 100 THEN 'Super User'
    WHEN COUNT(v.video_id) * 10 + COUNT(CASE WHEN i.interaction_type = 'comment' THEN 1 END) * 2 + COUNT(DISTINCT i.video_id) > 50 THEN 'Active User'
    WHEN COUNT(v.video_id) * 10 + COUNT(CASE WHEN i.interaction_type = 'comment' THEN 1 END) * 2 + COUNT(DISTINCT i.video_id) > 20 THEN 'Regular User'
    ELSE 'Casual User'
  END AS user_category
FROM
  Users u
LEFT JOIN Videos v ON u.user_id = v.user_id
LEFT JOIN Interactions i ON u.user_id = i.user_id
GROUP BY
  u.user_id, u.username
ORDER BY
  engagement_score DESC;

-- Example 3: Complex Performance Analysis
-- Video performance analysis with multiple metrics
SELECT
  v.user_id,
  COUNT(*) AS total_videos,
  
  -- View performance tiers
  SUM(CASE
    WHEN v.views > (SELECT AVG(views) * 2 FROM Videos) THEN 1
    ELSE 0
  END) AS outstanding_performers,
  
  -- Video age analysis
  AVG(CASE
    WHEN date(v.upload_date) > date('now', '-30 days') THEN v.views
    ELSE NULL
  END) AS avg_recent_views,
  
  -- Engagement metrics
  SUM(CASE
    WHEN EXISTS (
      SELECT 1 FROM Interactions i 
      WHERE i.video_id = v.video_id AND i.interaction_type = 'comment'
      GROUP BY i.video_id
      HAVING COUNT(*) > 10
    ) THEN 1
    ELSE 0
  END) AS highly_commented_videos,
  
  -- Recent success ratio
  CASE
    WHEN COUNT(CASE WHEN date(v.upload_date) > date('now', '-90 days') THEN 1 END) > 0 
    THEN 
      SUM(CASE WHEN date(v.upload_date) > date('now', '-90 days') AND v.views > 10000 THEN 1 ELSE 0 END) * 100.0 / 
      COUNT(CASE WHEN date(v.upload_date) > date('now', '-90 days') THEN 1 END)
    ELSE 0
  END AS recent_success_percentage
FROM
  Videos v
GROUP BY
  v.user_id
ORDER BY
  total_videos DESC;

/*
QUIZ
----

Question 1
----------
True or False: The CASE WHEN expression in SQL is used to add conditional logic to your queries, similar to an if-then-else statement. 
Explain your reasoning.

Solution 1
----------
True. The CASE WHEN expression indeed functions like an if-then-else statement, allowing you to evaluate conditions and return different values 
based on the results.

Question 2
----------
Fill in the blank: In a simple CASE expression, you compare an expression to a set of ______ for equality.

Solution 2
----------
In a simple CASE expression, you compare an expression to a set of values for equality.

Question 3
----------
Which type of CASE expression is more suitable when you need to evaluate different expressions with different operators in each WHEN clause?

a) Simple CASE expression b) Searched CASE expression

Solution 3
----------
The searched CASE expression is indeed more suitable for evaluating different expressions with different operators in each WHEN clause. This is 
because it allows you to specify a boolean condition for each WHEN clause, providing greater flexibility compared to the simple CASE expression, 
which only checks for equality.

Question 4
----------
Write a SQL query that uses a CASE WHEN statement in the SELECT clause to categorize videos based on their view counts. If a video has more than 10000 views, it should be labeled as 'Popular'. Otherwise, it should be labeled as 'Not Popular'. The table is called videos and has a column called views.

Solution 4
----------
*/
SELECT
    views,
    CASE 
        WHEN views > 10000 THEN 'Popular' ELSE 'Not Popular' 
    END AS 'video_category'
FROM videos;