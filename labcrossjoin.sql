-- Get all pairs of actors that worked together.

select * from sakila.film;

select * from sakila.film_actor;


select * 
from sakila.film_actor a1
left join sakila.film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id;


select * from sakila.actor;

-- Get all pairs of customers that have rented the same film more than 3 times.

select * from sakila.rental;

select * from sakila.store;

select * from sakila.customer;

select * from sakila.inventory;

SELECT * FROM SAKILA.FILM;

select * FROM SAKILA.FILM_tEXT;

SELECT * FROM SAKILA.PAYMENT;

SELECT * FROM SAKILA.STAFF;

SELECT C.CUSTOMER_ID AS CUSTOMER1_ID, SUB1.CUSTOMER_ID AS CUSTOMER_ID_2, F.FILM_ID, COUNT(F.FILM_ID) AS N_RENTED_FILMS
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.RENTAL R ON R.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN SAKILA.INVENTORY I ON I.INVENTORY_ID = R.INVENTORY_ID
LEFT JOIN SAKILA.FILM F ON F.FILM_ID = I.FILM_ID
LEFT JOIN (
SELECT C.CUSTOMER_ID, F.FILM_ID
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.RENTAL R ON R.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN SAKILA.INVENTORY I ON I.INVENTORY_ID = R.INVENTORY_ID
LEFT JOIN SAKILA.FILM F ON F.FILM_ID = I.FILM_ID
) SUB1
ON C.CUSTOMER_ID <> SUB1.CUSTOMER_ID AND F.FILM_ID = SUB1.FILM_ID
GROUP BY 1,2,3
HAVING N_RENTED_FILMS > 3
ORDER BY 4 DESC;

-- Get all possible pairs of actors and films.

select * from sakila.actor;

select * from sakila.film;

select * from sakila.film_actor;

select a.actor_id, cj.actor_id, cjf.title, cjf.title
from sakila.film f
left join sakila.film_actor fa
on f.film_id = fa.film_id
left join sakila.actor a
on fa.actor_id = a.actor_id
cross join sakila.actor cj
cross join sakila.film cjf;



