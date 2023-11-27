select * from sakila.actor;
select * from sakila.film_actor;

select a1.actor_id as actor1_id, a1.first_name,
       a2.actor_id as actor2_id, a2.first_name
from film_actor fa1
join film_actor fa2 on fa1.film_id = fa2.film_id and fa1.actor_id < fa2.actor_id
join actor a1 on fa1.actor_id = a1.actor_id
join actor a2 on fa2.actor_id = a2.actor_id
order by 2 , 4 asc;

select* from sakila.customer;
select * from sakila.rental;
select* from sakila.inventory;

select c1.customer_id, c1.first_name, c2.customer_id, c2.first_name, count(r1.inventory_id) as 'num_rentals'
from sakila.customer c1
inner join sakila.rental r1 on c1.customer_id = r1.customer_id
inner join  sakila.inventory i1 on r1.inventory_id = i1.inventory_id
inner join  sakila.rental r2 on i1.film_id = r2.inventory_id
inner join sakila.customer c2 on r2.customer_id = c2.customer_id and c1.customer_id < c2.customer_id
group by c1.customer_id, c2.customer_id
having num_rentals > 3
order by num_rentals desc;


select concat(a.first_name, ' ', a.last_name) as 'actor', f.title
from sakila.actor a
cross join sakila.film_actor fa using(actor_id)
cross join sakila.film f using(film_id)
order by 1, 2 asc;
