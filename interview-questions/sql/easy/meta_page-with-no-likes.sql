/*
Assume you're given two tables containing data about Facebook Pages and 
their respective likes (as in "Like a Facebook Page").
Write a query to return the IDs of the Facebook pages that have zero likes. 
The output should be sorted in ascending order based on the page IDs.
*/

SELECT p.page_id
FROM pages p
FULL OUTER JOIN page_likes l
  ON p.page_id = l.page_id
WHERE l.user_id IS NULL
ORDER BY 1;