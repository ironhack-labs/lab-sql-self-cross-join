-- 1) Getting all pairs of actors that worked together
select distinct a3.actor_id as actor_id_1, a3.first_name as first_name_1, a3.last_name as last_name_1, a4.actor_id as actor_id_2, a4.first_name as first_name_2, a4.last_name as last_name_2
from sakila.film_actor a1
inner join sakila.film_actor a2 on a1.film_id = a2.film_id
left join sakila.actor a3 on a1.actor_id = a3.actor_id
left join sakila.actor a4 on a2.actor_id = a4.actor_id
where a1.actor_id < a2.actor_id
order by a3.actor_id asc, a4.actor_id asc;

-- 2) Get all pairs of customers that have rented the same film more than 3 times
select customer1.first_name as first_name_1, customer1.last_name as last_name_1, customer2.first_name as first_name_2, customer2.last_name as last_name_2, count(*) as rentals_of_the_same_film
from(
	select distinct customer_id, film_id
	from sakila.rental rental
	left join sakila.inventory inventory on rental.inventory_id = inventory.inventory_id
) sub1
left join (
	select distinct customer_id, film_id
	from sakila.rental rental
	left join sakila.inventory inventory on rental.inventory_id = inventory.inventory_id
) sub2 on sub1.film_id = sub2.film_id
left join sakila.customer customer1 on sub1.customer_id = customer1.customer_id
left join sakila.customer customer2 on sub2.customer_id = customer2.customer_id
where sub1.customer_id < sub2.customer_id
group by customer1.first_name, customer1.last_name, customer2.first_name, customer2.last_name
having count(*) > 3
order by count(*) desc;

-- 3) Getting all possible pairs of actors and films
select distinct film.title, actor_name.first_name as actor_first_name, actor_name.last_name as actor_last_name
from sakila.film_actor actor
cross join sakila.film film
left join sakila.actor actor_name on actor.actor_id = actor_name.actor_id;