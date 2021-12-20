#Integrantes:
#JHON WILLIAM MAMANI CONDORI 2020-119018
#GUSTAVO JOAQUIN CALIZAYA LEON 2020-119035
#semana6
#ejercicio1
#Create a row level trigger for the customers table that would fire for INSERT or UPDATE or
#DELETE operations performed on the CUSTOMERS table. This trigger will display the salary
#difference between the old values and new values:
#CUSTOMERS table:
DROP DATABASE IF EXISTS semana6;
CREATE DATABASE semana6;
USE semana6;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    age INT,
    address VARCHAR(25),
    salary FLOAT NOT NULL,
PRIMARY KEY(id));
INSERT INTO customers(id, name, age, address, salary) VALUES (1, 'Alive', 24, 'Khammam', 2000);
INSERT INTO customers(id, name, age, address, salary) VALUES (2, 'Bob', 27, 'Kadappa', 3000);
INSERT INTO customers(id, name, age, address, salary) VALUES (3, 'Catri', 25, 'Guntur', 4000);
INSERT INTO customers(id, name, age, address, salary) VALUES (4, 'Dena', 28, 'Hyderabad', 5000);
INSERT INTO customers(id, name, age, address, salary) VALUES (5, 'Eeshwar', 27, 'Kurnool', 6000);
INSERT INTO customers(id, name, age, address, salary) VALUES (6, 'Farooq', 28, 'Nellur', 7000);
DROP TABLE IF EXISTS diference;
CREATE TABLE diference(id INT, dif FLOAT NULL);
INSERT INTO diference(id, dif) VALUES (1,0);
DROP PROCEDURE IF EXISTS proc;

DROP TRIGGER IF EXISTS dif1;
DELIMITER //
CREATE TRIGGER dif1 AFTER UPDATE ON customers FOR EACH ROW
BEGIN
    DECLARE d FLOAT;
    SET d=OLD.salary-NEW.salary;
    UPDATE diference SET dif=d WHERE id=1;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=d;
END //
DELIMITER ;


UPDATE customers SET salary=6000 WHERE id=2;
SELECT dif FROM diference;
#ejercicio2
#Creation of insert trigger, delete trigger, update trigger practice triggers using the passenger database.
#Passenger( Passport_ id INTEGER PRIMARY KEY, Name VARCHAR (50) Not NULL,
#Age Integer Not NULL, Sex Char, Address VARCHAR (50) Not NULL);
DROP TABLE IF EXISTS pasajeros;
CREATE TABLE pasajeros(
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    sex VARCHAR(10),
    address VARCHAR(50) NOT NULL
);
INSERT INTO pasajeros(id, name, age, sex, address) VALUES (1, 'name1', 43, 'F', 'address');
INSERT INTO pasajeros(id, name, age, sex, address) VALUES (2, 'name1', 23, 'M', 'address');
INSERT INTO pasajeros(id, name, age, sex, address) VALUES (3, 'name1', 33, 'M', 'address');
DROP TABLE IF EXISTS verificar;
CREATE TABLE verificar (id INT, v INT);
INSERT INTO verificar(id, v) VALUES (1, 0);

#a. Write a Insert Trigger to check the Passport_id is exactly six digits or not.
DROP TRIGGER If EXISTS verificador;
DELIMITER //
CREATE TRIGGER verificador AFTER INSERT ON pasajeros FOR EACH ROW
BEGIN
    DECLARE a INT;
    SET a=CHARACTER_LENGTH(NEW.id);
    IF a=6 THEN
        UPDATE verificar SET v=1 WHERE id=1;
    ELSE
        UPDATE verificar SET v=0 WHERE id=1;
    END IF;
END //
DELIMITER ;
INSERT INTO pasajeros(id, name, age, sex, address) VALUES (123456, 'name1', 33, 'M', 'address');
SELECT v FROM verificar;
#b. Write a trigger on passenger to display messages 'I Record is inserted', ''I record deleted',
#'I record is updated' when insertion, deletion and updation are done on passenger respectively.


#3. Insert row in employee table using Triggers. Every trigger is created with name any trigger have same name must be replaced by new name. These triggers can raised before insert, update or delete
#rows on data base. The main difference between a trigger and a stored procedure is that the former is
#attached to a table and is only fired when an INSERT, UPDATE or DELETE occurs.
DROP TABLE IF EXISTS empleado;
CREATE TABLE empleado(id INT PRIMARY KEY, nombre VARCHAR(20), apellido VARCHAR(20), salario FLOAT);
INSERT INTO empleado(id, nombre, apellido, salario) VALUES (1, 'nombre1', 'apellido1', 2000);
INSERT INTO empleado(id, nombre, apellido, salario) VALUES (2, 'nombre1', 'apellido1', 2000);
INSERT INTO empleado(id, nombre, apellido, salario) VALUES (3, 'nombre1', 'apellido1', 2000);

DROP TRIGGER IF EXISTS insertar;
DELIMITER //
CREATE TRIGGER insertar AFTER UPDATE ON empleado FOR EACH ROW
BEGIN
    INSERT INTO empleado(id, nombre, apellido, salario) VALUES (5, 'nombre1', 'apellido1', 2000);
END //
DELIMITER ;

UPDATE empleado SET nombre='nombre2' WHERE id=3;

#4. Convert employee name into uppercase whenever an employee record is inserted or updated. Trigger to 
#fire before the insert or update.
DROP TRIGGER IF EXISTS convertidor;
DELIMITER //
CREATE TRIGGER convertidor AFTER INSERT ON empleado FOR EACH ROW
BEGIN
    SET NEW.nombre=UPPER(NEW.nombre);
END //
DELIMITER ; 

INSERT INTO empleado (id, nombre, apellido, salario) VALUES (6,'nombre', 'apellido', 2100);
SELECT * FROM empleado;
#5 Trigger before deleting a record from emp table. Trigger will insert the row to be deleted into table
#called delete _emp and also record user who has deleted the record and date and time of delete.




#6. Create a transparent audit system for a table CUST_MSTR. The system must keep track of the
#records that are being deleted or updated





