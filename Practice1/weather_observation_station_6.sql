/*
https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=false

Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

The STATION table is described as follows:

+-------------+--------------+
| Field       | Type         |
+-------------+--------------+
| ID          | NUMBER       |
| CITY        | VARCHAR2(21) |
| STATE       | VARCHAR2(2)  |
| LAT_N       | NUMBER       |
| LONG_W      | NUMBER       |
+-------------+--------------+

where LAT_N is the northern latitude and LONG_W is the western longitude.
*/
SELECT DISTINCT CITY FROM STATION
WHERE 
    (CITY LIKE 'A%' OR
    CITY LIKE 'E%' OR
    CITY LIKE 'I%' OR
    CITY LIKE 'O%' OR
    CITY LIKE 'U%' OR
    CITY LIKE 'a%' OR
    CITY LIKE 'e%' OR
    CITY LIKE 'i%' OR
    CITY LIKE 'o%' OR
    CITY LIKE 'u%');

--- USING REGEX (MySQL)
SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]' --- Use ~ instead of REGEXP in PostgreSQL
