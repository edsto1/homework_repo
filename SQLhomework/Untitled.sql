-- EDDIE STOKES MYSQL HOMEWORK
USE sakila;

SELECT * FROM actor;

-- #1a
SELECT first_name, last_name 
FROM actor;

-- #1b
SELECT concat(first_name, ' ', last_name) as Actor_Name 
FROM actor;  

-- #2a
SELECT * FROM actor 
WHERE first_name="Joe";

-- #2b
SELECT * FROM actor 
WHERE last_name like "%GEN%";

-- #2c
SELECT last_name, first_name 
FROM actor 
WHERE last_name like "%LI%";

-- #2d
SELECT country_id, country 
FROM country 
WHERE country 
IN ("Afghanistan", "Bangladesh", "China");

-- #3a
ALTER TABLE actor
ADD COLUMN description BLOB NULL;

-- #3b
ALTER TABLE actor
DROP COLUMN description;

-- #4a
SELECT last_name, 
COUNT(last_name) 
FROM actor 
group by last_name;

-- #4b
select last_name, count(last_name) from actor
group by last_name
having count(last_name) >= 2;

-- #4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

set sql_safe_updates = 0;

-- #4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

set sql_safe_updates = 1;

-- #5a
show create table address;

-- #6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON staff.address_id=address.address_id;

-- #6b
SELECT staff.first_name, staff.last_name, sum(payment.amount) AS sum_amount
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date like "2005-08%"
GROUP BY staff.staff_id;

-- #6c
SELECT film.title, COUNT(film_actor.actor_id) as "number_of_actors"
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id;

-- #6d
select count(inventory.film_id) AS "film count", film.title 
from inventory
join film on inventory.film_id = film.film_id
where film.title = "Hunchback Impossible";

 -- #6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "total amount paid"
FROM customer
JOIN payment on customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

-- #7a
SELECT title
FROM film
WHERE language_id IN
(
	SELECT language_id
	FROM language
    WHERE name = "English"
)
AND title LIKE "K%" OR title LIKE "Q%";

-- #7b
SELECT first_name, last_name 
FROM actor
WHERE actor_id in
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
    (
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
        )
        );

-- #7c
select customer.first_name, customer.last_name, customer.email
from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where country = "Canada";

-- #7d
select title
from film
where film_id in
(
select film_id 
from film_category
where category_id in
(
select category_id
from category
where name = "Family"
)
);

-- #7e
select film.title, count(distinct rental_id) as 'times rented'
from rental
join inventory on rental.inventory_id = inventory.inventory_id 
join film on inventory.film_id = film.film_id
group by film.title
order by count(distinct rental_id) desc;

-- #7f
select store.store_id, sum(amount) as 'business performance ($)'
from payment
join rental on payment.rental_id = rental.rental_id
join inventory on inventory.inventory_id = rental.inventory_id
join store on store.store_id = inventory.store_id
group by store.store_id;

-- #7g
select store.store_id, city.city, country.country
from country
join city on city.country_id = country.country_id
join address on address.city_id = city.city_id
join store on address.address_id = store.address_id;

-- #7h
select c.name 'Genre', sum(p.amount) as 'Gross'
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.name 
order by gross desc limit 5;

-- #8a
create view top_gross_by_genre as
select c.name 'Genre', sum(p.amount) as 'Gross'
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.name 
order by gross desc limit 5;

-- #8b
select * from top_gross_by_genre;

-- #8c
DROP view top_gross_by_genre

 
