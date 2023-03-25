SELECT DISTINCT 
               a1.actor_id, 
               a1.first_name, 
               a1.last_name, 
               a2.actor_id, 
               a2.first_name, 
               a2.last_name
FROM sakila.film_actor fa1
JOIN sakila.actor a1 ON fa1.actor_id = a1.actor_id
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN sakila.actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY 1,2,3,4,5,6;

SELECT 
      c1.customer_id,
      c2.customer_id,
      COUNT(*) AS number_rentals
FROM sakila.rental r1
JOIN sakila.customer c1 ON r1.customer_id = c1.customer_id
JOIN sakila.inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN sakila.film f1 ON i1.film_id = f1.film_id
JOIN sakila.inventory i2 ON f1.film_id = i2.film_id
JOIN sakila.rental r2 ON i2.inventory_id = r2.inventory_id AND r1.rental_id < r2.rental_id
JOIN sakila.customer c2 ON r2.customer_id = c2.customer_id
GROUP BY 1,2
HAVING number_rentals > 3
ORDER BY number_rentals DESC;

SELECT a.actor_id, 
       a.first_name, 
	   a.last_name, 
       f.film_id, 
       f.title
FROM sakila.actor a
CROSS JOIN sakila.film f
JOIN sakila.film_actor fa ON fa.actor_id = a.actor_id AND fa.film_id = f.film_id
ORDER BY a.actor_id, f.film_id;