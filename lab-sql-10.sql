use sakila;

-- 1

SELECT DISTINCT a1.actor_id, a2.actor_id
FROM film_actor a1
JOIN film_actor a2 ON a1.film_id = a2.film_id
WHERE a1.actor_id <> a2.actor_id
ORDER BY a1.actor_id, a2.actor_id;

-- 2

SELECT 
    r1.customer_id,
    r2.customer_id,
    i.film_id
FROM rental r1
JOIN rental r2 ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
JOIN inventory i ON r1.inventory_id = i.inventory_id
GROUP BY r1.customer_id, r2.customer_id, i.film_id
HAVING COUNT(*) > 3;

-- 3

SELECT 
    a1.actor_id AS actor1_id,
    a2.actor_id AS actor2_id,
    f.film_id
FROM actor a1
JOIN actor a2 ON a1.actor_id < a2.actor_id
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id AND fa1.film_id = fa2.film_id
JOIN film f ON fa1.film_id = f.film_id;