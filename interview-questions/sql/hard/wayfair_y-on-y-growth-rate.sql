/*
Assume you're given a table containing information about Wayfair user 
transactions for different products. 
Write a query to calculate the year-on-year growth rate for the total 
spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, 
current year's spend, previous year's spend and year-on-year growth 
percentage, rounded to 2 decimal places.

To calculate the year-on-year growth rate, we compare the current year's
spend with the previous year's spend.
For instance, the spend grew by 24.62% from 2020 to 2021, indicating a 
positive growth rate.
*/

WITH test AS (
  SELECT
    EXTRACT(year FROM transaction_date) AS year,
    product_id, 
    spend AS current_year_spend
  FROM user_transactions
  ORDER by year
)

SELECT 
  *,
  LAG(current_year_spend) OVER (
      PARTITION BY product_id
      ORDER BY year
    ) AS  previous_year_spend,
    ROUND(((current_year_spend - LAG(current_year_spend) OVER (PARTITION BY product_id ORDER BY year)) / LAG(current_year_spend) OVER (PARTITION BY product_id ORDER BY year)) * 100, 2) AS yoy_growth_rate
FROM test
