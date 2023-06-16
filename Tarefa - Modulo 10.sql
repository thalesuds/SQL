/*WITH groupResult AS
(
SELECT
	email,
    paymentTotal,
    NTILE(4) OVER(ORDER BY paymentTotal DESC) AS groupNumber
FROM (
		SELECT 
			customer.email as email,
			payment.customer_id AS customer,
			SUM(payment.amount) AS paymentTotal
		FROM sakila.payment AS payment
		INNER JOIN (SELECT email, customer_id FROM sakila.customer) AS customer
			 ON customer.customer_id = payment.payment_id
GROUP BY customer.email, customer) AS calculation
)

SELECT 
	email,
    paymentTotal,
        CASE
		WHEN groupNumber = 1 THEN 'Especial'
        WHEN groupNumber = 2 THEN 'Fiel'
        WHEN groupNumber = 3 THEN 'Ocasional'
        WHEN groupNumber = 4 THEN 'Iniciante'
	END AS classification
FROM groupresult
*/

/*
SELECT * 
FROM
		(SELECT 
			customer.store_id,
			payment.amount,
			YEAR(payment.payment_date) as dateYear,
			MONTH(payment.payment_date) as dateMonth,
			DAY(payment.payment_date) as dateDay,
			SUM(payment.amount) OVER (PARTITION BY store_id ORDER BY payment.payment_date) AS resultSum
		FROM sakila.payment AS payment
		INNER JOIN sakila.customer AS customer
	ON customer.customer_id = payment.customer_id) as tableSum
    WHERE tableSum.resultSum >= 10000 and tableSum.resultSum <= 10005
    
Resultado - A loja 1 bateu $10.000,00 em aluguéis primeiro, sendo este feito no dia 7 de Julho de 2005.
Enquanto que a loja 2 chegou neste resultado no dia 9 do mesmo mês do mesmo ano.
*/