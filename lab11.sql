-- 1. Get all pairs of actors that worked together.
select * 
from sakila.film_actor a1
inner join sakila.film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id
order by a1.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

create table sakila.tempo_customer 
select customer_id, film_id from sakila.rental re
left join sakila.inventory inv
on re.inventory_id = inv.inventory_id
group by 1,2;

select s1.customer_id , s2.customer_id, count(s1.film_id) as count_film 
from sakila.tempo_customer s1
inner join sakila.tempo_customer s2
on s1.customer_id <> s2.customer_id and s1.film_id = s2.film_id
group by s1.customer_id , s2.customer_id
having count_film >3 and s1.customer_id < s2.customer_id
order by 3 desc;


select count(customer_id) from sakila.tempo_customer;

-- 3. Get all possible pairs of actors and films.
select concat(first_name, ' ', last_name) actor_name, title from sakila.actor
cross join sakila.film;
