/*
Write a query to identify the top 2 Power Users who sent the highest 
number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages 
they sent. 
Output the results in descending order based on the count of the messages.

Assumption:
No two users have sent the same number of messages in August 2022.
*/

SELECT 
  sender_id, 
  COUNT(message_id) AS msg_sent_count
FROM messages
WHERE DATE_PART('month', sent_date) = '08' AND DATE_PART('year', sent_date) = '2022' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 2;