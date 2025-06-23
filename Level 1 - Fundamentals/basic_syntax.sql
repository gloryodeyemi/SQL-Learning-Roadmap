-- SQL SELECT Statement
-- It retrieves specific columns of data from one or more tables in a database.


/*
Table Schema

users
(user_id: INTEGER, username: TEXT, email: TEXT, join_date: TEXT)

videos
(video_id: INTEGER, user_id: INTEGER, title: TEXT, upload_date: TEXT, views: INTEGER)

interactions
(interaction_id: INTEGER, user_id: INTEGER, video_id: INTEGER, interaction_type: TEXT, timestamp: TEXT, comment_text: TEXT)
*/

-- Example 1: Retrieve interaction information from the Interactions table
SELECT 
  interaction_id,
  user_id,
  video_id,
  interaction_type,
  timestamp
FROM 
  Interactions;

-- Example 2: Retrieve video information from the Videos table
SELECT 
  video_id,
  title AS "Video Title",
  views AS "View Count",
  upload_date AS "Published On"
FROM 
  Videos;