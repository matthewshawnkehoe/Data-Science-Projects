-- 1
SELECT owner_id, transaction_id, service
FROM owners 
INNER JOIN transactions ON owners.pet_id = transactions.pet_id
ORDER BY owner_id;

-- 2
SELECT owner_id, transactions.pet_id, transaction_id, visits_count 
FROM owners 
INNER JOIN transactions ON owners.pet_id = transactions.pet_id
INNER JOIN visits ON owners.pet_id = visits.pet_id
WHERE transaction_id is NOT NULL
ORDER BY transaction_id;


-- 3
SELECT owners.pet_id, owners.size, visits_count AS num_visits
FROM owners 
INNER JOIN visits ON owners.pet_id = visits.pet_id
WHERE visits_count >=10
ORDER BY visits_count DESC;

-- 4
-- Somewhat like SELECT DISTINCT, this operation will remove any duplicates that exist 
-- in the resulting "united" dataset.
SELECT owner_id FROM owners
UNION
SELECT owner_id FROM owners_2
ORDER BY owner_id;

-- 5 
SELECT DISTINCT owner_id, SUM(visits_count) AS num_visits
FROM owners 
INNER JOIN visits ON owners.pet_id = visits.pet_id
GROUP BY owner_id
ORDER by num_visits DESC
LIMIT 3;
 
-- 6 
SELECT owner_id, transaction_id, date, service
FROM transactions
INNER JOIN owners ON owners.pet_id = transactions.pet_id
WHERE transactions.transaction_id is NOT NULL

UNION ALL

SELECT owners_2.owner_id, transaction_id, date, service
FROM transactions
INNER JOIN owners_2 ON owners_2.pet_id = transactions.pet_id
WHERE transactions.transaction_id is NOT NULL

ORDER BY date, transaction_id;

-- 7
SELECT CONCAT(owner_id,', ',owners.pet_id) as owner_pet, visits_count 
FROM owners
INNER JOIN visits ON owners.pet_id = visits.pet_id
WHERE visits_count > 3

UNION ALL

SELECT CONCAT(owner_id,', ',owners_2.pet_id) as owner_pet, visits_count 
FROM owners_2
INNER JOIN visits ON owners_2.pet_id = visits.pet_id
WHERE visits_count > 3

ORDER BY visits_count DESC, owner_pet;


-- 8 
SELECT visits_count, owner_id, owners.pet_id
FROM owners 
INNER JOIN visits ON owners.pet_id  = visits.pet_id
ORDER BY visits_count DESC

-- 9
SELECT owner_id, transactions.pet_id,  date, service
FROM transactions INNER JOIN owners ON owners.pet_id = transactions.pet_id
WHERE date = '2019-06-17' OR service = 'haircut'
ORDER By date;

-- 10
SELECT pet_id, service,
CASE
        WHEN service = 'nails' THEN 'gift'
        ELSE 'no gift'
END as get_gift
FROM transactions
ORDER BY get_gift;

-- 11
SELECT date, COUNT(*) 
FROM transactions 
WHERE date in ('2019-06-17', '2019-06-18')
GROUP BY date;

-- 12 
SELECT size, COUNT(*) as size_count 
FROM       
  (SELECT owner_id, size  FROM owners 
   UNION ALL
   SELECT owner_id, size  FROM owners 
  ) as all_owners 
GROUP BY all_owners.size


-- 12
WITH all_owners AS
(SELECT * FROM owners
 UNION ALL
 SELECT * FROM owners_2)
 
SELECT size, COUNT(size) as size_count
FROM all_owners
GROUP BY size
ORDER BY size DESC;
 
