-- Getting a feel for the hacker_news table! --
-- Finding the most popular Hacker News stories --

SELECT title, score
FROM hacker_news
ORDER BY score DESC
LIMIT 5;

-- Finding the total score of all the stories --

SELECT SUM(score)
FROM hacker_news;

-- Finding the individual users who have gotten combined scores of more than 200 --
-- and their combined scores --

SELECT user, SUM(score)
FROM hacker_news
GROUP BY user
HAVING SUM(score) > 200
ORDER BY 2 DESC;

-- Adding the users' scores together and dividing by the total to get the percentage --

SELECT (517 + 309 + 304 + 282) / 6366.0;

-- finding users that have posted a url for rickrolling! --

SELECT user, 
  COUNT(*)
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ'
GROUP BY user
ORDER BY COUNT(*) DESC;

-- Hacker News stories are essentially links that take users to other websites --
-- So, I want to find the site that feeds Hacker News the most --

SELECT CASE
    WHEN url LIKE '%github.com%' THEN 'GitHub'
    WHEN url LIKE '%medium.com%' THEN 'Medium'
    WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
    ELSE 'Other'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY 1;

-- taking a look at the timestamp column --

SELECT timestamp
FROM hacker_news
LIMIT 10;

-- So, SQLite comes with a strftime() function -- 
-- a very powerful function that allows me to return a formatted date --
-- The function takes two arguments, format and column --

SELECT timestamp,
  strftime('%H', timestamp)
FROM hacker_news
GROUP BY 1
LIMIT 20;

-- Now that I understand how the function, strftime(), works --
-- this query will return three columns --
-- The hours of the timestamp --
-- The average score for each hour --
-- The count of stories for each hour --

SELECT strftime('%H', timestamp),
  AVG(score),
  COUNT(*)
FROM hacker_news
GROUP BY 1
ORDER BY 2 DESC;

-- Editing a few things from the previous query --
-- Rounding the average scores --
-- Renaming the columns to make it more readable --
-- Adding a WHERE clause to filter out the NULL values in timestamp --

SELECT strftime('%H', timestamp) AS 'Hour',
  ROUND(AVG(score)) AS 'AVG Score',
  COUNT(*) AS '# of Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;