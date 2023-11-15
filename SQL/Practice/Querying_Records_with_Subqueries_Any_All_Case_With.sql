-- Basic structure

SELECT select_list
FROM table
-- Result of the subquery is used by the "outer query"
WHERE expr operator
-- Subquery - this executes once before the main query
  (SELECT select_list
  FROM table);
  

-- Q: Who has a salary greater than Clark?

-- You need to break this problem down into two parts:
-- 1. What is Clark's salary?
-- 2. Which employees have a salary greater than Clark's salary?
-- To do this, you will place the result of the first query inside parentheses. 

-- Get the names of all employees with higher salaries than Clark's
-- Outer query—which employees have a greater salary than...
SELECT ename
FROM EMP
WHERE sal >
-- The salary assigned to Clark
  (SELECT sal
  FROM emp
  WHERE empno = 7782);
  
-- Now, consider another example. This statement will return the names,
-- job titles, and hire dates for all employees in the same department 
-- as Clark.

-- Select employee name, job title, hiredate of all employees
-- in the same department as Clark
SELECT ename, job, hiredate
FROM EMP
WHERE deptno =
-- Get Clark's department number
  (SELECT deptno
  FROM emp
  WHERE empno = 7782);
  
  
-- Subqueries and GROUP BY

-- Imagine that you want to know the employee with the highest salary 
-- in each department. Using what you learned in previous modules, your
-- answer might be something like the following:
SELECT MAX(sal), deptno
FROM emp
GROUP BY deptno;

-- This statement returns the maximum salary for each department, but 
-- it doesn't give you the name of the employee. To do that, you need to 
-- break the problem into a subquery and outer query:
-- 1. What is the maximum salary for each department number?
-- 2. What is the name associated with each department's maximum salary?
-- Your query then becomes the following:

SELECT ename, sal, deptno
FROM EMP
WHERE sal IN
  (SELECT MAX(sal)
  FROM emp
  GROUP BY deptno);
  
-- Conditional subqueries: ANY, ALL, and so forth
 
-- ANY: First, answer the following question: who are the employees with
-- a salary greater than any individual clerk? To answer in SQL, you can 
-- break this question down by using a subquery in your statement, as shown 
-- below. This time, you'll use the ANY operator to conditionally filter your results.
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ANY
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' );

-- The results here might surprise you. Why do you have salaries of clerks in 
-- the results? Didn't you ask for salaries greater than any clerk's salary? Well, 
-- yes—but that doesn't exclude those salaries of other clerks. James, Adams, and 
-- Miller, who are all clerks, have salaries greater than Smith. So they are included 
-- in the results.

-- If that's not what you are looking for, you can filter these clerks out of the
-- results with another conditional logic operator outside of the query, as shown below:
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ANY
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' )
AND job <> 'CLERK';

-- ALL: Now, take a look at the ALL operator. This time, your question is this: who
--  are the employees with a salary greater than all of the clerks?

-- In plain English, the distinction between any and all in this question is trivial.
-- But in SQL, it results in a completely different answer. To see why that is, 
-- consider the example below:
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ALL
  (SELECT sal
  FROM emp
  WHERE job = 'CLERK' );
  
-- Now, consider one more example. You want to get all employees who have a hire 
-- date before all of the managers:
SELECT ename, job, hiredate
FROM emp
WHERE hiredate < ALL
 (SELECT hiredate
  FROM emp
  WHERE job = 'MANAGER' );
  
-- The hire date of the longest-tenured manager, Jones, is April 2, 1981. So 
-- the above query returns the employees with a hire date before then.

-- What about with an ANY operator?
SELECT ename, job, hiredate
FROM emp
WHERE hiredate < ANY
 (SELECT hiredate
  FROM emp
  WHERE job = 'MANAGER' );
  
-- This time, you get all records with a start date before that of any 
-- manager—including other managers.

-- CASE: The CASE operator works similar to IF/THEN logic. You can use
--  it to create temporary fields which help you aggregate the data. A 
-- basic CASE structure looks something like the example below:
CASE selector
  WHEN condition THEN statement
  WHEN condition THEN statement
  ELSE statement
END;

-- This is very common, for example, if you want to assign ordinal 
-- rankings to a field.
SELECT empno, ename, sal,
-- Case statement: map conditions to values of the corresponding field
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW'
END
FROM emp;

-- Similarly to other calculated fields, you can assign an alias to 
-- your CASE statement.
SELECT empno, ename, sal,


-- Case statement: map conditions to values of the corresponding field
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW'
END as salary_level
FROM emp;

-- ORDER BY CASE: Just as with other calculated fields, you cannot ORDER BY 
-- the alias of a CASE statement. Instead, you have to rewrite the statement 
-- in both SELECT and ORDER BY clauses:
SELECT empno, ename, sal,
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW' END
FROM emp
ORDER BY CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW' 
        END ASC;
		
-- This is a nuisance, and fortunately, there's a way to get around it. 
-- You can refer to a field by its ordinal position inside the table. For example,
-- your CASE statement is the fourth field in the SELECT clause, so you can ORDER
-- BY the number 4.		
SELECT empno, ename, sal,
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW'
END as salary_level
FROM emp
-- Order by ordinal indexing in the SELECT clause
ORDER BY 4;

-- This sorts your salary_level alphabetically, from High to Low to Medium. 
-- That's probably not what you want, so you would want to do something to
-- adjust this, perhaps by renaming the levels. Next, sort by salary_level and then sal, descending:
SELECT empno, ename, sal,
CASE
        WHEN sal >= 2000 THEN 'HIGH'
        WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
        ELSE 'LOW'
END as salary_level
FROM emp
ORDER BY 4, 3 DESC;

-- CASE and aggregations: CASE statements are also handy in slicing the data 
-- into separate fields. For example: what is the average salary for employees 
-- hired before and after January 1, 1982?

-- For this, you need to somehow split the data into employees hired before
-- and after January 1, 1982. Then, you'll take the average salary for each 
-- bucket. You can do this with two CASE statements. Each will return the 
-- average salary, conditional for your hire date constraint.
SELECT 
AVG(CASE WHEN hiredate < '1981-12-31' THEN sal END) AS oldhiresal,
AVG(CASE WHEN hiredate > '1982-01-01' THEN sal END) AS newhiresal
FROM emp;

-- Using a more complex CASE statement, you can do the same to get 
-- percentages of records that meet some criteria. Imagine that you 
-- want to find the percentage of employees in each category with 
-- salaries greater than $1,000. By converting the corresponding 
-- records to 1 and 0 values, you can take an average—which results 
-- in a group percentage.
SELECT job,
AVG(CASE WHEN sal < 999 THEN 1 WHEN sal > 1000 THEN 0 END) AS pct_lt1000,
AVG(CASE WHEN sal < 999 THEN 0 WHEN sal > 1000 THEN 1 END) AS pct_gt1000
FROM emp
GROUP BY job;
