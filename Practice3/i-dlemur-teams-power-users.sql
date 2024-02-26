/*
https://datalemur.com/questions/teams-power-users

Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption:
No two users have sent the same number of messages in August 2022.

messages Table:

+-------------+--------------+
| Column Name | Type         |
+-------------+--------------+
| message_id  | integer      |
| sender_id   | integer      |
| receiver_id | integer      |
| content     | integer      |
| sent_date   | datetime     |
+-------------+--------------+
*/
SELECT sender_id, COUNT(*) AS message_count
FROM messages
WHERE sent_date BETWEEN '08/01/2022' and '09/01/2022'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
