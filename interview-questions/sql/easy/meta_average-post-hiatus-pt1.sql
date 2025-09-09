/*
Given a table of Facebook posts, for each user who posted at least twice 
in 2021, write a query to find the number of days between each user’s 
first post of the year and last post of the year in the year 2021. 

Output the user and number of the days between each user's first and last
post.
*/

SELECT 
    user_id,
    DATE_PART('day', MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE DATE_PART('year', post_date) = '2021'
GROUP BY 1
HAVING COUNT(post_date) > 1;