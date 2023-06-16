CREATE DATABASE IF NOT EXISTS pasoka;

USE pasoka;

CREATE TABLE IF NOT EXISTS pasoka.dataClient(
	client_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    CNPJ VARCHAR(255) NOT NULL
)
COMMENT "Table to store client's informations";

CREATE TABLE IF NOT EXISTS pasoka.sells (
	sell_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    amount DECIMAL(9, 2),
    sellDate DATETIME,
    productsNumber FLOAT,
    paymentMethod VARCHAR(255),
    paymentDate VARCHAR(255),
    FOREIGN KEY (client_id) REFERENCES dataClient(client_id)
)
COMMENT "Table to store sell's information";

CREATE TABLE IF NOT EXISTS pasoka.payments(
	payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sell_id INT NOT NULL,
    amount FLOAT NOT NULL,
    paymentDate DATE,
    payed BOOL NOT NULL,
    receiptDate DATETIME,
    FOREIGN KEY (sell_id) REFERENCES sells(sell_id)
)
COMMENT "Table to store payment's informations";