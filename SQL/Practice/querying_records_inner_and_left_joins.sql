SELECT * FROM emp
SELECT * FROM dept

-- INNER JOIN

-- Add JOIN operator to FROM clause
SELECT * 
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

-- INNER JOIN is the default type of join in PostgreSQL
SELECT * 
FROM emp JOIN dept
ON emp.deptno = dept.deptno;
-- There are two deptno fields in the JOIN, so it is repeated!

-- Explicit syntax

-- Return the empno, ename, and deptno fields from the emp table. 
SELECT empno, ename, deptno
FROM emp;

-- Prefix which table to grab from!
SELECT emp.empno, emp.ename, emp.deptno
FROM emp;

-- How to handle two tables with the same field name!
SELECT empno, ename, emp.deptno, dname
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;

-- LEFT OUTER JOIN
-- Q: Which table is A and which table is B?

-- Get an extra field (Includes empno 7694, COOK, with a empty value in dname - no match in lookup table)
-- No match of 50 in the dept table
SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;

-- Reverse the order, LEFT OUTER JOIN on dept 
SELECT empno, ename, emp.deptno, dname
FROM dept LEFT OUTER JOIN emp
ON emp.deptno = dept.deptno;
-- Returns all fields from dept, irregardless if they match something in emp

-- Now, consider another important point about LEFT OUTER JOIN: it is most logical to SELECT
-- the matching field in the table that you are going to LEFT OUTER JOIN on

-- Ex 1
SELECT empno, ename, dept.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;

-- Ex 2 (Makes more sense)
SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;
-- OR
SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON dept.deptno = emp.deptno;