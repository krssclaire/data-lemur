/* JOIN */
SELECT 
  orders.order_id, 
  orders.customer_id, 
  goodreads.book_title, 
  orders.quantity
FROM goodreads
INNER JOIN orders
  ON goodreads.book_id = orders.book_id -- Columns with same data type (integer)
WHERE goodreads.price >= 20;

/* Conditional SQL joins */
SELECT 
  g.book_title, 
  o.quantity
FROM goodreads AS g
INNER JOIN orders AS o 
  ON g.book_id = o.book_id
    AND o.quantity > 2;

SELECT 
  o.order_id, 
  d.delivery_status
FROM orders AS o
INNER JOIN deliveries AS d 
  ON o.order_id = d.order_id
    AND d.delivery_status IN ('Delivered', 'Shipped');

SELECT 
  g.book_title, 
  g.author, 
  o.order_date
FROM goodreads AS g
INNER JOIN orders AS o 
  ON g.book_id = o.book_id
    AND g.year_released > 2015
    AND o.quantity > 1;

SELECT 
  g.book_title, 
  g.book_rating, 
  o.order_date, 
  d.delivery_status
FROM goodreads g
JOIN orders o 
  ON g.book_id = o.book_id
    AND g.book_rating > 4.0
INNER JOIN deliveries d 
  ON o.order_id = d.order_id
    AND d.delivery_status = 'Delivered';

SELECT
  character
  CASE
    WHEN f = 5 THEN 'Highly popular'
    ELSE 'Less popular'
  END AS popularity_category
FROM marvel_table


