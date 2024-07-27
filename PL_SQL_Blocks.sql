/* Visualizar 'Hola a todos' */
DECLARE
    V_TEXTO VARCHAR2(20) := 'HOLA A TODOS';
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_TEXTO);
END;

/* Programa que recibe una nota y muestra un mensaje dependiendo de esta */
SET SERVEROUTPUT ON
DECLARE
    N NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'INTRODUZCA LA NOTA DEL ALUMNO: ');
    N:=&NOTA;
    DBMS_OUTPUT.PUT_LINE('VALOR INTRODUCIDO ' || N);
    IF ( N >= 0 ) AND ( N < 5 ) THEN
    DBMS_OUTPUT.PUT_LINE( N ||' SUSPENSO');
    ELSIF N < 7 THEN
    DBMS_OUTPUT.PUT_LINE( N ||' APROBADO');
    ELSIF N < 9 THEN
    DBMS_OUTPUT.PUT_LINE( N ||' NOTABLE');
    ELSIF N < 10 THEN
    DBMS_OUTPUT.PUT_LINE( N ||' SOBRESALIENTE');
    ELSIF N = 10 THEN
    DBMS_OUTPUT.PUT_LINE( N ||' MATRÍCULA');
    ELSE
    DBMS_OUTPUT.PUT_LINE( N ||' NOTA INVÁLIDA');
    END IF;
    DBMS_OUTPDBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');
END;

/* Programa que recibe un número y visualiza los números iguales o inferiores a él (WHILE) */
SET SERVEROUTPUT ON
DECLARE
    N NUMBER (3);
BEGIN
    N := &NUMERO;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'ESCRITURA DECRECIENTE CON WHILE: ');
    WHILE N > 0 LOOP
        DBMS_OUTPUT.PUT_LINE(N || '');
        N := N - 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;

/* Programa que recibe un número y visualiza los números iguales o inferiores a él (LOOP) */
SET SERVEROUTPUT ON
DECLARE
    N NUMBER (3);
BEGIN
    N := &NUMERO;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'ESCRITURA DECRECIENTE CON LOOP: ');
    LOOP
        DBMS_OUTPUT.PUT_LINE(N ||'');
        N := N - 1;
        EXIT WHEN N = 0;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;

/* Programa que recibe un número y visualiza los números iguales o inferiores a él (FOR) */
SET SERVEROUTPUT ON
DECLARE
    N NUMBER (3);
BEGIN
    N := &NUMERO;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'ESCRITURA DECRECIENTE CON FOR: ');
    FOR I IN REVERSE 1..N LOOP
        DBMS_OUTPUT.PUT_LINE(I || '');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;

/* Programa que devuelve el número de cifras que tiene un número que se pasa por teclado mediante una variable de sustitución */
SET SERVEROUTPUT ON
DECLARE
    NUMERO NUMBER;
    CONT NUMBER;
BEGIN
    NUMERO := &NUMERO;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL NÚMERO DE CIFRAS DEL NÚMERO ES: ' || LENGTH(NUMERO));
END;

/* Bloque PL que devuelve el número de cifras que tiene un número que se pasa por teclado mediante una variable de sustitución sin utilizar la función LENGTH */
DECLARE
    ENTERO NUMBER;
    CIFRAS NUMBER;
BEGIN
    CIFRAS := 1;
    ENTERO := &VALOR;
    DBMS_OUTPUT.PUT(chr(10) || 'EL NÚMERO '|| ENTERO ||' TIENE ');
    WHILE ENTERO > 9 LOOP
        ENTERO := FLOOR(ENTERO/10);
        CIFRAS := CIFRAS+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CIFRAS ||' CIFRAS');
END;

/* Crear una tabla llamada TANGULOS con tres columnas: ángulo, seno, coseno. Rellenarla mediante un bloque PL de todos los ángulos comprendidos entre 0 y 90, en intervalos de diez en diez */
CREATE TABLE TANGULOS
(
    ANGULO NUMBER(2),
    SENO NUMBER(5,3),
    COSENO NUMBER(5,3)
);

SET SERVEROUTPUT ON
DECLARE
    RAD NUMBER;
    ANGULO NUMBER;
    SENO NUMBER;
    COSENO NUMBER;
    CONVER NUMBER;
BEGIN
    ANGULO := 0;
    CONVER := 2*3.141592/360;
    WHILE ANGULO <= 90 LOOP
        RAD := ANGULO * CONVER;
        SENO := SIN(RAD);
        COSENO := COS(RAD);
        INSERT INTO TANGULOS VALUES (ANGULO, SENO, COSENO);
        ANGULO := ANGULO + 10;
    END LOOP;
END;

/* Dada una cadena introducida por teclado, obtiene como salida la cadena al revés */
SET SERVEROUTPUT ON
DECLARE
    R_CADENA VARCHAR2(20);
    I BINARY_INTEGER;
    CADENA VARCHAR2(20);
BEGIN
    CADENA := '&CADENA';
    I := LENGTH(CADENA);
    WHILE I >= 1 LOOP
        R_CADENA:=R_CADENA||SUBSTR(CADENA, I, 1);
        I := I-1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10) || CADENA || ' AL REVÉS ES ' || R_CADENA);
END;

/* Introducir un año por teclado, y decir si es bisiesto o no */
SET SERVEROUTPUT ON
DECLARE
    ANIO INTEGER;
BEGIN
    ANIO := &ANIO;
    IF MOD(ANIO, 4) = 0 THEN
        IF MOD(ANIO, 100) = 0 THEN
            IF MOD(ANIO, 400) = 0 THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ES BISIESTO');
            ELSE
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO ES BISIESTO');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'ES BISIESTO');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO ES BISIESTO');
    END IF;
END;

/* Programa que diga si un número introducido por teclado es capicúa o no y además cuente sus cifras */
SET SERVEROUTPUT ON
DECLARE
    N INTEGER;
    CONT INTEGER;
    COPIA INTEGER;
    INVERSO INTEGER;
    CIFRAS INTEGER;
BEGIN
    N := &N;
    COPIA := N;
    CIFRAS := 0;
    INVERSO := 0;
    LOOP
        INVERSO := INVERSO * 10 + MOD(N, 10);
        N := FLOOR(N/10);
        CIFRAS := CIFRAS + 1;
        EXIT WHEN N = 0;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10) || COPIA ||' TIENE '|| CIFRAS ||' CIFRAS');
    IF INVERSO = COPIA THEN
    DBMS_OUTPUT.PUT_LINE(COPIA ||' ES CAPICÚA');
    ELSE
    DBMS_OUTPUT.PUT_LINE(COPIA ||' NO ES CAPICÚA');
    END IF;
END;

/* Programa que calcule el factorial de un número introducido por teclado */
SET SERVEROUTPUT ON
DECLARE
    N NUMBER;
    FACTORIAL NUMBER := 1;
BEGIN
    N := &NUMERO;
    IF N = 0 THEN
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL FACTORIAL DE 0 ES 1');
    ELSIF N < 0 THEN
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'ES NEGATIVO, NO TIENE FACTORIAL');
    ELSE
    FOR I IN REVERSE 1..N LOOP
        FACTORIAL := FACTORIAL * I;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL FACTORIAL DE ' || N || ' ES ' || FACTORIAL);
    END IF;
END;
