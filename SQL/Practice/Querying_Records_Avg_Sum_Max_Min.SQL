-- The query below will return the average saleprice per neighborhood and per yearbuilt. The 
-- result will be sorted by neighborhood and yearbuilt, in descending order.
SELECT ROUND(AVG(saleprice),0) AS avg_house_price, yearbuilt, neighborhood
FROM houseprices
GROUP BY yearbuilt, neighborhood
ORDER BY neighborhood, yearbuilt DESC;

SELECT ROUND(AVG(saleprice),0) AS avg_houseprice, 
	   COUNT(saleprice) AS count_houseprice, 
	   yearbuilt, 
	   neighborhood
FROM houseprices
GROUP BY yearbuilt, neighborhood
ORDER BY neighborhood, yearbuilt DESC;

-- Like COUNT, AVG doesn't include NULL values in its calculations.
SELECT AVG(lotfrontage)
FROM houseprices;

--  But what COUNT is AVG using here? Is it using the count of all records or
-- the count of nonnull lotfrontage records? You can get an answer using the statement below.
SELECT SUM(lotfrontage) AS sum_lotfrontage, 
COUNT(*) AS count_all_records,
COUNT(lotfrontage) AS count_lotfront_records,
AVG(lotfrontage) AS avg_lotfrontage
FROM houseprices;

--  In the next statement, create this metric: avg_area_per_garage_bay. This is a ratio 
-- of garagearea to garagecars for each record. You'll group this aggregation by garagetype, 
-- as shown below.
SELECT garagetype, AVG(garagearea/garagecars) AS avg_area_per_garage_bay
FROM houseprices
GROUP BY garagetype;

-- The NULLIF function takes two arguments, as shown below.
-- NULLIF(x, y)
-- If x and y are equal to each other, SQL returns a NULL. If they aren't equal, 
-- SQL returns the value of x. Therefore, you can use this function to replace any 
-- potential zeroes in the denominators with NULL values.
SELECT garagetype, AVG(garagearea/NULLIF(garagecars,0)) AS avg_area_per_garage_bay,
       yearbuilt
FROM houseprices
GROUP BY garagetype, yearbuilt
ORDER By yearbuilt;


-- SUM
-- Take a more in-depth look at the sum of lotfrontage for records where yearbuilt 
-- is less than 1980, sorted by the sum of lotfrontage, descending. 
SELECT SUM(lotfrontage) AS sum_lotfront, lotshape, street
FROM houseprices
WHERE yearbuilt < 1980
GROUP BY lotshape, street
ORDER BY sum_lotfront DESC;
-- Again, you see here that NULL isn't treated as a 0 when summing. It's its own value
-- that actually defaults to the top of the list when sorting in descending order.

-- MIN
-- Now, try a MIN operation. What is the smallest lot area for each style of roof 
-- for houses built in 1970 or later, sorted from high to low?
SELECT MIN(lotarea) AS min_lotarea, roofstyle
FROM houseprices
WHERE yearbuilt >= 1970
GROUP BY roofstyle
ORDER BY min_lotarea DESC;

-- MAX
-- Now, try a MAX operation. What's the maximum sale price for all records, grouped by 
-- the year they were sold and the style of house? Sort the output by style of house from 
-- A to Z and then by sale price from high to low.
SELECT MAX(saleprice) AS max_salesprice, yrsold, housestyle
FROM houseprices
GROUP BY yrsold, housestyle
ORDER BY housestyle, max_salesprice DESC;

