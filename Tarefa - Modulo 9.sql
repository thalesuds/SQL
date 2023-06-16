/* 1a)
SELECT 
	sakila.film.title,
    sakila.inventory.film_id,
    COUNT(sakila.inventory.film_id) as count_film
FROM sakila.inventory
INNER JOIN sakila.rental
	ON sakila.rental.inventory_id = sakila.inventory.inventory_id
INNER JOIN sakila.film
	ON sakila.inventory.film_id = sakila.film.film_id
GROUP BY sakila.inventory.film_id
ORDER BY count_film DESC 
*/

/*1b
SELECT 
	sakila.inventory.store_id,
    sakila.film.title,
    COUNT(sakila.film.title) AS count_title
FROM sakila.inventory
INNER JOIN sakila.film
	ON sakila.inventory.film_id = sakila.film.film_id
GROUP BY sakila.inventory.store_id,
		 sakila.film.title
ORDER BY count_title DESC
*/

/*1c
CREATE TEMPORARY TABLE rentalAmountByFilm
SELECT 
	film.title,
    inventory.film_id,
    COUNT(sakila.inventory.film_id) as count_film
FROM sakila.inventory as inventory
INNER JOIN (SELECT inventory_id FROM sakila.rental) AS rental
	ON rental.inventory_id = inventory.inventory_id
INNER JOIN (SELECT title, film_id FROM sakila.film) AS film
	ON inventory.film_id = film.film_id
GROUP BY inventory.film_id
ORDER BY count_film DESC
*/

/*
CREATE TEMPORARY TABLE TitleByStore
SELECT 
	inventory.store_id,
    film.title,
    film.film_id,
    COUNT(film.title) AS count_title
FROM sakila.inventory AS inventory
INNER JOIN (SELECT film_id, title FROM sakila.film) AS film
	ON inventory.film_id = film.film_id
GROUP BY inventory.store_id,
		 film.title,
         film.film_id
ORDER BY count_title DESC
*/

/*
Res: Sim de fato corespondem.

SELECT 
	ts.film_id,
    ts.title,
    ra.count_film AS rental_total,
    SUM(ts.count_title) AS title_total
    
FROM TitleByStore AS ts
	
    INNER JOIN rentalAmountByFilm AS ra
	ON ra.film_id = ts.film_id
    
GROUP BY 
	ts.film_id,
    ts.title,
    rental_total

ORDER BY rental_total DESC

*/

/*
2
a)
SELECT 
	category.name,
    AVG(payment.amount)   AS payment_average  
FROM  sakila.rental AS rental
	INNER JOIN (SELECT inventory_id, film_id FROM sakila.inventory) AS inventory
    ON rental.inventory_id = inventory.inventory_id
    
    INNER JOIN (SELECT film_id, category_id FROM sakila.film_category) AS film_category
    ON inventory.film_id = film_category.film_id
    
    INNER JOIN (SELECT category_id, name FROM sakila.category) AS category
    ON film_category.category_id = category.category_id
    
    INNER JOIN (SELECT amount, rental_id FROM sakila.payment) AS payment
    ON payment.rental_id = rental.rental_id

GROUP BY category.name
    
b)
SELECT 
	category.name,
    AVG(film.replacement_cost)  AS replacement_cost 
FROM  sakila.film AS film
    
    INNER JOIN (SELECT film_id, category_id FROM sakila.film_category) AS film_category
    ON film.film_id = film_category.film_id
    
    INNER JOIN (SELECT category_id, name FROM sakila.category) AS category
    ON film_category.category_id = category.category_id

GROUP BY category.name
    
c)
SELECT 
	category.name,
    SUM(payment.amount)  AS amount,
	inventory.store_id
FROM  sakila.payment AS payment
	
    INNER JOIN (SELECT rental_id, inventory_id FROM sakila.rental) AS rental
    ON payment.rental_id = rental.rental_id
    
    INNER JOIN (SELECT inventory_id, film_id,  store_id FROM sakila.inventory) AS inventory
    ON rental.inventory_id = inventory.inventory_id

    INNER JOIN (SELECT film_id, category_id FROM sakila.film_category) AS film_category
    ON inventory.film_id = film_category.film_id
    
    INNER JOIN (SELECT category_id, name FROM sakila.category) AS category
    ON film_category.category_id = category.category_id

GROUP BY category.name, inventory.store_id
HAVING store_id = 1

d) SELECT 
	category.name,
    SUM(payment.amount)  AS amount,
	inventory.store_id
FROM  sakila.payment AS payment
	
    INNER JOIN (SELECT rental_id, inventory_id FROM sakila.rental) AS rental
    ON payment.rental_id = rental.rental_id
    
    INNER JOIN (SELECT inventory_id, film_id,  store_id FROM sakila.inventory) AS inventory
    ON rental.inventory_id = inventory.inventory_id

    INNER JOIN (SELECT film_id, category_id FROM sakila.film_category) AS film_category
    ON inventory.film_id = film_category.film_id
    
    INNER JOIN (SELECT category_id, name FROM sakila.category) AS category
    ON film_category.category_id = category.category_id

GROUP BY category.name, inventory.store_id
HAVING store_id = 2

Aqui nessa parte eu não entendi como seria usado o case when...

e)

SELECT 
	category.name,
    COUNT(inventory.film_id)  AS film_amount
FROM  sakila.inventory AS inventory

    INNER JOIN (SELECT film_id, category_id FROM sakila.film_category) AS film_category
    ON inventory.film_id = film_category.film_id
    
    INNER JOIN (SELECT category_id, name FROM sakila.category) AS category
    ON film_category.category_id = category.category_id

GROUP BY category.name, inventory.store_id
HAVING store_id = 2
    


