-- When it comes down to it, JOIN is just part of a glorified FROM clause. 
-- And you can still filter the results with WHERE, as shown in the example below.
SELECT * FROM emp
SELECT * FROM dept -- locno 50, 60, 70
SELECT * FROM dept2 --locno 60

SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
WHERE mgr = 7698;

-- You can even use it with aggregates! 
-- Here, you're taking the sum of salaries, grouped by the department number and name.
SELECT emp.deptno, dname, SUM(sal)
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
GROUP BY emp.deptno, dname;

-- Go Crazy and use ALL CLAUSES
SELECT emp.deptno, dname, SUM(sal) AS dept_salary
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
WHERE empno BETWEEN 7500 AND 8000
GROUP BY emp.deptno, dname
HAVING SUM(sal) > 3000
ORDER BY dname;

-- UNION
-- Connect two separate SELECT BY clauses together with UNION.
-- You'll often see the SELECT and FROM clauses on the same line when used with UNION.
-- This is a stylistic decision. 

SELECT deptno, dname, locno FROM dept
UNION
SELECT deptno, dname, locno FROM dept2;

-- OR (use wildcard(*) to get the same results as those are all the fields in dept and dept2)
SELECT * FROM dept
UNION
SELECT * FROM dept2;

-- OR, just return a subset of the fields
SELECT deptno, dname FROM dept
UNION
SELECT deptno, dname FROM dept2;

-- With UNION, the resulting table can include or exclude duplicate records. 
-- The difference comes from using UNION ALL or UNION, respectively.

-- But there are duplicate records in the locno field: 50 and 60 are each repeated twice. 
-- So if you're returning just locno, you'll need UNION ALL to return all records. 
SELECT locno FROM dept
UNION ALL
SELECT locno FROM dept2; 

-- Somewhat like SELECT DISTINCT, this operation will remove any duplicates that exist 
-- in the resulting "united" dataset.
SELECT locno FROM dept
UNION
SELECT locno FROM dept2;

-- UNION can be used in a statement with additional clauses. Although this could include 
-- GROUP BY aggregations, you're most likely to see UNION with WHERE and ORDER BY.
-- For example, imagine that you want to exclude any departments that have a locno of 50
SELECT * FROM dept
WHERE locno <> 50
UNION
SELECT * FROM dept2
WHERE locno <> 50; 

-- This can even be used in conjunction with ORDER BY. But, as usual, that clause comes last.
SELECT * FROM dept
WHERE locno <> 50
UNION
SELECT * FROM dept2
WHERE locno <> 50
ORDER BY deptno; 
