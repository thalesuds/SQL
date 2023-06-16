/*
1a

SELECT 
	COUNT(rental.rental_date) as rentTotal,
    store_id as store,
    MONTH(rental.rental_date) as monthNumber
FROM rental
INNER JOIN (SELECT inventory_id, store_id FROM inventory) AS inventory
ON rental.inventory_id = inventory.inventory_id
GROUP BY store, monthNumber
ORDER BY rentTotal 

1b

SELECT 
	SUM(payment.amount) amountTotal,
    MONTH(payment.payment_date) AS monthNumber
FROM payment
GROUP BY monthNumber
ORDER BY amountTotal DESC


1c)
SELECT 
	COUNT(rental_id) as rentalAmount,
	YEAR(rental_date) AS yearNumber,
    MONTH(rental_date) AS monthNumber,
    WEEK(rental_date) as weekNumber
FROM rental
GROUP BY yearNumber, monthNumber, weekNumber
HAVING yearNumber = 2005 and monthNumber >= 5 and monthNumber <=6
*/

/*
2
WITH customerFrequency AS
(
SELECT
	rental.customer_id AS customerId,
    customer.store_id AS storeId,
    count(rental.customer_id) AS frequency,
    YEAR(rental.rental_date) AS yearNumber,
    MONTH(rental.rental_date) AS monthNumber
FROM rental
INNER JOIN (SELECT store_id, customer_id FROM customer) AS customer
ON customer.customer_id = rental.customer_id
GROUP BY customerId, yearNumber, monthNumber, StoreId
HAVING yearNumber = 2005 and monthNumber = 5 and frequency >= 2
ORDER BY frequency DESC
)


SELECT 
	storeId,
    AVG(DATEDIFF(rentalDate, lagDate)) as AvgTime
FROM (SELECT 
    customerId,
    rental.rental_date as rentalDate,
    storeId,
    LAG(rental.rental_date) OVER (PARTITION BY customerId ORDER BY customerId ASC) AS lagDate
FROM customerFrequency
INNER JOIN (SELECT customer_id, rental_date 
            FROM rental WHERE YEAR(rental_date) = 2005 and MONTH(rental_date) = 5) AS rental
ON rental.customer_id = customerFrequency.customerId
ORDER BY customerId ASC) AS rentalDateTable
GROUP BY storeId

Resposta: A loja 1 tem tempo médio de aluguel entre 1.6275 enquanto a loja 2, tem tempo médio
de 1.6452.
*/

/*3)
SELECT
film_id,
title,
rating
FROM film
WHERE rating REGEXP("PG")
*/