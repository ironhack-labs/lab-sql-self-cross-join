# 1- Get all pairs of actors that worked together.

select f1.film_id, a1.actor_id, a1.first_name, a1.last_name, 
       a2.actor_id, a2.first_name, a2.last_name
from sakila.film_actor f1
join sakila.film_actor f2 on f1.film_id = f2.film_id and f1.actor_id <> f2.actor_id
join actor a1 on f1.actor_id = a1.actor_id
join actor a2 on f2.actor_id = a2.actor_id
order by a1.first_name
;

#2 - Get all pairs of customers that have rented the same film more than 3 times.

SELECT  r1.customer_id,r2.customer_id,COUNT(*)
FROM rental r1
JOIN inventory i1 using(inventory_id)
JOIN inventory i2 on i1.film_id = i2.film_id
JOIN rental r2 on r2.inventory_id = i2.inventory_id
WHERE r1.customer_id <> r2.customer_id
GROUP BY 1,2
HAVING COUNT(*) > 3;


#3 Get all possible pairs of actors and films.
select concat(a.first_name, ' ', a.last_name) as actor, 
       f.title
from sakila.actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on f.film_id = a.actor_id;