-- DISTINCT Keyword
-- 1. True or False: The DISTINCT keyword in SQL is used to eliminate duplicate values from your query results. Explain your reasoning.
-- The DISTINCT keyword does indeed eliminate duplicate values, ensuring that only unique entries are returned in the result set.

-- 2. Imagine you have a table named products with a column named category. Write a SQL query that returns a list of all unique categories in the 
-- products table.
SELECT DISTINCT category
FROM products;

-- 3. You have a table named sales with columns product_id, customer_id, and sale_date. You want to find out how many unique customers purchased  
-- each product. How would you use DISTINCT in combination with COUNT and GROUP BY to achieve this? Explain your approach.
SELECT product_id, COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY product_id;

-- AND Operator
-- 1. True or False: The SQL AND operator requires all conditions to be TRUE for a row to be included in the result. Explain your reasoning.
-- The AND operator acts as a filter, ensuring that only rows satisfying all specified conditions are included in the result set. If even one 
-- condition is FALSE, the entire expression evaluates to FALSE, and the row is excluded.

-- 2. Imagine you have a table named products with columns price and in_stock. Write a SQL snippet that selects all products that cost more than 
-- 20 dollars and are in stock.
SELECT *
FROM products
WHERE price > 20 AND in_stock = TRUE;

-- 3. How does the AND operator handle NULL values in SQL? Explain what happens when you combine TRUE AND NULL and FALSE AND NULL.
-- When the AND operator encounters a TRUE and NULL, the result is NULL and when it encounters FALSE and NULL, the result is FALSE. Only rows 
-- that are TRUE are returned.

-- OR Operator
-- 1. True or False: The OR operator requires all conditions to be TRUE for a row to be included in the result. Explain your reasoning.
-- False. The OR operator includes a row if at least one of the conditions is TRUE. If all conditions are FALSE, then the row is excluded.

-- 2. Suppose you want to find all customers who live in either 'New York' or 'Los Angeles'. Write a simple SQL query using the OR operator to 
-- achieve this, assuming your table is named Customers and the column containing city information is named City.
SELECT *
FROM Customers
WHERE City = 'New York' OR City = 'Los Angeles';

-- 3. Consider the following SQL expression: TRUE OR NULL. According to SQL's three-valued logic, what will this expression evaluate to? 
-- Explain why.
-- In SQL's three-valued logic, TRUE OR NULL evaluates to TRUE. The OR operator only needs one of the conditions to be TRUE to return TRUE.