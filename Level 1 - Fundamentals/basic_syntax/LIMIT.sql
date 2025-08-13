-- LIMIT Clause
-- It restricts the number of rows returned, making your queries more efficient and your results more manageable.

-- Basic LIMIT Usage
-- Restrict your result set to the first N rows
-- Get only the first 5 users
SELECT username, email, join_date 
FROM Users
LIMIT 5;

-- LIMIT with OFFSET
-- Skip a certain number of rows before starting to return rows
-- Skip the first 5 videos and return the next 5
SELECT video_id, title, views 
FROM Videos
LIMIT 5 OFFSET 5;
-- Think of OFFSET like skipping a few pages in a book before you start reading. This is perfect for implementing pagination in applications!
-- SQLite requires explicit OFFSET keyword

-- Example 1: Finding the Top Performing Videos
-- Want to see which TokTuk videos are trending? Use LIMIT with ORDER BY
-- Get the top 3 most-viewed videos
SELECT 
  video_id,
  title,
  views
FROM 
  Videos
ORDER BY 
  views DESC
LIMIT 3;

-- Example 2: Implementing Pagination for User Feeds
-- Ever wonder how social media feeds load content as you scroll?
-- Get videos for page 2 (assuming 4 videos per page)
SELECT 
  v.video_id,
  v.title,
  u.username AS creator,
  v.views
FROM 
  Videos v
JOIN
  Users u ON v.user_id = u.user_id
ORDER BY 
  v.upload_date DESC
LIMIT 4 OFFSET 4;  -- Page 2 (items 5-8)

/*
LIMIT Best Practices and Performance Considerations

1. Always Combine with ORDER BY
Without ORDER BY, the database returns rows in an arbitrary order, making LIMIT unpredictable. Always pair LIMIT with ORDER BY for consistent 
results.

2. Be Careful with High OFFSET Values
While LIMIT 10 OFFSET 1000000 is valid SQL, it forces the database to scan and discard the first million rows! For deep pagination, consider using 
"keyset pagination" instead (filtering based on the last seen ID).

3. Use LIMIT During Development and Testing
When writing complex queries, add a LIMIT clause during development to avoid accidentally returning millions of rows. Your development database 
(and your patience) will thank you!
*/

/*
LIMIT vs TOP: Understanding the Differences
While LIMIT is the standard in PostgreSQL, MySQL, and SQLite, the TOP clause is the traditional method in SQL Server environments.
SQL Server TOP syntax

Key Differences
LIMIT is placed at the end of the query, while TOP appears right after SELECT
TOP can use WITH TIES to include rows with identical values in the ordering column
LIMIT is standard in PostgreSQL, MySQL, and SQLite, while TOP is specific to SQL Server
*/
SELECT TOP 10 username, email 
FROM Users;

-- TOP with ties
SELECT TOP 10 WITH TIES username, salary 
FROM Employees 
ORDER BY salary DESC;

-- QUIZ

-- 1. True or False: The LIMIT clause is used to restrict the number of rows returned by a query. Explain your reasoning.
-- The LIMIT clause does indeed restrict the number of rows returned by a query, which helps with both readability and performance, especially on 
-- large tables.

-- 2. Imagine you have a table named products with columns id and name. Write a SQL query that retrieves the top 5 products from the products 
-- table.
SELECT id, name
FROM products
ORDER BY id ASC
LIMIT 5;

-- 3. Fill in the blank: The _______ clause is used with LIMIT to skip a certain number of rows before starting to return rows.
-- OFFSET

/*
4. You are working with a very large table in TokTuk, and you need to retrieve data for a specific page in a user feed. Which of the following is 
the MOST important reason to use LIMIT in this scenario?

A) To make the query easier to read.

B) To improve query performance by reducing the amount of data processed.

C) To ensure the data is sorted correctly.

D) To avoid displaying duplicate rows.
*/