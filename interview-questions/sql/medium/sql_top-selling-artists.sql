/*
As the lead data analyst for a prominent music event management company, 
you have been entrusted with a dataset containing concert revenue and 
detailed information about various artists.
Your mission is to unlock valuable insights by analyzing the concert 
revenue data and identifying the top revenue-generating artists within 
each music genre.

Write a query to rank the artists within each genre based on their revenue
per member and extract the top revenue-generating artist from each genre. 
Display the output of the artist name, genre, concert revenue, number of 
members, and revenue per band member, sorted by the highest revenue per
member within each genre.
*/

-- Step 1: Calculating Revenue per Member and Ranking Concerts within Each Genre
-- CTE
WITH ranked_concerts_cte AS (
SELECT 
    artist_name,
    concert_revenue,
    genre, 
    number_of_members,
    (concert_revenue / number_of_members) AS revenue_per_member
    RANK() OVER (
        PARTITION BY genre
        ORDER BY (concert_revenue / number_of_members) DESC) AS ranked_concerts
FROM concerts
)

SELECT * FROM ranked_concerts_cte

-- Subquery
SELECT
  artist_name,
  concert_revenue,
  genre,
  number_of_members,
  (concert_revenue / number_of_members) AS revenue_per_member,
  RANK() OVER (
    PARTITION BY genre
    ORDER BY (concert_revenue / number_of_members) DESC) AS ranked_concerts
FROM concerts;

-- Step 2: Selecting the Top-Selling Artists within Each Genre
-- CTE
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

-- Subquery
SELECT
  artist_name,
  concert_revenue,
  genre,
  number_of_members,
  revenue_per_member
FROM (
  -- Subquery Result
  SELECT
    artist_name,
    concert_revenue,
    genre,
    number_of_members,
    (concert_revenue / number_of_members) AS revenue_per_member,
    RANK() OVER (
      PARTITION BY genre
      ORDER BY (concert_revenue / number_of_members) DESC) AS ranked_concerts
  FROM concerts) AS subquery
WHERE ranked_concerts = 1
ORDER BY revenue_per_member DESC;