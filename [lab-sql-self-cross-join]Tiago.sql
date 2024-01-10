-- 1. Get all pairs of actors that worked together.
select fa1.film_id, fa2.actor_id
from sakila.film_actor fa1
inner join sakila.film_actor fa2
on fa1.film_id = fa2.film_id
and fa1.actor_id <> fa2.actor_id
;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
-- (each pair of customers that rented more than 3 films in comun

select c1.customer_id, c2.customer_id, count(*) as count
from sakila.customer c1
inner join sakila.rental r1 on c1.customer_id = r1.customer_id
inner join sakila.inventory i1 on r1.inventory_id = i1.inventory_id
inner join sakila.film f1 on i1.film_id = f1.film_id
inner join sakila.inventory i2 on f1.film_id = i2.film_id
inner join sakila.rental r2 on i2.inventory_id = r2.inventory_id
inner join sakila.customer c2 on c2.customer_id = r2.customer_id
where c1.customer_id <> c2.customer_id and c1.customer_id < c2.customer_id
group by 1,2
having count > 3
order by 3 desc
;





-- 3. Get all possible pairs of actors and films
select concat(a.first_name, ' ', a.last_name) as name, f.title
from sakila.actor a
cross join sakila.film f
;
