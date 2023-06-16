SELECT 
	sakila.inventory.store_id,
    sakila.film.title,
    COUNT(sakila.film.title) AS nada_haver
FROM sakila.inventory
INNER JOIN sakila.film
	ON sakila.inventory.film_id = sakila.film.film_id
GROUP BY sakila.inventory.store_id,
		 sakila.film.title
ORDER BY nada_haver DESC