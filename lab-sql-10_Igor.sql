-- Lab | SQL Self and cross join

-- Get all pairs of actors that worked together.

SELECT 
	fa1.film_id, a1.actor_id, a1.first_name, a1.last_name, 
	a2.actor_id, a2.first_name, a2.last_name
FROM sakila.film_actor fa1
JOIN sakila.film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN sakila.actor a1 ON fa1.actor_id = a1.actor_id
JOIN sakila.actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY a1.first_name;

-- Get all pairs of customers that have rented the same film more than 3 times.

SELECT 
	c1.customer_id, c1.first_name, c1.last_name,
	c2.customer_id, c2.first_name, c2.last_name,
COUNT(DISTINCT r1.inventory_id) AS num_rentals
FROM sakila.customer c1
JOIN sakila.rental r1 ON c1.customer_id = r1.customer_id
JOIN sakila.inventory i1 ON r1.inventory_id = i1.inventory_id
JOIN sakila.rental r2 ON i1.film_id = r2.inventory_id
JOIN sakila.customer c2 ON r2.customer_id = c2.customer_id AND c1.customer_id < c2.customer_id
GROUP BY c1.customer_id, c2.customer_id
HAVING num_rentals > 3
ORDER BY num_rentals DESC;

-- Get all possible pairs of actors and films.

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor, 
       f.title
FROM sakila.actor a
CROSS JOIN sakila.film_actor fa USING(actor_id)
CROSS JOIN sakila.film f USING(film_id);