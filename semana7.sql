CREATE DATABASE semana7;
USE semana7;
#1.Create the procedure for palindrome of given number.
DELIMITER //
CREATE PROCEDURE ejercicio1 (IN n INT)
BEGIN
    DECLARE num_inverso,n1 INT;
    SET num_inverso=0;
    SET n1=n;
    WHILE n1>0 DO
        SET num_inverso=num_inverso*10+n1%10;
        SET n1=n1/10;
    END WHILE;
    IF n=num_inverso THEN
        SELECT 'es un numero palindromo';
    ELSE
        SELECT 'no es un numero palidromo';
    END IF;
END //
DELIMITER ;
CALL ejercicio1(123321);

#Create the procedure for GCD: Program should load two registers with two Numbers and then 
#apply the logic for GCD of two numbers. GCD of two numbers is performed by dividing the 
#greater number by the smaller number till the remainder is zero. If it is zero, the divisor 
#is the GCD if not the remainder and the divisors of the previous division are the new set of 
#two numbers. The process is repeated by dividing greater of the two numbers by the smaller 
#number till the remainder is zero and GCD is found.
DROP PROCEDURE IF EXISTS gcd;
DELIMITER //
CREATE PROCEDURE gcd (IN n1 INT, IN n2 INT)
BEGIN
    DECLARE g, i, t INT;
    SET i=1;
    IF(n2>n1) THEN
        SET t=n2;
        SET n2=n1;
        SET n1=t;
    END IF;
    WHILE i<=n2 DO
        IF (n1%i=0 AND n2%i=0) THEN
            SET g=i;
        END IF;
        SET i=i+1;
    END WHILE;
    SELECT g AS 'gcd: ';
END //
DELIMITER ;
CALL gcd(12, 16);

#3.Write the PL/SQL programs to create the procedure for factorial of given number.

DELIMITER //
CREATE FUNCTION factorial(numero INT) RETURNS float
DETERMINISTIC
BEGIN
    DECLARE i INT;
    SET i=1;
    WHILE numero>=1 DO
       SET i=numero*i;
       SET numero=numero-1;
    END WHILE;
    RETURN i;
END //
DELIMITER ;
SELECT factorial(4) AS factorial;

#4.Write the PL/SQL programs to create the procedure to find sum of N natural number.
DROP PROCEDURE IF EXISTS suma;
DELIMITER //
CREATE PROCEDURE suma(IN n INT)
BEGIN
    DECLARE s,i INT;
    SET s=0;
    SET i=1;
    WHILE i<=n DO
        SET s=s+i;
        SET i=i+1;
    END WHILE;
    SELECT s AS 'suma de n numeros naturales';
END //
DELIMITER ;
CALL suma(13);
#5.Write the PL/SQL programs to create the procedure to find Fibonacci series.
DROP PROCEDURE IF EXISTS fibonacci;
DELIMITER //
CREATE PROCEDURE fibonacci(IN numero INT)
DETERMINISTIC
BEGIN
    DECLARE i INT;
    DECLARE f1, f2 INT;
    SET i=3, f1=1, f2=1;
    WHILE i<=numero DO
       SET i=i+1;
       SET f2=f1+f2;
       SET f1=f2-f1;
    END WHILE;
    SELECT f2;
END//
DELIMITER ;
CALL fibonacci(5);
#6.Write the PL/SQL programs to create the procedure to check the given number is perfect or not
DROP PROCEDURE IF EXISTS numperfecto;
DELIMITER //
CREATE PROCEDURE numperfecto(IN n INT)
BEGIN
   DECLARE i,s INT;
   SET i=1;
   SET s=0;
   WHILE i<n DO
       IF n%i=0 THEN
           SET s=s+i;
       END IF;
       SET i=i+1;
   END WHILE;
   IF n=s THEN
       SELECT 'el numero es perfecto';
    ELSE
       SELECT 'el numero no es perfecto';
    END IF;
END //
DELIMITER ;
CALL numperfecto(6);







