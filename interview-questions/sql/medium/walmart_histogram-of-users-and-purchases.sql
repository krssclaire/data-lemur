/*
Assume you're given a table on Walmart user transactions. Based on their 
most recent transaction date, write a query that retrieve the users along
with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number 
of products, sorted in chronological order by the transaction date.
*/

WITH most_recent_date_per_user AS (
    SELECT
        *,
        MAX(transaction_date) OVER(
            PARTITION BY user_id
        ) AS most_recent_date
    FROM user_transactions
)

SELECT 
    most_recent_date,
    user_id,
    COUNT(user_id) AS purchase_count
FROM most_recent_date_per_user
WHERE most_recent_date = transaction_date
GROUP BY 1,2;
