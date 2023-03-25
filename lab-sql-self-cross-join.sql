use sakila;

-- 1.Get all pairs of actors that worked together.
SELECT CONCAT(actor1.first_name, ' ', actor1.last_name) AS actor1, 
                CONCAT(actor2.first_name, ' ', actor2.last_name) AS actor2
FROM actor AS actor1
JOIN film_actor fa1 USING(actor_id)
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id  AND fa1.actor_id < fa2.actor_id
JOIN actor AS actor2 ON fa2.actor_id = actor2.actor_id;

-- 2.Get all pairs of customers that have rented the same film more than 3 times.
SELECT  r1.customer_id,r2.customer_id,COUNT(*)
FROM rental r1
JOIN inventory i1 using(inventory_id)
JOIN inventory i2 on i1.film_id = i2.film_id
JOIN rental r2 on r2.inventory_id = i2.inventory_id
WHERE r1.customer_id <> r2.customer_id
GROUP BY 1,2
HAVING COUNT(*) > 3;

-- 3.Get all possible pairs of actors and films.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor, 
       f.title
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id);