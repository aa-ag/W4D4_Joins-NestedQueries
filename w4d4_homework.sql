-- PENDING: ALL THESE SHOULD BE RAN FOR ACTIVE CUSTOMERS ONLY.

-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, address.address_id, address.district
FROM customer
JOIN address ON customer.address_id=address.address_id
WHERE address.district = 'Texas';
-- There are 5 customers who live in Texas: address_id's 10, 122, 310, 405 and 567.



-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT amount, customer.customer_id, customer.first_name, customer.last_name
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount ASC;

SELECT COUNT(amount)
FROM payment
WHERE amount > 6.99;
-- there are 1431 payments higher than $6.99



-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer.customer_id IN (
	SELECT payment.customer_id
	FROM payment
	GROUP BY payment.customer_id
	HAVING SUM(payment.amount) > 175
);
-- 7 customers have made overall/combined payments of over $175. 0 customers have made 1 payment of over $175.
-- Those 7 customers are: Patricia Johnson, Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo and Karl Seal



-- 4. List all customers that live in Nepal (use the city table)
SELECT country.country_id, city.city_id, address.city_id, customer.first_name, customer.last_name
FROM country
JOIN city ON city.country_id = country.country_id
JOIN address ON address.city_id = city.city_id
JOIN customer ON address.city_id = address.city_id
WHERE country = 'Nepal';



-- 5. Which staff member had the most transactions?
SELECT COUNT(rental_id)
FROM rental
JOIN staff ON staff.staff_id = rental.staff_id
GROUP BY rental.staff_id;
-- Staff id # 1 had 36 more transactions. Total: 8040.


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY count DESC;
-- 223 PG-13, 210 NC-17, 195 R, 194 PG and 178 G-rated movies.


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer.customer_id IN (
	SELECT payment.customer_id
	FROM payment
	GROUP BY payment.customer_id
	HAVING SUM(payment.amount) > 6.99
);
-- There are 599 customers in this group.


-- 8. How many free rentals did our stores give away?
SELECT COUNT(rental.rental_id)
FROM rental
JOIN payment ON payment.rental_id = rental.rental_id
WHERE payment.amount = 0;
-- Our stores gave away 24 free rentals. 


