/*
https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to:

- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
 

Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 

*/

(SELECT name AS results FROM Users AS a
JOIN MovieRating AS b
ON a.user_id = b.user_id
GROUP BY a.user_id
ORDER BY COUNT(*) DESC, name
LIMIT 1)

UNION ALL

(SELECT title FROM Movies AS a1
JOIN MovieRating AS b1
ON a1.movie_id = b1.movie_id
WHERE EXTRACT(month FROM created_at) = 2 AND EXTRACT(year FROM created_at) = 2020
GROUP BY a1.movie_id, title
ORDER BY AVG(rating) DESC, title
LIMIT 1)




