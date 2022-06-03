--Question 1: List all customers who live in Texas, use JOINs

SELECT first_name, last_name, district
FROM customer
JOIN address
ON customer.customer_id = address.address_id
WHERE district = 'Texas';

--Question 2: Get all payments above $6.99 with the customer's full name.

SELECT first_name, last_name, amount
FROM payment
JOIN customer c 
ON c.customer_id = payment.customer_id 
WHERE amount > 6.99;


--Question 3: Show all customer names who have made payments above $175 (use subqueries)

SELECT first_name, last_name
FROM customer c 
WHERE c.customer_id IN (
SELECT p.customer_id
FROM payment p
GROUP BY p.customer_id
HAVING sum(amount) > 175
ORDER BY sum(amount) DESC
);


--Question 4: List all customers that live in Argentina (use the city table)

SELECT first_name, last_name
FROM customer cus
JOIN address a
ON cus.address_id = a.address_id 
JOIN city c 
ON c.city_id = a.city_id
JOIN country cou
ON c.country_id = cou.country_id
WHERE cou.country = 'Argentina'
--WHERE country_id = 6
;

--Question 5: Which film category has the most movies in it?

SELECT name
FROM category c
WHERE category_id IN (
SELECT category_id
FROM film_category fc
GROUP BY fc.category_id
ORDER BY count(fc.category_id) DESC
LIMIT 1
);

--Question 6: What film had the most actors in it?

SELECT film_id, title
FROM film
WHERE film_id = (
	SELECT film_id
	FROM film_actor fa
	GROUP BY film_id
	ORDER BY count(*) DESC
	LIMIT 1
	);

--Answer: "Lambs Cincinatti"

--Question 7: Which actor has been in the least movies?

SELECT first_name, last_name
FROM actor a 
WHERE actor_id = (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY count(*)
	LIMIT 1
	);
	
--Answer: Emily Dee.

--Question 8: Which country has the most cities?

SELECT country
FROM country
WHERE country_id = (
SELECT country_id
FROM city c
GROUP BY country_id
ORDER BY count(*) DESC
LIMIT 1
);

--Answer: India.

--Question 9: List the actors who have been in more than 3 films but less than 6.

SELECT first_name, last_name
FROM actor
WHERE actor_id = (
SELECT actor_id
FROM film_actor fa
GROUP BY actor_id 
HAVING count(actor_id) BETWEEN 3 AND 6
ORDER BY count(*) desc
);

--Subquery
--SELECT actor_id, count(actor_id)
--FROM film_actor fa
--GROUP BY actor_id 
----HAVING count(actor_id) BETWEEN 3 AND 6
--ORDER BY count(*) desc;
--No actors.

--Answer: None. The minimum is 14 films per actor.