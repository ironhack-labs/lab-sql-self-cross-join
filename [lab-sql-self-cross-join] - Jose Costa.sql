# 1. Get all pairs of actors that worked together.
use sakila;
select actor_id, first_name, last_name, f.film_id from actor
join film_actor f using (actor_id) order by f.film_id;

SELECT fa1.film_id, a1.actor_id, a1.first_name, a1.last_name, 
       a2.actor_id, a2.first_name, a2.last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY a1.first_name;

# 2. Get all pairs of customers that have rented the same film more than 3 times.
select c1.customer_id, c2.customer_id, i1.film_id,count(i1.film_id) as num_films from customer c1
join rental r1 using(customer_id)
join inventory i1 using(inventory_id)
join inventory i2 on i2.film_id=i1.film_id
join rental r2 on r2.inventory_id = i2.inventory_id
join customer c2 on r2.customer_id=c2.customer_id
where c1.customer_id <> c2.customer_id
group by 1,2
having num_films > 3
order by 1,4;

#3. Get all possible pairs of actors and films.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor, 
       f.title
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id) order by actor;


