-- 1. Get all pairs of actors that worked together.

SELECT a1.first_name, a1.last_name, 
       a2.first_name, a2.last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY a1.first_name;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT c1.customer_id, c2.customer_id, i1.film_id, i2.film_id, count(*) as num_films
FROM sakila.customer c1 
JOIN sakila.rental r1 USING(customer_id)
JOIN sakila.inventory i1 USING(inventory_id)
join sakila.inventory i2 on i2.film_id = i1.film_id
join sakila.rental r2 on r2.inventory_id = i2.inventory_id
join sakila.customer c2 on r2.customer_id = c2.customer_id
where c1.customer_id <> c2.customer_id
GROUP BY 1,2,3,4
HAVING num_films > 3
ORDER BY num_films desc;

-- 3. Get all possible pairs of actors and films.
-- SELECT A.actor_id, B.film_id
-- FROM sakila.film_actor A
-- CROSS JOIN sakila.film_actor B
-- ORDER BY A.actor_id;

SELECT C.last_name, B.title
FROM sakila.film_actor A
JOIN sakila.film B ON (B.film_id)
JOIN sakila.actor C ON (A.actor_id)
CROSS JOIN sakila.film_actor D;
