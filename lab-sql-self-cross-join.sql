-- Get all pairs of actors that worked together.
SELECT 
CONCAT(A.first_name, ' ', A.last_name) AS actor1,
CONCAT(B.first_name, ' ', B.last_name) AS actor2,
A.title 
FROM 
    (SELECT 
        fa.actor_id, 
        a.first_name, 
        a.last_name, 
        fa.film_id, 
        f.title
    FROM sakila.actor a 
    INNER JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id
    INNER JOIN sakila.film f ON fa.film_id = f.film_id
    ) AS A
INNER JOIN 
    (SELECT 
        fa.actor_id, 
        a.first_name, 
        a.last_name, 
        fa.film_id, 
        f.title
    FROM sakila.actor a 
    INNER JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id
    INNER JOIN sakila.film f ON fa.film_id = f.film_id
    ) AS B 
ON A.film_id = B.film_id
AND A.actor_id < B.actor_id
ORDER BY A.title;

-- Get all pairs of customers that have rented the same film more than 3 times.
SELECT
A.title as film_title,
CONCAT(A.first_name, ' ', A.last_name) AS customer1,
CONCAT(B.first_name, ' ', B.last_name) AS customer2,
COUNT(*) AS rental_count
FROM 
    (SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        r.inventory_id, 
        f.title
    FROM sakila.customer c 
    INNER JOIN sakila.rental r ON c.customer_id = r.customer_id
    INNER JOIN sakila.inventory inv ON r.inventory_id = inv.inventory_id
    INNER JOIN sakila.film f ON inv.film_id = f.film_id
    ) AS A
INNER JOIN 
    (SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        r.inventory_id, 
        f.title
    FROM sakila.customer c 
    INNER JOIN sakila.rental r ON c.customer_id = r.customer_id
    INNER JOIN sakila.inventory inv ON r.inventory_id = inv.inventory_id
    INNER JOIN sakila.film f ON inv.film_id = f.film_id
    ) AS B 
ON A.title = B.title
AND A.customer_id < B.customer_id 
GROUP BY 1,2,3
HAVING rental_count > 3
ORDER BY rental_count;

-- Get all possible pairs of actors and films.
SELECT 
a.actor_id AS actor_id,
concat (a.first_name, ' ', a.last_name) AS actor_name,
f.film_id AS film_id,
f.title AS film_title
FROM sakila.actor a
CROSS JOIN sakila.film f
ORDER BY actor_id, film_id;
