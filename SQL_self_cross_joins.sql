-- 1. Get all pairs of actors that worked together.
select * from film_actor;

select distinct concat(ac1.first_name, ' ', ac1.last_name) AS actor1, 
				concat(ac2.first_name, ' ', ac2.last_name) AS actor2, 
                f.title
from sakila.film_actor a1
	join sakila.film_actor a2 on a1.film_id = a2.film_id and a1.actor_id <> a2.actor_id 
	left join sakila.film f on a1.film_id = f.film_id
	left join sakila.actor ac1 on a1.actor_id=ac1.actor_id
	left join sakila.actor ac2 on a2.actor_id = a2.actor_id
order by f.title
;

-- 2.Get all pairs of customers that have rented the same film more than 3 times.
SELECT * from sakila.customer;
SELECT * from sakila.rental;
SELECT * from sakila.inventory;
SELECT* from sakila.film;

select c1.customer_id,
       c2.customer_id,
       count(*) as number_of_rentals
from sakila.rental ren
	join sakila.customer c1 on ren.customer_id = c1.customer_id
	join sakila.inventory i on ren.inventory_id = i.inventory_id
	join sakila.film f on i.film_id = f.film_id
	join sakila.inventory i1 on f.film_id = i1.film_id
	join sakila.rental ren1 on i1.inventory_id = ren1.inventory_id and ren.rental_id > ren1.rental_id
	join sakila.customer c2 on ren1.customer_id = c2.customer_id
group by 1, 2
having number_of_rentals > 3
order by number_of_rentals desc;



-- 3.Get all possible pairs of actors and films.
select f.title, a.first_name, a.last_name
from sakila.actor a
	cross join sakila.film b
order by 1;
