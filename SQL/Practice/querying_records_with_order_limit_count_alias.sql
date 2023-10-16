-- ORDER BY
-- The ORDER BY statement sorts all selected fields based on the value of one or more fields. 
-- ORDER BY always follows WHERE in a command. (Or, if WHERE isn't part of the query, 
-- it follows SELECT … FROM.)

-- The statement below, for example, sorts the houseprices table based on the lotarea field.
SELECT *
FROM houseprices
ORDER BY lotarea;

-- Now, take the same query as above but adjust it to sort by lotarea in descending order.
SELECT *
FROM houseprices
ORDER BY lotarea DESC;

-- You can also specify where you want the NULL values to be: NULLS FIRST or NULLS LAST.
SELECT *
FROM houseprices
ORDER BY lotarea DESC
NULLS LAST;

-- ORDER BY A to Z

-- ORDER BY also works on character fields and can sort alphabetically. For example, 
-- try sorting all records in the houseprices table by the mszoning field.
SELECT *
FROM houseprices
ORDER BY mszoning;

-- and similarly, descending
SELECT *
FROM houseprices
ORDER BY mszoning DESC;

-- ORDER BY multiple fields
-- Sort multiple fields at once
SELECT yearbuilt, saleprice
FROM houseprices
ORDER BY yearbuilt, saleprice DESC;

-- Each field is ordered individually. If you want both yearbuilt and saleprice sorted 
-- in descending order, you need to add the DESC operator after each field
SELECT yearbuilt, saleprice
FROM houseprices
ORDER BY yearbuilt DESC, saleprice DESC;

-- The order that fields appear in the ORDER BY clause will affect the result. 
-- So try changing it up. Rather than sorting by yearbuilt and then saleprice, 
-- sort by saleprice and then yearbuilt. Continue to sort both in descending order.
SELECT yearbuilt, saleprice
FROM houseprices
ORDER BY saleprice DESC, yearbuilt DESC;