-- 1 Get all pairs of actors that worked together.
-- 2 Get all pairs of customers that have rented the same film more than 3 times.
-- 3 Get all possible pairs of actors and films.

use sakila;

-- 1
SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS 'ACTOR 1',
    CONCAT(a2.first_name, ' ', a2.last_name) AS 'ACTOR 2'
FROM 
    sakila.film_actor fa1
JOIN 
    sakila.film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN 
    sakila.actor a1 ON fa1.actor_id = a1.actor_id
JOIN 
    sakila.actor a2 ON fa2.actor_id = a2.actor_id
WHERE 
    a1.actor_id < a2.actor_id; 
    
-- 2
SELECT
    CONCAT(c1.first_name, ' ', c1.last_name) AS 'CUSTOMER 1',
    CONCAT(c2.first_name, ' ', c2.last_name) AS 'CUSTOMER 2',
    f.title AS 'FILM',
    COUNT(*) AS 'RENTAL_COUNT'
FROM
    sakila.rental AS r1
JOIN
    sakila.rental AS r2 ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
JOIN
    sakila.customer AS c1 ON r1.customer_id = c1.customer_id
JOIN
    sakila.customer AS c2 ON r2.customer_id = c2.customer_id
JOIN
    sakila.inventory AS i1 ON r1.inventory_id = i1.inventory_id
JOIN
    sakila.inventory AS i2 ON r2.inventory_id = i2.inventory_id
JOIN
    sakila.film AS f ON i1.film_id = f.film_id
GROUP BY
    'CUSTOMER 1', 'CUSTOMER 2', 'FILM'
HAVING
    COUNT(*) > 3
LIMIT 0, 1000;

-- 3
SELECT
    a.first_name AS 'Actor First Name',
    a.last_name AS 'Actor Last Name',
    f.title AS 'Film Title'
FROM
    sakila.actor AS a
CROSS JOIN
    sakila.film AS f;
