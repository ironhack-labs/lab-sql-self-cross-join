USE sakila;

# 1. Get all pairs of actors that worked together
SELECT
	f1.actor_id,
    a1.first_name,
    a1.last_name,
    f2.actor_id,
    a2.first_name,
    a2.last_name
FROM film_actor f1
JOIN film_actor f2 ON f1.actor_id < f2.actor_id AND f1.film_id = f2.film_id
LEFT JOIN actor a1 ON a1.actor_id = f1.actor_id
LEFT JOIN actor a2 ON a2.actor_id = f2.actor_id
GROUP BY 1,2,3,4,5,6
ORDER BY 1,4;

# 2. Get all pairs of customers that have rented the same film more than 3 times.

-- attempt 1
SELECT
	r1.customer_id,
    r2.customer_id,
    i1.film_id,
    count(*)
FROM rental r1
JOIN rental r2 ON r1.rental_id < r2.rental_id AND r1.inventory_id = r2.inventory_id
LEFT JOIN inventory i1 ON i1.inventory_id = r1.inventory_id
LEFT JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
GROUP BY 1,2,3
ORDER BY 4 desc;

-- attempt 2
SELECT
      r1.customer_id,
      r2.customer_id,
      i1.film_id,
      COUNT(*) AS number_rentals
FROM sakila.rental r1
JOIN sakila.inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN sakila.film f1 ON i1.film_id = f1.film_id
JOIN sakila.rental r2 ON r1.inventory_id = r2.inventory_id AND r1.rental_id < r2.rental_id
GROUP BY 1,2,3
HAVING number_rentals > 2
ORDER BY number_rentals DESC;

-- Group attempt and checking on film_id 111
SELECT  r1.customer_id,r2.customer_id, i1.film_id,COUNT(*)
FROM rental r1
JOIN inventory i1 using(inventory_id)
JOIN inventory i2 on i1.film_id = i2.film_id
JOIN rental r2 on r2.inventory_id = i2.inventory_id
WHERE r1.customer_id <> r2.customer_id
GROUP BY 1,2,3
HAVING COUNT(*) > 3
ORDER BY 4 DESC,1,2,3;

SELECT
	count(*)
from rental
JOIN inventory using(inventory_id)
WHERE customer_id = 220 and film_id = 111;
-- end of attempts

-- Solution
CREATE OR REPLACE VIEW Film_Rentals as
SELECT
	customer_id,
    film_id,
    count(*) num_rentals
FROM rental r
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY 1,2
ORDER BY 3 desc;

SELECT * FROM Film_Rentals;

SELECT
	fr1.film_id,
    fr1.customer_id as customer_1_id,
    fr1.num_rentals as num_rentals_customer_1,
	fr2.customer_id as customer_2_id,
    fr2.num_rentals as num_rentals_customer_2,
    fr1.num_rentals + fr2.num_rentals as total_rentals
FROM Film_Rentals fr1
JOIN Film_Rentals fr2 ON fr1.customer_id < fr2.customer_id AND fr1.film_id = fr2.film_id
WHERE fr1.num_rentals + fr2.num_rentals > 3
ORDER BY 6 DESC,2,4;

-- Had to resort to creating a view to solve the problem of only using Joins: the total rentals were wrongly a multiplication of both customer's and 
-- not a sum. By creating a view with the sums per customer and film, the problem is circumvented.

# 3. Get all possible pairs of actors and films.
SELECT
	*
FROM (
	SELECT DISTINCT
		actor_id,
        concat(first_name,' ',last_name) as actor_name
	FROM actor) sub1
CROSS JOIN (
	SELECT DISTINCT
		film_id,
        title as film_name
	FROM film) sub2
ORDER BY film_id,actor_id;