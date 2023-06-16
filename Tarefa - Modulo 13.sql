-- 1)
INSERT INTO pasoka.dataclient
VALUES (default, "FELICIANO LTDA", "RUA DA BONDADE", "77.555.333/0001-80"),
		(default, "JOAQUIN FONTANA", "AV. DOS PASSARINHOS, n 123", "22.111.555/00001-70"),
        (default, "BARABARA ELIZA LTDA", "RUA DA SERVIDÃO, n 333","27.397.421/0001-19"),
        (default, "JAQUELINE ASSUNCAO", "AV. XV DE SETEMBRO n 555","700.219.809-15"),
        (default, "ELAINE SILVA LTDA", "Rua Das Orcas, n 27", "328.901.399/0001-13"),
        (default, "JOAO FELICIANO", "Rua Das Orquídeas, n 18", "320.182.399-12"),
        (default, "BEATRIZ BARBOSA", "Rua das Margaridas, n 894", "322.848.292.12"),
        (default, "ALINE FELICCE", "Avenida Brasil, n 321", "123.048.874/0001-15"),
        (default, "SEARA ALIMENTOS LTDA", "Avenida Amazonas, n 9129", "384.921.823/0001-84"),
        (default, "UCHOA ATACADAO LTDA", "Rua 706, 89", "848.291.290/0001-13");

INSERT INTO pasoka.sells (sell_id, client_id, amount, sellDate, productsNumber, paymentMethod, paymentDate)
VALUES (default, 1, 2319.90, "2022.01.10", 12, "boleto", "2022.02.10"),
	(default, 2, 1314.15, "2023.02.05", 8, "boleto", "2022.03.05"),
    (default, 3, 3290.12, "2021.07.15", 11, "pix", "2022.08.15"),
    (default, 4, 690.13, "2023.04.12", 3, "pix", "2023.05.12"),
    (default, 5, 1300.29, "2023.02.17", 4, "boleto", "2023.03.17"),
    (default, 6, 4900, "2023.01.25", 5, "dinheiro", "2023.02.25"),
    (default, 7, 320, "2023.02.03", 1, "pix", "2023.03.03"),
    (default, 8, 10.730, "2023.03.03", 16, "boleto", "2023.05.03"),
    (default, 9, 12.320, "2012.12.01", 22, "boleto", "2023.02.03"),
    (default, 10, 3200.00, "2023.03.08", 6, "pix", "2023.04.05");

INSERT INTO pasoka.payments (payment_id,sell_id, amount, paymentDate, payed, receiptDate)
VALUES (default,1, 2319.90, "2022.02.10", true, "2022.02.10"),
		(default,2, 1314.15, "2023.03.05", true, "2023.03.05"),
        (default,3, 3290.12, "2021.08.15", true, "2022.08.15"),
        (default,4, 690.13, "2023.04.12", true, "2023.04.15"),
        (default,5, 1300.29, "2023.03.17", true, "2023.03.17"),
        (default,6, 4900, "2023.02.25", true, "2023.02.25"),
        (default,7, 320, "2023.02.18", true, "2023.02.18"),
        (default,8, 10.730, "2023.04.03", true, "2023.04.03"),
        (default,9, 12.320, "2012.02.01", true, "2021.02.03"),
        (default,10, 3200.00, "2023.04.05", true, "2023.04.05");

-- 2)
-- ANALISANDO O TICKET MÉDIO DAS VENDAS
SELECT 
	AVG(amount) as ValorMedioDaVenda
FROM pasoka.sells;

-- ANALISANDO O VALOR MÉDIO UND DE PRODUTO
SELECT
	SUM(amount)/SUM(productsNumber) as ValorMedio
    FROM pasoka.sells;
    
-- VERIFICANDO O CLIENTE COM MAIOR COMPRA

SELECT 
	sells.client_id,
    sells.amount,
    dataclient.name
	FROM sells
    INNER JOIN dataclient
    ON dataclient.client_id = sells.client_id
ORDER BY amount DESC;
	