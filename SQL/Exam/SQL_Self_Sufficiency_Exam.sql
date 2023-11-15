SELECT * FROM finance
SELECT * FROM naep
SELECT * FROM state_stats

-- Question 1
SELECT column_name, data_type 
FROM INFORMATION_SCHEMA.COLUMNS 
where table_name = 'neap'

-- Question 2
SELECT * FROM neap
LIMIT 50;

-- Question 3
SELECT state, COUNT(avg_math_4_score) as count_4,
       AVG(avg_math_4_score) as avg_4,
       MIN(avg_math_4_score) as min_4,
       MAX(avg_math_4_score) as max_4
FROM naep
GROUP BY state
ORDER BY state;

-- Question 4
SELECT state, COUNT(avg_math_4_score) as count_4, 
       AVG(avg_math_4_score) as avg_4, 
       MIN(avg_math_4_score) as min_4, 
       MAX(avg_math_4_score) as max_4
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30;

-- Question 5
SELECT DISTINCT naep.avg_math_4_score::float AS avg_score, naep.state AS bottom_10_states
FROM naep
WHERE year = '2000'
ORDER BY avg_score
LIMIT 10;

-- Question 6
SELECT ROUND(AVG(avg_math_4_score), 2) as avg_math_4_score
FROM naep
WHERE year = '2000';

-- Question 7
SELECT DISTINCT state as below_250
FROM naep
WHERE year='2000' AND avg_math_4_score < 250;

-- Question 8
SELECT DISTINCT state as scores_missing_y2000 
FROM naep
WHERE year='2000' AND avg_math_4_score IS NULL;

-- Question 9
SELECT naep.state, ROUND(avg_math_4_score, 2) as avg_math_4_score, total_expenditure 
FROM naep
LEFT OUTER JOIN finance ON naep.id = finance.id
WHERE avg_math_4_score is NOT NULL and naep.year = '2000'
ORDER BY total_expenditure DESC;
