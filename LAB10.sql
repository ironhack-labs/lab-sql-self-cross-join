-- Lab | SQL Self and cross join
-- 1. Get all pairs of actors that worked together.

SELECT DISTINCT CONCAT(C1.first_name, ' ', C1.last_name) AS actor1_name, 
                CONCAT(C2.first_name, ' ', C2.last_name) AS actor2_name,
                B.title
FROM sakila.film_actor a1 
JOIN sakila.film_actor a2 ON a1.film_id = a2.film_id AND a1.actor_id <> a2.actor_id
LEFT JOIN sakila.film B ON a1.film_id = B.film_id
LEFT JOIN sakila.actor C1 ON a1.actor_id = C1.actor_id
LEFT JOIN sakila.actor C2 ON a2.actor_id = C2.actor_id
ORDER BY B.title;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

select 
D.title, 
CONCAT(b1.first_name, ' ', b1.last_name) AS customer1_name, 
CONCAT(b2.first_name, ' ', b2.last_name) AS customer2_name
from sakila.rental a1
join sakila.rental a2 on a1.inventory_id = a2.inventory_id and a1.customer_id <> a2.customer_id
LEFT JOIN sakila.customer B1 ON a1.customer_id = b1.customer_id
LEFT JOIN sakila.customer B2 ON a2.customer_id = b2.customer_id
LEFT JOIN sakila.inventory C on a1.inventory_id = c.inventory_id
left join sakila.film D using(film_id)
group by D.title,customer1_name,customer2_name
having count(*) > 3
order by D.title;

-- Get all possible pairs of actors and films.
   
SELECT a.actor_id, a.first_name, a.last_name, b.film_id, b.title
FROM sakila.actor a
CROSS JOIN sakila.film b
ORDER BY a.actor_id, b.film_id;

 

