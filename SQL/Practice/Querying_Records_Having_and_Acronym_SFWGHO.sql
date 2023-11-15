-- Return a table listing the average sale price of a home sold in the year 2010, grouped by 
-- neighborhood and sorted by average sales price from high to low.
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
ORDER BY avg_saleprice DESC;

-- But with this list, how would you get the top five records? Add a LIMIT cause!
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
ORDER BY avg_saleprice DESC
LIMIT 5;

-- What if you want to get all of the records in which the average sale price is above $200,000? 
-- You need some way to filter your aggregated results. This is where HAVING comes in. 
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
HAVING ROUND(AVG(saleprice),0) > 200000  -- Filter the AGGREGATED RESULTS!
ORDER BY avg_saleprice DESC

-- Some database management systems, including PostgreSQL, do not support alias usage in the HAVING clause. 
-- Any field used in HAVING must either appear in the GROUP BY clause or be used in an aggregate function. 
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
GROUP BY neighborhood
HAVING yrsold = 2010       -- Not in GROUP_BY or aggregated!
ORDER BY avg_saleprice DESC;

-- But again, you can't filter by a field that doesn't exist in the aggregated results, can you? 
-- So that makes sense. Instead, you can use this query:
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
ORDER BY avg_saleprice DESC;

-- Clause recap: SFWGHO
Sweaty SELECT
Feet   FROM
Will   WHERE
Give   GROUP BY
Horrible HAVING
Odors  ORDER BY

-- All clauses!
SELECT ROUND(AVG(saleprice),0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
HAVING ROUND(AVG(saleprice),0) > 200000
ORDER BY avg_saleprice DESC;

-- Return a table listing the maximum lot area and mszoning of a home sold after 1950,
-- grouped by mszoning, having a lot area greater than 10,000, and ordered by maximum
-- lot area.
SELECT MAX(lotarea) AS max_lotarea, mszoning
FROM houseprices
WHERE yearbuilt > 1950
GROUP BY mszoning
HAVING MAX(lotarea) > 10000
ORDER BY max_lotarea DESC;
