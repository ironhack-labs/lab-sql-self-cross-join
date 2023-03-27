-- 1. Get all pairs of actors that worked together.
SELECT fa.film_id, a.first_name, a.last_name, a2.first_name, a2.last_name
FROM sakila.film_actor fa
JOIN sakila.film_actor fa2
ON fa.actor_id < fa2.actor_id
and fa.film_id = fa2.film_id
LEFT JOIN sakila.actor a
ON fa.actor_id = a.actor_id
LEFT JOIN sakila.actor a2
ON fa2.actor_id = a2.actor_id
ORDER BY fa.film_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select c1.customer_id, c2.customer_id, count(*) as num_films
from sakila.customer c1
join sakila.rental r1 using(customer_id)
join sakila.inventory i1 using(inventory_id)
join sakila.inventory i2 on i1.film_id = i2.film_id
join sakila.rental r2 on r2.inventory_id = i2.inventory_id
join sakila.customer c2 on r2.customer_id = c2.customer_id
where c1.customer_id <> c2.customer_id
group by 1,2
having num_films > 3
order by num_films desc;

-- 3. Get all possible pairs of actors and films.
SELECT  sub2.title, a.first_name, a. last_name
FROM (
SELECT DISTINCT actor_id from sakila.actor) sub1 
CROSS JOIN (
SELECT DISTINCT title from sakila.film) sub2
LEFT JOIN sakila.actor a
ON sub1.actor_id = a.actor_id
ORDER BY sub2.title;



