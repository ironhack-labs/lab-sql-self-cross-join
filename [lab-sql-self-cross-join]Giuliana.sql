-- Get all pairs of actors that worked together.
select f1.actor_id as Actor_1, f2.actor_id as Actor_2, f1.film_id
from sakila.film_actor f1
inner join sakila.film_actor f2
on f1.film_id = f2.film_id
and f2.actor_id <> f1.actor_id
order by f1.film_id;

-- Get all pairs of customers that have rented the same film more than 3 times.
select distinct c.customer_id as Customer_1, c2.customer_id as Customer_2, count(*) as same_films
from sakila.customer c
inner join sakila.rental r
on c.customer_id = r.customer_id
inner join sakila.inventory i
on r.inventory_id = i.inventory_id
inner join sakila.inventory i2
on i.film_id = i2.film_id
inner join sakila.rental r2
on r2.inventory_id = i2.inventory_id
inner join sakila.customer c2
on c2.customer_id = r2.customer_id
and c.customer_id <> c2.customer_id
group by 1,2
having same_films > 3
order by same_films desc;


-- Get all possible pairs of actors and films
select concat(first_name, ' ', last_name) as actor_full_name, title as film_title from sakila.actor
cross join sakila.film;