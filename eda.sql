USE retail_sales;


-- To turn off safe update mode because it is automatically on in MySql
-- To make update , delete , we need to turn off the safe mode, otherwise it will not be possible to run the queries.
SET SQL_SAFE_UPDATES = 0; 

-- To turn on safe update mode in MySql
SET SQL_SAFE_UPDATES = 1; 


SELECT
DISTINCT unit_price 
FROM 
product
WHERE
product_name='Milk';

UPDATE product
SET unit_price= 1.90
WHERE product_name='Milk';

DELETE 
FROM
fact_sales
WHERE total_amount=0;


-- Total revenue of the store
SELECT s.store_name, SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN store s ON f.store_id = s.store_id
GROUP BY s.store_name;

-- Total sale of individual product.

SELECT p.product_name , sum(f.total_amount) as Amount
FROM product as p
JOIN fact_sales as f
ON p.product_id=f.product_id
GROUP BY p.product_name;

-- Average cost per customer
SELECT c.customer_name,c.age,avg(f.total_amount) avg_cost
FROM customer as c
JOIN fact_sales as f
ON c.customer_id=f.customer_id
GROUP BY c.customer_name,c.age;

-- Customer buying certain product
SELECT p.product_name,c.customer_name,c.age
FROM
product AS p
JOIN fact_sales as f on p.product_id=f.product_id
JOIN customer as c on f.customer_id=c.customer_id
WHERE p.product_name='Milk'
GROUP BY p.product_name,c.customer_name,c.age;

-- Total cost of a customer. 
SELECT c.customer_id,c.customer_name, sum(f.total_amount) as Spent
FROM customer as c
JOIN fact_sales as f
ON c.customer_id=f.customer_id
GROUP BY c.customer_name,c.customer_id
ORDER BY Spent DESC
LIMIT 10;

-- 5 Highest sell from all the stores in a certain day 
SELECT 
SUM(f.total_amount) AS Sale , s.store_name
FROM fact_sales AS f
JOIN store AS s
ON f.store_id=s.store_id
WHERE f.date_id ='2025-01-01'
GROUP BY s.store_name
ORDER BY Sale DESC
LIMIT 5;

-- Avove code is giving 4 rows because , there are only 4 stores sale record on this day
-- To check that there are only 4 records , we have to run the below code , which will return 4 store_id
SELECT COUNT(DISTINCT store_id)
FROM fact_sales
WHERE date_id = '2025-01-01';

-- Total revenue of all the stores

SELECT
SUM(f.total_amount), s.store_name
FROM fact_sales AS f
JOIN store AS s
ON f.store_id=s.store_id
GROUP BY s.store_name;

-- Stores with revenue above average

SELECT  
     s.store_name, 
     SUM(f.total_amount) AS Revenue
FROM fact_sales AS f  
JOIN store AS s
ON f.store_id=s.store_id
GROUP BY s.store_name
HAVING Revenue > ( 
       SELECT AVG(total_amount) FROM fact_sales

);

-- Total cost of per customer
 
SELECT c.customer_name , SUM(f.total_amount) AS Cost
FROM customer AS c
JOIN fact_sales AS f
ON c.customer_id=f.customer_id
GROUP BY c.customer_name
ORDER BY Cost DESC
LIMIT 5;

-- Average spending per customer
SELECT c.customer_name , AVG(f.total_amount) AS AverageSpending
FROM customer AS c
JOIN fact_sales AS f
ON c.customer_id=f.customer_id
GROUP BY c.customer_name
LIMIT 10;

-- Revenue per product
SELECT p.product_name , SUM(f.total_amount) Revenue
FROM product p
JOIN fact_sales f
ON p.product_id = f.product_id
GROUP BY p.product_name
LIMIT 10;

-- Per day total revenue

SELECT d.day , SUM(f.total_amount)
FROM calendar d
INNER JOIN fact_sales f
ON d.date_id = f.date_id
GROUP BY d.day ;

-- Certain product quantity and its sale
SELECT
	p.product_name ,
    SUM(f.quantity) Quantity,
    SUM(f.total_amount) Revenue
FROM product p
JOIN fact_sales f  
ON p.product_id=f.product_id
GROUP BY p.product_name
LIMIT 10; 

-- Popluar product with quantity using CASE 
SELECT
  CASE
     WHEN SUM(f.total_amount) >100 THEN 'Most-Popular'
     WHEN SUM(f.total_amount) BETWEEN 50 AND 100 THEN 'Popular'
     WHEN SUM(f.total_amount) < 50 THEN 'Less Popuplar'
     ELSE 'Danger'
   END AS Popularity ,
	p.product_name ,
    SUM(f.quantity) Quantity,
    SUM(f.total_amount) Revenue
FROM product p
JOIN fact_sales f  
ON p.product_id=f.product_id
GROUP BY p.product_name
LIMIT 10;

-- Using CASE for condition 
-- Spending by age group 

SELECT
     CASE
		WHEN age < 25 THEN 'Young'
		WHEN age BETWEEN 25 AND 35 THEN 'Middle'
		ELSE 'Old'
	 END AS Age_Group,
     SUM(f.total_amount) AS Spending
FROM fact_sales AS f
JOIN customer AS c
ON f.customer_id=c.customer_id
GROUP BY  Age_Group;   

-- Window function 

WITH store_revenue AS (SELECT s.store_name , SUM(f.total_amount) AS revenue
FROM store s JOIN fact_sales f 
ON s.store_id = f.store_id
GROUP BY s.store_name),

ranked_store AS (
SELECT store_name , revenue,
      RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM store_revenue
)
SELECT * FROM ranked_store
WHERE revenue_rank <6 ;




SHOW FUNCTION STATUS
WHERE Db = 'retail_sales';


-- In MySql , we need to enable 'log_bin_trust_function_creators' to 1 otherwise function can not be created.
SHOW VARIABLES LIKE 'log_bin_trust_function_creators';

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS CustomerSpending;

DELIMITER $$

CREATE FUNCTION CustomerSpending(cus_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(total_amount)
    INTO total
    FROM fact_sales
    WHERE customer_id = cus_id;

    RETURN IFNULL(total, 0);
END$$

DELIMITER ;

-- It shows that the function is created or not 
SHOW FUNCTION STATUS WHERE Db = 'retail_sales';


-- Using own_function
SELECT customer_name , CustomerSpending(customer_id) AS total_spent
FROM customer
ORDER BY total_spent DESC
LIMIT 5;


-- Subqueries 

-- Customer who spent more then average spending

SELECT customer_name
FROM customer
WHERE customer_id IN (
     SELECT customer_id 
     FROM fact_sales
     GROUP BY customer_id
     HAVING SUM(total_amount) > 
     (SELECT AVG(total_amount) FROM fact_sales)
     
)
LIMIT 5;



-- To check that , inside IN we can not use more than one column. IN can compare 1 column at a time
SELECT customer_name
FROM customer 
WHERE customer_id IN (
SELECT c.customer_id , SUM(f.total_amount)
FROM customer c  JOIN fact_sales f
ON c.customer_id = f.customer_id
GROUP BY c.customer_id
HAVING SUM(f.total_amount)=0
) ;


-- Total sale view of all the stores using COUNT , SUM  
CREATE VIEW view_store_sales AS
SELECT
    s.store_name,
    s.province,
    COUNT(f.sale_id) AS total_sales,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN store s ON f.store_id = s.store_id
GROUP BY s.store_name, s.province;

-- Total view of all the tables.
SELECT * FROM view_store_sales;

-- Final business summary view
CREATE VIEW view_business_summary AS
SELECT
    s.province,
    COUNT(f.sale_id) AS Total_Sales,
    CAST(SUM(f.total_amount) AS DECIMAL(10, 2)) AS Total_Revenue,
    CAST(AVG(f.total_amount) AS DECIMAL(10,2)) AS Avg_Sale_Value
FROM fact_sales f
JOIN store s ON f.store_id = s.store_id
GROUP BY s.province;

SELECT * FROM view_business_summary;






     



  

     



 













