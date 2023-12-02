#all pairs of actors that worked together
select a1.actor_id, a2.actor_id from sakila.film_actor a1 
inner join sakila.film_actor a2 on a1.film_id = a2.film_id
and a1.actor_id < a2.actor_id
group by a1.actor_id, a2.actor_id
order by a1.actor_id, a2.actor_id asc;

#number or rentals each customer rented the same film
select a1.customer_id, a2.film_id, count(a1.rental_id) as nr_rentals 
from sakila.rental a1
inner join sakila.inventory a2 on a1.inventory_id = a2.inventory_id
group by a1.customer_id, a2.film_id order by 3 desc, 2 desc;

create table sakila.t2
select a1.customer_id, a2.film_id 
from sakila.rental a1
inner join sakila.inventory a2 on a1.inventory_id = a2.inventory_id
group by a1.customer_id, a2.film_id order by 2 desc;

select * from sakila.t2 order by 1 asc;

#checking which films customers 24 and 111 rented
select * from sakila.t2 where customer_id in (24,111) order by 2 asc;

#all pairs of customers which rented more than 3 films in common
select b1.customer_id, b2.customer_id, count(distinct b1.film_id) as nr_films from sakila.t2 b1 
inner join sakila.t2 b2 on b1.film_id = b2.film_id
and b1.customer_id <> b2.customer_id
where b1.customer_id < b2.customer_id
group by b1.customer_id, b2.customer_id
having nr_films > 3
order by nr_films desc;


create temporary table sakila.distinct_films
select distinct title from sakila.film;

create temporary table sakila.distinct_actors
select concat(first_name, " ", last_name) as actor_name from sakila.actor;

#all possible pairs of actors and films
select * from sakila.distinct_films cross join sakila.distinct_actors;