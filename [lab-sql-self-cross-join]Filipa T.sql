-- 1. Get all pairs of actors that worked together.

create temporary table sakila.pairs_actors as
select fa1.actor_id as actor1_id, fa1.film_id as film1_id,
       fa2.actor_id as actor2_id, fa2.film_id as film2_id
from sakila.film_actor fa1
inner join sakila.film_actor fa2
on fa1.actor_id <> fa2.actor_id
and fa1.film_id = fa2.film_id
order by fa1.film_id, fa1.actor_id
;

select p.actor1_id, a1.first_name, a1.last_name, p.film1_id, f1.title, p.film2_id, p.actor2_id, a2.first_name, a2.last_name
from sakila.pairs_actors p
left join sakila.film f1 on p.film1_id = f1.film_id
left join sakila.film f2 on p.film2_id = f2.film_id
left join sakila.actor a1 on p.actor1_id = a1.actor_id
left join sakila.actor a2 on p.actor2_id = a2.actor_id
;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.

select c1.customer_id, c2.customer_id, count(distinct r1.inventory_id) as number_of_rentals
from sakila.customer as c1
inner join sakila.rental as r1
on c1.customer_id = r1.customer_id
inner join sakila.inventory as i1
on r1.inventory_id = i1.inventory_id
inner join sakila.film as f
on i1.film_id = f.film_id
inner join sakila.inventory as i2
on f.film_id = i2.film_id
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


select distinct f.title, a.first_name as actor_first_name, a.last_name as actor_last_name
from sakila.film_actor fa
cross join sakila.film f
left join sakila.actor a on fa.actor_id = a.actor_id;