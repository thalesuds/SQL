DELIMITER $$

CREATE PROCEDURE addSell(
    IN clientName VARCHAR(255),
    IN amount DECIMAL,
    IN sellDate DATETIME,
    IN producstNumber FLOAT,
    IN paymentMethod VARCHAR(255),
    IN paymentDate VARCHAR(255),
    OUT result BOOL
)
BEGIN
    SET @idValidation := -1;
    SELECT pasoka.dataclient.client_id INTO @idValidation
    FROM dataclient
    WHERE pasoka.dataclient.name = clientName;
    
	IF (@idValidation != -1 AND @idValidation IS NOT NULL)
		THEN 
			SET autocommit = 0;

			INSERT INTO pasoka.sells (sell_id, client_id, amount, sellDate, productsNumber, paymentMethod, paymentDate)
				VALUES (default, @idValidation, amount, sellDate, productsNumber, paymentMethod, paymentDate);
			
            SET @sellId := -1;

			SELECT pasoka.sells.sell_id
			INTO @sellId
			FROM pasoka.sells
			ORDER BY sell_id DESC LIMIT 1;
            
			IF(@sellId != -1 AND @sellId IS NOT NULL)
				THEN 
					INSERT INTO pasoka.payments (payment_id, sell_id, amount, paymentDate, payed)
					VALUES (default, @sellId, amount, paymentDate, false);
				
					SET result := true;
					COMMIT;
			ELSE 
					SET result := false;
					ROLLBACK; 
		END IF;
    
	ELSE
		SET result := false;
    END IF;
    
   
    SET autocommit = 1;
    
END $$
DELIMITER ;

