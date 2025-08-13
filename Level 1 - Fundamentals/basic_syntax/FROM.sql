-- FROM Clause
-- The FROM clause is a fundamental component of SQL SELECT statements that specifies which table(s) to retrieve data from. It defines the source 
-- of the data for your query.

-- Query data from the Users table
SELECT user_id, username, email 
FROM Users;

-- Using a table alias
SELECT u.user_id, u.username, u.email 
FROM Users AS u;

-- Simple join between Users and Videos
SELECT u.username, v.title 
FROM Users u
JOIN Videos v ON u.user_id = v.user_id;

-- QUIZ

-- 1. True or False: The FROM clause is optional in a SQL SELECT statement. Explain your reasoning.
-- The FROM clause is essential because it tells the database from which table(s) to retrieve the data. Without it, the database wouldn't know 
-- where to look!

-- 2. Write a SQL query to select all columns from the Users table.
SELECT *
FROM Users;

-- 3. Imagine you are writing a query that joins the Users and Videos tables. You want to make your query readable, so you decide to use table 
-- aliases. Give an example of how you would use table aliases for these two tables in the FROM clause. Explain why using aliases is helpful.
FROM Users u
JOIN Videos v ON u.user_id = v.user_id;
-- Using aliases u for Users and v for Videos makes the query more concise and easier to understand, especially when you have to refer to the 
-- table multiple times in the query.