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

/*
NOT Operator

Question 1
----------
True or False: The NOT operator in SQL reverses the result of the condition that follows it, turning TRUE to FALSE and FALSE to TRUE. 
Explain your reasoning.

Question 2
----------
Suppose you want to find all customers who are NOT from the USA. Which of the following SQL snippets would be the most appropriate way to do this?
a) WHERE country != 'USA' b) WHERE NOT country = 'USA' c) Both a and b are equally appropriate. d) WHERE country <> 'USA' e) a, b, and d are 
all equally appropriate. Explain your reasoning.

Solution
--------
e) a, b, and d are all equally appropriate because they produce the same result. However the choice of query to use depends on factors like 
optimization, syntax, etc.

!= and <> are common alternatives to NOT and are often considered more readable. While all three achieve the same result, readability and 
database-specific optimizations can influence the best choice.

Question 3
----------
Imagine you have a table named products with a column price. Write a SQL query that selects all products that are NOT NULL and have a price 
greater than 100.

Solution
--------
*/
SELECT *
FROM products
WHERE price IS NOT NULL 
    AND price > 100;

/*
LIKE Operator
-------------

Question 1
----------
True or False: The SQL LIKE operator is used for exact matching of text fields. Explain your reasoning.

Solution 1
----------
The LIKE operator is indeed used for pattern matching, not exact matching. It allows you to search for strings that contain specific patterns, 
using wildcards like % and _ to represent variable characters.

Question 2
----------
Which wildcard in the SQL LIKE operator represents any single character? (a) % (b) _ (c) * (d) #

Solution 2
----------
The underscore (_) wildcard represents any single character in the SQL LIKE operator.

Question 3
----------
Write a SQL query that selects all records from a table named employees where the first_name field starts with "A". Explain how this query works.

Solution 3
----------
*/
SELECT *
FROM employees
WHERE UPPER(first_name) LIKE 'A%';

/*
BETWEEN Operator
----------------

Question 1
----------
True or False: The SQL BETWEEN operator includes both the start and end values in its range. Explain your reasoning.

Solution 1
----------
True. The BETWEEN operator is inclusive except while using it in string because it compares full string.

Question 2
----------
Fill in the blank:
The BETWEEN operator is especially useful for filtering data within ____ ranges.

Solution 2
----------
The BETWEEN operator is especially useful for filtering data within specified ranges. This encompasses numbers, dates, and even strings!

Question 3
----------
Write a SQL query to select all products from a table named products where the price is between 50 and 100 (inclusive). The price column is 
named price.

Solution 3
----------
*/
SELECT *
FROM products
WHERE price BETWEEN 50 AND 100;