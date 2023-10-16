--  yearbuilt is greater than 1950
SELECT COUNT(*)
FROM houseprices
WHERE yearbuilt > 1950;

-- Return all unique values for yearbuilt in which yearbuilt is 
-- greater than 1950. In other words, you'll get no duplicates
SELECT DISTINCT yearbuilt
FROM houseprices
WHERE yearbuilt > 1950;

--  List the unique combinations of different records' values
SELECT DISTINCT yearbuilt, neighborhood
FROM houseprices;

-- But this next statement will not execute. 
-- This is because you can't get a unique list for two different fields at once.
SELECT DISTINCT yearbuilt, DISTINCT neighborhood
FROM houseprices;

-- What can you do to resolve this error? 
-- One approach is to aggregate the aggregation by using COUNT(DISTINCT).

-- COUNT(DISTINCT)
-- Although you can't get the separate unique value lists of yearbuilt and neighborhood 
-- at the same time, you can get the count of unique values for each. It's a subtle difference. 
-- In the statement below, you're counting all of the unique values, rather than listing them.
SELECT COUNT(DISTINCT yearbuilt), COUNT(DISTINCT neighborhood)
FROM houseprices;

-- It's important to note that SQL aggregations are sensitive to changes in a WHERE clause. 
-- You'll get fewer results with the following command than with the one above, for example
SELECT COUNT(DISTINCT yearbuilt), COUNT(DISTINCT neighborhood)
FROM houseprices
WHERE yearbuilt < 2000 AND neighborhood NOT LIKE 'G%';

-- Using aggregates and nonaggregates together
-- COUNT and DISTINCT can be used together seamlessly. But using the SELECT operator on an 
-- aggregate and a nonaggregate in the same statement will lead to problems.
SELECT COUNT(neighborhood), yearbuilt
FROM houseprices;

-- SOLUTION 1: Aggregate them both
-- Remember, it's possible to COUNT by individual records in one statement, as shown below.
SELECT COUNT(neighborhood), COUNT(yearbuilt)
FROM houseprices;

-- SOLUTION 2: Group the aggregated field by the other field
-- Imagine that you wanted to count how many unique yearbuilt values existed for each neighborhood.
SELECT neighborhood, COUNT(DISTINCT(yearbuilt))
FROM houseprices
GROUP BY neighborhood;

-- The count of yearbuilt is now grouped by neighborhood. In SQL, having an aggregated field
-- grouped by another field requires an aptly named special statement: GROUP BY.

-- GROUP BY is essentially the missing link between the aggregate and nonaggregate fields 
-- in SELECT BY. If a field isn't aggregated in SELECT, it needs to be summarized with a GROUP BY.

-- THIRD SOLUTION
SELECT COUNT(neighborhood), yearbuilt
FROM houseprices
GROUP BY yearbuilt;

-- It's also possible to reorder the way that the output appears. You can do that by aliasing 
-- and rewriting the SELECT clause, as shown below.
SELECT yearbuilt AS yearbuilt, COUNT(neighborhood) AS number_of_neighborhoods
FROM houseprices
GROUP BY yearbuilt;

-- In a previous lesson, you used COUNT(*) with WHERE to return a count of all the records 
-- in which saleprice is above 100,000 and yearbuilt is less than 1950
SELECT COUNT(*)
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950;

-- Using these same criteria together with GROUP BY, you can group this 
-- COUNT aggregation by the number of records per neighborhood.
SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood;

-- You can, of course, sort this output alphabetically, as shown below. 
-- Remember, ORDER BY follows GROUP BY.
SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY neighborhood;

-- GROUP BY and aliasing
-- What if you want to sort from high to low instead of alphabetically?
-- This might not be intuitive, but it's perfectly acceptable to use an aggregate 
-- in an ORDER BY clause, as shown below.
SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY COUNT(*);

-- However, it's far more common to accomplish this by using an alias.
-- So it's good data hygiene to use an alias anyway. But there's more to 
-- it than that. Once defined, an alias can be referred to later on in 
-- the statement. So the statement above becomes the following:
SELECT COUNT(*) AS count_houses, neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY count_houses DESC;

-- GROUP BY multiple fields
-- Say, for example, that you want to get a count of records by year, sorted 
-- in descending order. You could do the following:
SELECT COUNT(*), yearbuilt
FROM houseprices
GROUP BY yearbuilt
ORDER BY yearbuilt DESC;

--  Wouldn't it be nice to break this count into records by both yearbuilt and 
-- housestyle? In the statement below, a third field goes into the SELECT clause, 
-- and a second field goes into the GROUP BY clause
SELECT COUNT(*), yearbuilt, housestyle
FROM houseprices
GROUP BY yearbuilt, housestyle
ORDER BY yearbuilt DESC;

-- And just like with other SQL statements, you can rearrange the ordering of 
-- fields and re-sort the ordering of records.
SELECT yearbuilt, housestyle, COUNT(*)
FROM houseprices
GROUP BY yearbuilt, housestyle
ORDER BY yearbuilt DESC, housestyle;

-- COUNT multiple fields
-- You may have noticed that the alley field is sparsely populated. What happens 
-- when you want to group both a count of alley and a count of all records, and 
-- order by a count of alley in ascending order?
SELECT COUNT(*) AS count_records, COUNT(alley) AS count_alleys, neighborhood
FROM houseprices
GROUP BY neighborhood
ORDER BY count_alleys ASC;

-- Other than that, including additional COUNT clauses in a query is straightforward.
SELECT COUNT(*) AS count_records, COUNT(alley) as count_alleys, neighborhood
FROM houseprices
WHERE yearbuilt > 1990
GROUP BY neighborhood
ORDER BY count_alleys DESC;

-- COUNT and GROUP BY multiple fields
-- For example, try getting a count of all records (*) and a count of alley, 
-- grouped by neighborhood, sorted ascending, and street.
SELECT COUNT(*) AS count_records, COUNT(alley) as count_alleys, neighborhood, street
FROM houseprices
GROUP BY neighborhood, street
ORDER BY neighborhood;

-- COUNT and GROUP BY the same field
-- The houseprices table has a roofstyle field and a neighborhood field. 
-- How would you go about creating a list of roof styles in each neighborhood 
-- and a count of those roof styles?

-- Try 1
SELECT COUNT(roofstyle), neighborhood
FROM houseprices
GROUP BY neighborhood;

-- What if you used SELECT COUNT DISTINCT to get a count of unique roof styles in each neighborhood?
SELECT COUNT (DISTINCT roofstyle), neighborhood
FROM houseprices
GROUP BY neighborhood;

-- But what you really want is a COUNT of roofstyle records grouped by roofstyle. So, 
-- incorporating that into your statement, you have the following:
SELECT COUNT (roofstyle), neighborhood
FROM houseprices
GROUP BY neighborhood, roofstyle;

-- Amazing! You can GROUP BY the same field that you used for the aggregation itself.
-- Here is an example. To get a count of roofstyle and to group by unique roof styles 
-- per neighborhood, you can use the following statement:
SELECT neighborhood, roofstyle, COUNT(roofstyle) AS count_roofstyle
FROM houseprices
GROUP BY roofstyle, neighborhood
ORDER BY neighborhood, roofstyle, count_roofstyle;

-- Video Lecture
SELECT start_year AS release_year, 
	   COUNT(DISTINCT movie_id) as movie_id, 
	   COUNT(DISTINCT genres) as genres,
	   ROUND(AVG(runtime_minutes)) as runtime
FROM movies
WHERE title_type = 'movie'
	AND start_year BETWEEN 1960 AND 2019
GROUP BY start_year