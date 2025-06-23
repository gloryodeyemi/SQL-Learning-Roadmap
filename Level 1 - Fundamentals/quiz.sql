-- Quiz
-- 1. True or False: Using SELECT * in production code is generally a good practice because it ensures you retrieve all possible data from a table. 
-- Explain why.

-- 2. Write a SQL query to select only the video_title and upload_date columns from a table named Videos.
SELECT video_title, upload_date
FROM videos;

-- 3. You want to retrieve a list of unique customer IDs from a table named Orders. How would you write the SQL query to accomplish this, and why 
-- is it important to retrieve distinct values?
SELECT DISTINCT customer_id
FROM Orders;

-- 4. True or False: The FROM clause is optional in a SQL SELECT statement. Explain your reasoning.
-- The FROM clause is essential because it tells the database from which table(s) to retrieve the data. Without it, the database wouldn't know 
-- where to look!

-- 5. Write a SQL query to select all columns from the Users table.
SELECT *
FROM Users;

-- 6. Imagine you are writing a query that joins the Users and Videos tables. You want to make your query readable, so you decide to use table 
-- aliases. Give an example of how you would use table aliases for these two tables in the FROM clause. Explain why using aliases is helpful.
FROM Users u
JOIN Videos v ON u.user_id = v.user_id;
-- Using aliases u for Users and v for Videos makes the query more concise and easier to understand, especially when you have to refer to the 
-- table multiple times in the query.

-- 7. True or False: The WHERE clause is used to filter the results returned by a query.
-- 8. How do you handle NULL values in a WHERE clause? Can you write a short example using a table named employees with a column named phone_number?
SELECT employee_id
FROM employees
WHERE phone_number IS NULL;

-- 9. Imagine you have a table named products with columns product_name and price. Write a SQL query that selects all products whose name starts 
-- with 'A' and whose price is greater than 20.
SELECT product_name
FROM products
WHERE product_name LIKE 'A%'
    AND price > 20;