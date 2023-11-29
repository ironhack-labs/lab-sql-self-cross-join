-- 1. Get all pairs of actors that worked together.
select f1.film_id, f2.actor_id
from sakila.film_actor as f1
inner join sakila.film_actor as f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id
;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select c1.customer_id, c2.customer_id, count(distinct r1.inventory_id) as number_of_rentals
from sakila.customer as c1
inner join sakila.rental as r1
on c1.customer_id = r1.customer_id
inner join sakila.inventory as i1
on r1.inventory_id = i1.inventory_id
inner join sakila.film as fm
on i1.film_id = fm.film_id
inner join sakila.inventory as i2
on fm.film_id = i2.film_id
inner join sakila.rental as r2
on i2.inventory_id = r2.inventory_id
inner join sakila.customer as c2
on r2.customer_id = c2.customer_id
where c1.customer_id <> c2.customer_id
group by 1,2
having number_of_rentals >3
order by 3 desc
;
      
-- 3. Get all possible pairs of actors and films.
Select concat(first_name, ' ', last_name) as actor_name, title, film_id
from sakila.actor
cross join sakila.film
;
