-- Houses built in 2003
SELECT *
FROM houseprices
WHERE yearbuilt = 2003;

-- Houses with paved streets
SELECT * 
FROM houseprices
WHERE street = 'Pave';

-- Year remodeled is the same as year built
SELECT *
FROM houseprices
-- Here, yearbuilt has no quotes because it is an object identifier (field name), not a criterion.
WHERE yearremodadd = yearbuilt

-- Case sensitive, 'Pave' will return records while 'pave' will not
SELECT *
FROM houseprices
WHERE street = 'Pave';

-- You can even filter by fields that aren't included in your SELECT statement
SELECT yearbuilt, saleprice
FROM houseprices
WHERE lotarea < 8000;

-- Return all records from the houseprices table where lotarea is greater 
-- than 10,000 and yearbuilt is less than or equal to 1995
SELECT *
FROM houseprices
WHERE lotarea > 10000 AND yearbuilt <= 1995;

--  retrieve any records in which either lotarea is greater than 10,000 
-- or yearbuilt is less than or equal to 1995
SELECT *
FROM houseprices
WHERE lotarea > 10000 OR yearbuilt <= 1995;

-- You can also use multiple OR operators on the same field.
-- With the following statement, you'll look for records where yearbuilt is equal to 1995 or 1996
SELECT *
FROM houseprices
WHERE yearbuilt = 1995 OR yearbuilt = 1996;

-- Note, however, that each OR condition needs to respecify the field. 
-- In other words, the following query isn't valid.
SELECT *
FROM houseprices
WHERE yearbuilt = 1995 OR 1996;

-- For example, practice returning all fields from records where yearbuilt is either 1995 
-- or 1996 and roofstyle is either Gable or Hip.
-- For this statement, place each set of criteria to be evaluated together in parentheses.
SELECT *
FROM houseprices
WHERE (yearbuilt = 1995 OR yearbuilt = 1996)
AND (roofstyle = 'Gable' OR roofstyle = 'Hip');

-- For example, imagine that you want to return all records where yearbuilt is between 1995 
-- and 2000. You can do this in a few different ways.
-- Bad way
SELECT *
FROM houseprices
WHERE yearbuilt = 1995 OR yearbuilt = 1996 OR yearbuilt = 1997 OR yearbuilt = 1998 
OR yearbuilt = 1999 OR yearbuilt = 2000;

-- Better way
SELECT *
FROM houseprices
WHERE yearbuilt >= 1995 AND yearbuilt <= 2000;

-- Even better
SELECT *
FROM houseprices
WHERE yearbuilt BETWEEN 1995 AND 2000;

-- WHERE ... IN allows you to filter by multiple criteria at once. But instead of evaluating 
-- a range, WHERE … IN evaluates a group of individual items enclosed in parentheses.

-- For example, write a query to return all records where yearbuilt is either 2001, 2007, 2008, 
-- or 2009, as shown below.
SELECT * 
FROM houseprices
WHERE yearbuilt IN(2001, 2007, 2008, 2009);

-- Also works on character fields
SELECT * 
FROM houseprices
WHERE roofstyle IN('Gable','Hip','Mansard');

-- A WHERE ... NOT operator returns all records that do not evaluate to TRUE. 
-- This is particularly useful with IN and BETWEEN operators.

-- For example, the statement below returns all records outside of the range 1995 and 2000. 
SELECT *
FROM houseprices
WHERE yearbuilt NOT BETWEEN 1995 AND 2000;

--  This statement returns all records in which roofstyle isn't Gable, Hip, or Mansard
SELECT *
FROM houseprices
WHERE roofstyle NOT IN('Gable', 'Hip', 'Mansard');

-- In databases, not all blanks are created equal. NULL is a keyword used in SQL to signify 
-- values that are either missing or unknown. This is not the same as a blank string (" ") 
-- or a record value of 0.

--  For example, try returning all records in the houseprices table in which the value of 
-- alley is recorded as NULL.
SELECT *
FROM houseprices
WHERE alley IS NULL;

-- On the other hand, a WHERE ... IS NOT NULL statement returns all records that don't return a NULL.
SELECT *
FROM houseprices
WHERE alley IS NOT NULL;

-- SQL includes several search wildcards. These are characters that are used as substitutes for 
-- other characters in a string. If this sounds foreign to you, think back to the asterisk * 
-- character that you've been using to SELECT all fields from a table. When SQL sees an asterisk, 
-- it knows to replace the asterisk with all of the fields in the table.

-- a%, abc%: Returns records that start with a, abc
-- _a, __abc: Returns records with a in second position, abc in third position

-- Example: The heating field of the houseprices table contains two types of gas records: 
-- GasA and GasW. Using the percentage wildcard % with WHERE ... LIKE
SELECT *
FROM houseprices
WHERE heating LIKE 'Gas%';


-- The heating field also contains records with the value OthW. This time, you want to search for
-- all records with a W in the fourth character of the heating field.
SELECT *
FROM houseprices
WHERE heating LIKE '___W';

--Keep in mind that the above query will not return records that contain characters after the W. 
-- To do that, you'd add the wildcard %, as in ___W%.

-- Return all records where mszoning starts with 'R'
SELECT *
FROM houseprices
WHERE mszoning ILIKE 'r%';

-- Not case sensitive to field names in a table
SELECT MSZONING
FROM houseprices;

-- Same output
SELECT mszoning
FROM houseprices; 

-- The following query, by contrast, has a quoted uppercase r:
SELECT *
FROM houseprices
WHERE mszoning LIKE 'R%';

-- Fortunately, PostgreSQL includes an easy operator to adjust for this confusing distinction: ILIKE.
-- Now, these both return  the same result
SELECT *
FROM houseprices
WHERE mszoning ILIKE 'r%';

SELECT *
FROM houseprices
WHERE mszoning ILIKE 'R%';

-- You can also use ILIKE separately from wildcards.
SELECT *
FROM houseprices
WHERE mszoning ILIKE 'Rl';

-- Each individual search string must be preceded by an ILIKE.
SELECT *
FROM houseprices
WHERE mszoning ILIKE 'rl' OR mszoning ILIKE 'Rm';

-- Combine Multiple Operators
-- To get a sense of what combining multiple operators can look like, consider a statement 
-- like the one below. When you have a statement with many WHERE clauses like this, 
-- it's helpful to move each operator to its own indented line.
SELECT saleprice, salecondition
FROM houseprices
WHERE yearbuilt BETWEEN 1980 AND 1985
    AND roofstyle = 'Gable'
    AND alley IS NOT NULL
AND neighborhood NOT IN ('NAmes', 'CollgCr');

-- More stuff by changing the last line to OR
SELECT saleprice, salecondition
FROM houseprices
WHERE yearbuilt BETWEEN 1980 AND 1985
    AND roofstyle = 'Gable'
    AND alley IS NOT NULL
OR neighborhood NOT IN ('NAmes', 'CollgCr');

-- Video Lesson
SELECT *
FROM movies
WHERE runtime_minutes BETWEEN 80 AND 180  -- Use between instead of multiple AND clauses
	AND start_year in (2008, 2019)        -- Use in for multiple OR clauses
	AND primary_title ILIKE '%doubt%'     -- Use ILIKE for case insensitive searching
LIMIT 20;