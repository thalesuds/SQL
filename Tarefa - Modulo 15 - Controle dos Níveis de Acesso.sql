CREATE USER 'Luiz Eduardo' IDENTIFIED BY '123456';
CREATE USER 'Samanta Pomodoro' IDENTIFIED BY '123456';
CREATE USER 'João Gabriel' IDENTIFIED BY '123456';

CREATE ROLE 'administrator';
CREATE ROLE 'user';
CREATE ROLE 'analyst';

GRANT ALL ON pasoka.* TO 'administrator';
GRANT UPDATE, INSERT ON pasoka.* TO 'user';
GRANT SELECT, ALTER ROUTINE, CREATE ROUTINE, EXECUTE, SHOW ROUTINE ON pasoka.* TO 'analyst';

GRANT 'administrator' TO 'Luiz Eduardo';
GRANT 'user' TO 'Samanta Pomodoro';
GRANT 'analyst' TO 'João Gabriel';