-- 1.Get all pairs of actors that worked together.
SELECT 
ac.first_name,
ac.last_name,
a.first_name,
a.last_name,
fa.actor_id,
fl.actor_id,
fl.film_id
FROM sakila.film_actor fl
JOIN sakila.film_actor fa ON fl.actor_id < fa.actor_id and fl.film_id = fa.film_id
JOIN sakila.actor a ON fl.actor_id = a.actor_id
JOIN sakila.actor ac ON fa.actor_id= ac.actor_id
Order by 5,6,7;


-- 2.Get all pairs of customers that have rented the same film more than 3 times.
SELECT 
    f.title,
    c1.first_name AS customer1_first_name,
    c1.last_name AS customer1_last_name,
    c2.first_name AS customer2_first_name,
    c2.last_name AS customer2_last_name,
    r1.customer_id AS customer1_id,
    r2.customer_id AS customer2_id,
    COUNT(*) AS rental_count
FROM 
    sakila.rental r1
    JOIN sakila.customer c1 ON r1.customer_id = c1.customer_id
    JOIN sakila.inventory i1 ON r1.inventory_id = i1.inventory_id
    JOIN sakila.film f ON i1.film_id = f.film_id
    JOIN sakila.inventory i2 ON f.film_id = i2.film_id
    JOIN sakila.rental r2 ON i2.inventory_id = r2.inventory_id AND r2.customer_id > r1.customer_id
    JOIN sakila.customer c2 ON r2.customer_id = c2.customer_id
GROUP BY 
    f.title,
    customer1_id,
    customer2_id
HAVING 
    rental_count > 3
ORDER BY 
	rental_count desc;



-- 3.Get all possible pairs of actors and films.
SELECT
;
