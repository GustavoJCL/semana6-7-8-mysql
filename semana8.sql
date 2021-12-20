#Integrantes:
#JHON WILLIAM MAMANI CONDORI 2020-119018
#GUSTAVO JOAQUIN CALIZAYA LEON 2020-119035
#semana8
#1. Write a PL/SQL block that will display the name, dept no, salary of fist highest paid
#employees.
DROP DATABASE If EXISTS semana8;
CREATE DATABASE semana8;
USE semana8;
DROP TABLE IF EXISTS empleado;
CREATE TABLE empleado(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ename VARCHAR(20) NULL,
  job VARCHAR(20) NULL,
  id_dep INT NULL,
  sal INT NULL
  );
INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (1, 'nombre', 'trabajo1', 1, 2030);
INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (2, 'nombre', 'trabajo1', 2, 2050);
INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (3, 'nombre', 'trabajo1', 1, 3000);

DROP TABLE IF EXISTS departamento;
CREATE TABLE departamento(
  dep_no INT NOT NULL AUTO_INCREMENT,
  depname VARCHAR (20) NULL,
  location VARCHAR(20) NULL,
PRIMARY KEY (dep_no));
ALTER TABLE departamento ADD designation INT NULL;
INSERT INTO departamento (dep_no, depname, location, designation) VALUES (1, 'nombre1', 'location1', 1);
INSERT INTO departamento (dep_no, depname, location, designation) VALUES (2, 'nombre2', 'location1', 2);
INSERT INTO departamento (dep_no, depname, location, designation) VALUES (3, 'nombre3', 'location1', 3);
INSERT INTO departamento (dep_no, depname, location, designation) VALUES (4, 'nombre4', 'location1', 4);

DROP PROCEDURE IF EXISTS ejercicio1;

DELIMITER //
CREATE PROCEDURE ejercicio1()
BEGIN
    DECLARE mayor FLOAT;
    DECLARE cant INT;
    DECLARE i INT;
    DECLARE n1 INT;
    DECLARE c CURSOR FOR SELECT sal FROM empleado;
    SET i=1;
    SELECT COUNT(id) INTO cant FROM empleado;
    OPEN c;
    WHILE i<=cant DO 
       FETCH c INTO n1;
       IF i=1 THEN
          SET mayor=n1;
       ELSEIF mayor<n1 THEN
          SET mayor=n1;
       END IF;
       SET i=i+1;
    END WHILE;
    CLOSE c;
    SELECT ename, id_dep, sal FROM empleado WHERE  sal=mayor;
END //
DELIMITER ;

CALL ejercicio1();

#3. Write a PL/SQL block that will display the employee details along with salary using cursors.
DROP TABLE IF EXISTS list_emp;
CREATE TABLE list_emp(lista VARCHAR(200));
DROP PROCEDURE IF EXISTS ejercicio3;
DELIMITER //
CREATE PROCEDURE ejercicio3()
BEGIN
    DECLARE nombre VARCHAR(20);
    DECLARE depId int;
    DECLARE salario FLOAT;
    DECLARE cant INT;
    DECLARE i INT;
    DECLARE id1 INT;
    DECLARE detalle VARCHAR(200);
    DECLARE c1 CURSOR FOR SELECT id FROM empleado;
    SET i=1;
    SELECT COUNT(id) INTO cant FROM empleado;
    OPEN c1;
        WHILE i<=cant DO
            FETCH c1 INTO id1;
            SELECT ename INTO nombre FROM empleado WHERE id=id1;
            #SELECT id_dep INTO depId FROM empleado WHERE id=id1;
            SELECT sal INTO salario FROM empleado WHERE id=id1;
            SET detalle=CONCAT(id1, ", ", nombre, ", ",  salario );
            INSERT INTO list_emp(lista) VALUES (detalle);
            SET i=i+1;
        END WHILE;
    CLOSE c1;
    SELECT lista FROM list_emp;
END //
DELIMITER ;
CALL ejercicio3();

#4.To write a Cursor to display the list of employees who are working as a Managers or Analyst.

INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (4, 'nombre', 'Gerente', 1, 3000);
INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (5, 'nombre', 'Analista', 2, 3000);
INSERT INTO empleado(id, ename, job, id_dep, sal) VALUES (6, 'nombre', 'Analista', 1, 3000);

DROP TABLE IF EXISTS lista1;
CREATE TABLE lista1(lista VARCHAR(200));
DROP PROCEDURE IF EXISTS ejercicio4;
DELIMITER //
CREATE PROCEDURE ejercicio4()
BEGIN
    DECLARE nombre VARCHAR(20);
    DECLARE salario FLOAT;
    DECLARE trabajo VARCHAR(20);
    DECLARE cant INT;
    DECLARE i INT;
    DECLARE id1 INT;
    DECLARE detalle VARCHAR(200);
    DECLARE c2 CURSOR FOR SELECT id FROM empleado;
    SET i=1;
    SELECT COUNT(id) INTO cant FROM empleado;
    OPEN c2;
        WHILE i<=cant DO
            FETCH c2 INTO id1;
            SELECT ename INTO nombre FROM empleado WHERE id=id1;
            SELECT sal INTO salario FROM empleado WHERE id=id1;
            SELECT job INTO trabajo FROM empleado WHERE id=id1;
            IF trabajo='Gerente' OR trabajo='Analista' THEN
                SET detalle=CONCAT(id1, ", ", nombre, ", ",  salario,', ',trabajo);
                INSERT INTO lista1(lista) VALUES (detalle);
            END IF;
            SET i=i+1;
        END WHILE;
    CLOSE c2;
    SELECT lista FROM lista1;
END //
DELIMITER ;
CALL ejercicio4();

#5.To write a Cursor to find employee with given job and deptno
DROP TABLE IF EXISTS empList;
CREATE TABLE empList(lista VARCHAR(100));
DROP FUNCTION IF EXISTS ejercicio5;
DELIMITER //
CREATE FUNCTION ejercicio5(trabajo VARCHAR(20), departamento INT) RETURNS INT
DETERMINISTIC 
BEGIN
    DECLARE emp VARCHAR(100);
    DECLARE trabajo1 VARCHAR(20);
    DECLARE dep INT;
    DECLARE i INt;
    DECLARE cant INT;
    DECLARE id1 INt;
    DECLARE c3 CURSOR FOR SELECT id FROM empleado;
    SELECT COUNT(id) INTO cant FROM empleado;
    SET i=1;
    OPEN c3;
    WHILE i<=cant DO
        FETCH c3 INTO id1;
        SELECT job INTO trabajo1 FROM empleado WHERE id=id1; 
        SELECT id_dep INTO dep FROM empleado WHERE id=id1; 
        IF trabajo1=trabajo AND dep=departamento THEN
             SET emp=CONCAT(id1, ', ', trabajo1, ', ', dep);
             INSERT INTO empList(lista) VALUES (emp);
        END IF;
        SET i=i+1;
    RETURN id1;
    END WHILE;
    CLOSE c3;
    RETURN id1;
END //
DELIMITER ;
SELECT ejercicio5('trabajo', 2);

#6.Write a PL/SQL block using implicit cursor that will display message, the salaries of all the employes in the ''employe' table are updates. If none of the employee's salary are updated we get a message 'none of the salaries were updated'. Else we get a message like for example 'salaries for 1000 employees are updated' if there are 1000 rows in 'employee' table

