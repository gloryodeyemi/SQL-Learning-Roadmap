/*
SQL HAVING Clause

The HAVING clause in SQL is specifically designed to filter groups based on a specified condition, typically involving an aggregate function. It works in tandem with the GROUP BY clause, allowing you to apply criteria *after* rows have been grouped and aggregate calculations (like COUNT, SUM, AVG, MIN, MAX) have been performed.
*/

-- Using Only HAVING
-- Let's find users who have made more than 5 interactions (likes, comments, etc.).
-- Correct use of HAVING
SELECT
  user_id,
  COUNT(*) AS interaction_count
FROM Interactions
GROUP BY user_id
HAVING COUNT(*) > 5 -- Filter groups based on the aggregated count
ORDER BY interaction_count DESC;

-- Incorrect use - WHERE cannot use aggregates
-- SELECT user_id, COUNT(*) FROM Interactions WHERE COUNT(*) > 5 GROUP BY user_id; -- ERROR!

-- Finding Categories (e.g., Users) Meeting Multiple Criteria
-- Apply multiple aggregate conditions in the HAVING clause.
-- Find users who have uploaded at least 3 videos AND have an average view count > 1000
SELECT
  v.user_id,
  u.username,
  COUNT(v.video_id) AS video_count,
  AVG(v.views) AS average_views
FROM Videos v
JOIN Users u ON v.user_id = u.user_id
GROUP BY v.user_id, u.username
HAVING COUNT(v.video_id) >= 3 -- Condition 1 on COUNT
   AND AVG(v.views) > 1000    -- Condition 2 on AVG
ORDER BY average_views DESC;

-- Using Subqueries within HAVING
-- While possible, comparing an aggregate result to a value derived from a subquery within HAVING can sometimes be complex or less efficient than using CTEs or joining pre-aggregated results.
-- Find users whose average video views exceed the overall platform average
SELECT
  user_id,
  AVG(views) AS user_avg_views
FROM Videos
GROUP BY user_id
HAVING AVG(views) > (SELECT AVG(views) FROM Videos) -- Subquery in HAVING
ORDER BY user_avg_views DESC;

/*
QUIZ
----

Question 1
----------
True or False: The HAVING clause filters individual rows before any grouping or aggregation occurs.

Solution 1
----------
False. The HAVING clause filters groups after the GROUP BY clause has done its work and aggregate functions have been computed.

Question 2
----------
Fill in the blank: The HAVING clause is used to filter groups based on a specified condition, typically involving an __________ function.

Solution 2
----------
The HAVING clause is indeed used to filter groups based on a specified condition, typically involving an aggregate function.

Question 3
----------
Imagine you have a table named Orders with columns OrderID, CustomerID, and TotalAmount. Write a SQL query that uses the HAVING clause to find all CustomerIDs who have a total order amount greater than 1000.

Solution 3
----------
*/
SELECT 
    CustomerID,
    SUM(TotalAmount) AS total_order_amount
FROM Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 1000;