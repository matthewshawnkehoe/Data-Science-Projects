-- 1
SELECT COUNT(*) 
FROM purchases;

-- 2
SELECT COUNT(*) as num_after_may
FROM purchases
WHERE EXTRACT (month FROM created_at) > 5;

-- 3 
SELECT name, state
FROM purchases
WHERE state='FL';

-- 4
SELECT COUNT(*)
FROM purchases
WHERE zipcode = 11065;

-- 5
SELECT COUNT(*)
FROM purchases
WHERE user_id BETWEEN 1 AND 10 
  AND state NOT IN('FL', 'GA');
  
-- 6
SELECT COUNT(*)
FROM purchases
WHERE zipcode IN(99652, 11065, 66513);

-- 7
SELECT COUNT(*)
FROM purchases
WHERE user_id BETWEEN 10 AND 50
  AND user_id NOT IN(20,30);
  
-- 8
SELECT UPPER(LEFT(name, 5)), address, state, zipcode
FROM purchases
ORDER BY name;

-- 9
SELECT CONCAT  ('name: ',name, '; date: ', created_at) AS name_date
FROM purchases;

-- 10
SELECT name
from purchases
WHERE zipcode IS NULL;

-- 11
SELECT user_id, created_at, name, address
FROM purchases
WHERE 
  state='GA' 
  AND user_id=18
  OR user_id=20
ORDER BY created_at DESC;

-- 12
SELECT name, address, state, zipcode 
FROM purchases
WHERE state='IL' 
OR zipcode BETWEEN 30000 AND 80000
  AND LEFT(address,2) IN('23','12')
  AND state IN('CO', 'TX', 'WY');
  
-- 13
SELECT *
from purchases
ORDER BY zipcode DESC
LIMIT 10;

-- 14
SELECT * 
FROM purchases
WHERE LEFT(name,1) = 'S'
ORDER BY name;

-- 15
SELECT *
FROM purchases
WHERE LEFT(name,1) IN('S','T')
ORDER BY name;

-- 16
SELECT COUNT(*)
FROM purchases
WHERE LENGTH(name) >= 15;

-- 17
SELECT COUNT(*)
FROM purchases
WHERE LEFT(state,1) > 'M'
  AND zipcode > 50000
  AND user_id > 10;
  
-- 18
SELECT *
FROM purchases
WHERE SUBSTRING(name, 3, 1) = 'e';

-- 19
