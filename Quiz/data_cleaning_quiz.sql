-- DISTINCT Keyword
-- 1. True or False: The DISTINCT keyword in SQL is used to eliminate duplicate values from your query results. Explain your reasoning.
-- The DISTINCT keyword does indeed eliminate duplicate values, ensuring that only unique entries are returned in the result set.

-- Imagine you have a table named products with a column named category. Write a SQL query that returns a list of all unique categories in the 
-- products table.
SELECT DISTINCT category
FROM products;

-- You have a table named sales with columns product_id, customer_id, and sale_date. You want to find out how many unique customers purchased each 
-- product. How would you use DISTINCT in combination with COUNT and GROUP BY to achieve this? Explain your approach.
SELECT product_id, COUNT(DISTINCT customer_id) AS unique_customers
FROM sales
GROUP BY product_id;

-- AND Operator
