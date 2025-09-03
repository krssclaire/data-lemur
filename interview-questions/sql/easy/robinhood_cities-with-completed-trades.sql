/*
Assume you're given the tables containing completed trade orders and user 
details in a Robinhood trading system.
Write a query to retrieve the top three cities that have the highest 
number of completed trade orders listed in descending order. 
Output the city name and the corresponding number of completed trade orders.
*/

SELECT users.city,
       COUNT(trades.order_id) AS total_orders
FROM trades
JOIN users
    ON trades.user_id = users.user_id
WHERE trades.status = 'Completed'
GROUP BY users.city
ORDER BY 2 DESC
LIMIT 3;