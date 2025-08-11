# SQL Learning Roadmap

## Topics Covered
### Level 1 - Fundamentals
1. Basic SQL Syntax: `SELECT`, `FROM`, `WHERE`, `ORDER BY`, `AS`, and `LIMIT`.
2. Data Cleaning: `DISTINCT`, `AND`, `OR`, `NOT`, `LIKE`, `BETWEEN`, `IN`, `CASE WHEN`, `COALESCE` and `CAST`.
3. Data Aggregations
---

## Table Schema
```
users
(user_id: INTEGER, username: TEXT, email: TEXT, join_date: TEXT)

videos
(video_id: INTEGER, user_id: INTEGER, title: TEXT, upload_date: TEXT, views: INTEGER)

interactions
(interaction_id: INTEGER, user_id: INTEGER, video_id: INTEGER, interaction_type: TEXT, timestamp: TEXT, comment_text: TEXT)
```