-- lab-sql-join-multiple-tables
-- Get all pairs of actors that worked together.

select * from sakila.actor;
select * from sakila.film;
select * from sakila.film_actor;

-- Performing self join on tables film_actor to get the pair of actor 
select *
from sakila.film_actor f1
inner join sakila.film_actor f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id
;

-- Get all pairs of customers that have rented the same film more than 3 times.

select * from sakila.customer;
select * from sakila.rental;
select * from sakila.inventory;
select * from sakila.film;

-- step 1
select *
from sakila.rental r
inner join sakila.inventory i
on r.inventory_id = i.inventory_id
;

-- step 2

-- get all different pair of customer who have rented the same movie more than 3 times 
SELECT
    i.film_id,
    r.customer_id AS customer1,
    r1.customer_id AS customer2,
    COUNT(r.rental_id) AS rental_count
FROM
    sakila.rental r
INNER JOIN
    sakila.inventory i ON r.inventory_id = i.inventory_id
INNER JOIN
    sakila.rental r1 ON i.inventory_id = r1.inventory_id
                      AND r.customer_id < r1.customer_id 
INNER JOIN
    sakila.inventory i1 ON i.film_id = i1.film_id
                      AND r.customer_id < r1.customer_id                
                      
GROUP BY
    i.film_id, r.customer_id, r1.customer_id
HAVING
    rental_count > 3
    order by i.film_id, r.customer_id
    ;
    
    
    -- Get all possible pairs of actors and films.
-- checking the table

select * from sakila.film_actor;
select * from sakila.actor;
select * from sakila.film;

-- step to join the table 
select *
from sakila.film_actor fa
INNER JOIN
    sakila.actor a ON fa.actor_id = a.actor_id 
INNER JOIN
    sakila.film f ON f.film_id = fa.film_id ;


-- step to self join to get two different actor Id per movie row
select f.title ,f.film_id, fa.actor_id as Actor1,  a.first_name as Name_Actor1 , a.last_name as Name_Actor1 ,
 fa1.actor_id as Second_Actor ,a1.first_name as Name_Actor2 , a1.last_name as Name_Actor2

from sakila.film_actor fa
left JOIN
    sakila.actor a ON fa.actor_id = a.actor_id 
left JOIN
    sakila.film f ON f.film_id = fa.film_id 
inner JOIN
    sakila.film_actor fa1 ON fa1.film_id = f.film_id
                      AND fa.actor_id > fa1.actor_id 
inner join sakila.actor a1 on fa1.actor_id = a1.actor_id 
;





