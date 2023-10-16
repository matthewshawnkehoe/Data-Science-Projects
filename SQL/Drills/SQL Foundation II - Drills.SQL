-- 1
SELECT DISTINCT yearbuilt
FROM houseprices;

-- 2
SELECT COUNT(DISTINCT mszoning) AS count_mszoning, COUNT(DISTINCT mssubclass ) AS count_mssubclass
FROM houseprices;

-- 3
SELECT DISTINCT street, lotshape
FROM houseprices
ORDER BY street;

-- 4
SELECT lotconfig, neighborhood, COUNT(lotconfig) AS count_lotconfig
FROM houseprices
GROUP BY neighborhood, lotconfig 
ORDER by neighborhood, count_lotconfig, lotconfig ;

-- 5
SELECT ROUND(AVG(saleprice),0)::float AS avg_saleprice, yearbuilt
FROM houseprices
GROUP BY yearbuilt
ORDER BY yearbuilt DESC;

-- 6
SELECT yearbuilt, ROUND(AVG(garagecars),0)::float as avg_garage
FROM houseprices
WHERE garagecars >= 1
GROUP BY yearbuilt;

-- 7
SELECT yearbuilt, MAX(lotarea), COUNT(*)
FROM houseprices
WHERE garagetype IS NULL
GROUP BY yearbuilt, garagetype;

-- 8
SELECT yearbuilt, AVG(lotarea)::float AS avg_lot_per_year
FROM houseprices
GROUP BY yearbuilt
HAVING AVG(lotarea)::float < 10000
ORDER BY avg_lot_per_year DESC;

-- 9
SELECT yearbuilt, COUNT(*)
FROM houseprices
WHERE lotarea BETWEEN 10000 AND 15000
GROUP by yearbuilt
ORDER BY yearbuilt;

-- 10
SELECT neighborhood, ROUND(AVG(overallqual),0)::integer AS avg_quality, COUNT(DISTINCT garagetype) AS garage_count
FROM houseprices
GROUP BY neighborhood
ORDER BY neighborhood;

-- 11
SELECT yearbuilt, ROUND(AVG(lotarea),2)::float 
FROM houseprices
WHERE street != 'Grvl'
  AND lotconfig = 'Corner'
GROUP BY yearbuilt, street, lotconfig
HAVING ROUND(AVG(lotarea),2)::float > 1000
ORDER BY yearbuilt;
