/*
A Microsoft Azure Supercloud customer is defined as a customer who has 
purchased at least one product from every product category listed in the 
products table.

Write a query that identifies the customer IDs of these Supercloud 
customers.
*/

-- Group customers and count how many products_category they spent on
WITH customer_products_category_cte AS (
    SELECT 
        c.customer_id,
        COUNT(DISTINCT(p.product_category))
    FROM customer_contracts c
    FULL JOIN products p
        ON c.product_id = p.product_id 
    GROUP BY 1
    ORDER BY 1 DESC
)

-- Select customers who spent on all thre categories
SELECT customer_id
FROM customer_products_category_cte
WHERE count = 3





----
WITH ranked_concerts_cte AS (
  SELECT
    artist_name,
    concert_revenue,
    genre,
    number_of_members,
    (concert_revenue / number_of_members) AS revenue_per_member,
    RANK() OVER (
      PARTITION BY genre
      ORDER BY (concert_revenue / number_of_members) DESC) AS ranked_concerts
  FROM concerts
)

SELECT
  artist_name,
  concert_revenue,
  genre,
  number_of_members,
  revenue_per_member
FROM ranked_concerts_cte
WHERE ranked_concerts = 1
ORDER BY revenue_per_member DESC;


/*
compute
containers
analytics
*/