-- 1. Get all pairs of actors that worked together.
select * 
from sakila.film_actor a1
inner join sakila.film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id
order by a1.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select * from sakila.customer; -- customer names / customer_id pk
select * from sakila.rental; -- customer_id fk / rental_id pk
select * from sakila.inventory; -- invetory_id fk / film_id fk

create table temp_rental as
select 
	concat(c.first_name, '_', c.last_name) as customer_name,
    c.customer_id as customer_id,
    r.rental_id as rental_id,
    inv.film_id as film_id
from sakila.customer c
left join sakila.rental r on c.customer_id = r.customer_id
left join sakila.inventory inv on r.inventory_id = inv.inventory_id;

select * from temp_rental;

select 
	t1.customer_name,
	t2.customer_name,
	count(t1.film_id) as count_film
from sakila.temp_rental t1
inner join sakila.temp_rental t2
on t1.customer_id <> t2.customer_id and t1.film_id = t2.film_id
group by 1,2
having count_film > 3
order by 3 desc;



-- 3. Get all possible pairs of actors and films.
select 
	concat(a.first_name, ' ', a.last_name) as actor_name,
    f.title as title
from sakila.actor a
cross join sakila.film f;
