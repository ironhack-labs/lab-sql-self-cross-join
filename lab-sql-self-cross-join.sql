-- 1. Get all pairs of actors that worked together.

SELECT 
    a1.actor_id, a2.actor_id, a1.film_id
FROM
    sakila.film_actor a1
        JOIN
    sakila.film_actor a2 ON a1.actor_id < a2.actor_id
        AND a1.film_id = a2.film_id
ORDER BY 1 , 2 , 3;


-- 2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT 
    r1.customer_id,
    r2.customer_id,
    f.title,
    COUNT(*) AS num_times_rented
FROM
    sakila.rental r1
        JOIN
    sakila.rental r2 ON r1.customer_id < r2.customer_id
        AND r1.inventory_id = r2.inventory_id
        JOIN
    customer c ON c.customer_id = r1.customer_id
        JOIN
    inventory i ON i.inventory_id = r1.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY r1.customer_id , r2.customer_id , f.title
HAVING COUNT(*) > 1
ORDER BY 1 , 2 , 3;

-- 3. Get all possible pairs of actors and films.

SELECT 
    a.actor_id, a.first_name, a.last_name, f.film_id, f.title
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id;