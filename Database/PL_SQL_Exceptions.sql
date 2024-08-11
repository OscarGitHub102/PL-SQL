/* Programa que permita introducir dos datos y divida el primero entre el segundo. Tratar las excepciones que puedan surgir */
SET SERVEROUTPUT ON
DECLARE
    PRIMERO NUMBER := &1;
    SEGUNDO NUMBER := &2;
    DIVISION NUMBER;
BEGIN
    DIVISION := PRIMERO / SEGUNDO;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL RESULTADO DE LA DIVISIÓN ES: ' || TRUNC(DIVISION, 2));
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'IMPOSIBLE DIVIDIR POR 0');
END;

/* Definir un cursor que seleccione NOMPRO y COMPRO, ordenado por comisión de la tabla PROFESORES. Transferir a la tabla OTRA solo aquellos cuya comisión sea no nula */
CREATE TABLE OTRA(
NOMPRO VARCHAR2(30),
COMPRO NUMBER(8, 2));

SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NOMPRO, COMPRO FROM PROFESORES ORDER BY 2;
    V_NOMPRO PROFESORES.NOMPRO%TYPE;
    V_COMPRO PROFESORES.COMPRO%TYPE;
    I BINARY_INTEGER := 10;
    CONT NUMBER := 0;
    ERROR_COMISION EXCEPTION;
BEGIN
    OPEN C1;
    FETCH C1 INTO V_NOMPRO, V_COMPRO;
    WHILE (C1%ROWCOUNT <= I) AND (C1%FOUND) LOOP
        IF V_COMPRO IS NULL THEN
            RAISE ERROR_COMISION;
        END IF;
        CONT := CONT + 1;
        INSERT INTO OTRA VALUES (V_NOMPRO, V_COMPRO);
        FETCH C1 INTO V_NOMPRO, V_COMPRO;
    END LOOP;
    CLOSE C1;
    EXCEPTION
        WHEN ERROR_COMISION THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || CONT || ' REGISTROS INTRODUCIDOS');
END;

/* Utilización de PRAGMA EXCPETION_INIT. En primer lugar, definir la excepción, después asociar al código de error 54, cuando se produzca ese error se visualizará el mensaje al final; cuando se produzca este error se mostrará el mensaje (-20001, 'ESTE REGISTRO ESTÁ BLOQUEADO') */
SET SERVEROUTPUT ON
DECLARE
    REG_BLOQUEADO EXCEPTION;
    PRAGMA EXCEPTION_INIT(REG_BLOQUEADO, -54);
BEGIN
    FOR I IN (SELECT NOMPRO FROM PROFESORES WHERE NUMPRO = 106 FOR UPDATE NOWAIT) LOOP
        EXIT;
    END LOOP;
    EXCEPTION
        WHEN REG_BLOQUEADO THEN
            RAISE_APPLICATION_ERROR(-20001, 'ESTE REGISTRO ESTÁ BLOQUEADO');
END;

/* Utilizando el paquete RAISE_APPLICATION_ERROR, obtener un mensaje de error que diga si el salario es mayor de 1000€, este está actualizado; en caso contrario, subir el salario un 7,5%. El número del profesor se introducirá por teclado mediante una variable de sustitución */
SET SERVEROUTPUT ON
DECLARE
    SALARIO_ACTUAL PROFESORES.SALPRO%TYPE;
    CODIGO NUMBER := &CODIGO_PRO;
BEGIN
    SELECT SALPRO INTO SALARIO_ACTUAL FROM PROFESORES WHERE NUMPRO = CODIGO;
    IF SALARIO_ACTUAL > 1000 THEN
        RAISE_APPLICATION_ERROR(-20010, 'SALARIO ACTUALIZADO');
    ELSE
        UPDATE PROFESORES SET SALPRO = SALPRO * 1.075 WHERE NUMPRO = CODIGO;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'EMPLEADO ' || CODIGO || ' ACTUALIZADO');
    END IF;    
END SUBIR_SUELDO;

/* Crear una tabla llamada OTRA que guardará los mensajes de las siguientes excepciones: excepciones internas NO_DATA_FOUND y TOO_MANY_ROWS, excepción definida por el usuario para controlar los espacios en blanco como primer carácter del nombre del profesor, y una excepción de que no hay espacio (asociada a errores del servidor y propagación) */
CREATE TABLE OTRA(COL1 VARCHAR2(50));

SET SERVEROUTPUT ON
DECLARE
    COD_ERROR NUMBER(6);
    VCOD VARCHAR2(10);
    VNOM VARCHAR2(15);
    ERR_BLANCOS EXCEPTION;
    NO_HAY_ESPACIO EXCEPTION;
    PRAGMA EXCEPTION_INIT(NO_HAY_ESPACIO, -1547);
BEGIN
    SELECT NUMPRO, NOMPRO INTO VCOD, VNOM FROM PROFESORES;
    IF SUBSTR(VNOM, 1, 1) <= ' ' THEN
        RAISE ERR_BLANCOS;
    END IF;
    UPDATE PROFESORES SET NOMPRO = VNOM WHERE NUMPRO = VCOD;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO OTRA(COL1) VALUES ('ERROR, NO HABÍA DATOS');
        WHEN TOO_MANY_ROWS THEN
            INSERT INTO OTRA(COL1) VALUES ('ERROR, DEMASIADOS DATOS');
        WHEN ERR_BLANCOS THEN
            INSERT INTO OTRA(COL1) VALUES ('ERROR BLANCOS');
        WHEN NO_HAY_ESPACIO THEN
            INSERT INTO OTRA(COL1) VALUES ('ERROR TABLESPACE');
        WHEN OTHERS THEN
            COD_ERROR := SQLCODE;
            INSERT INTO OTRA(COL1) VALUES (COD_ERROR);
END;

/* Bloque PL sobre la tabla PROFESORES, que pasando por teclado el número de profesor, controle las siguientes excepciones: si el número de profesores es menor de 10 que se lance un mensaje que diga que hay menos de 10 profesores (definida por el usuario), una segunda que al dividir el salario entre la comisión (si esta es nula se convierte a cero) genere un mensaje que diga que no se puede dividir entre cero y si aparece cualquier otra que diga que se ha producido una excepción no tratada */
SET SERVEROUTPUT ON
DECLARE
    POCOS_PROFE EXCEPTION;
    NPRO NUMBER(4) := 0;
    SALAR NUMBER(8, 2) := 0;
    COMIS NUMBER(8, 2) := 0;
    PROPORCION NUMBER;
BEGIN
    SELECT COUNT(*) INTO NPRO FROM PROFESORES;
    IF NPRO < 10 THEN
        RAISE POCOS_PROFE;
    END IF;
    SELECT SALPRO, NVL(COMPRO, 0) INTO SALAR, COMIS FROM PROFESORES WHERE NUMPRO = &NÚMERO_PROFESOR;
    PROPORCION := SALAR / COMIS;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'LA PROPORCIÓN ES: ' || TRUNC(PROPORCION, 2));
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE('NO SE PUEDE DIVIDIR UN NÚMERO ENTRE CERO');
        WHEN POCOS_PROFE THEN
            DBMS_OUTPUT.PUT_LINE('HAY MENOS DE 10 PROFESORES');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('SE HA PRODUCIDO OTRA EXCEPCIÓN NO TRATADA');    
END;

/* Bloque PL que suba el precio de los cursos un 10%, introduciendo por teclado el código del curso que se quiere subir. Si el precio del curso es mayor de 480€ no se actualizará y se lanzará un mensaje (-20301, 'NO SE PUEDE INCREMENTAR EL PRECIO DEL CURSO POR SER MAYOR A 480€'); para ello utilizará el paquete RAISE_APPLICATION_ERROR */
SET SERVEROUTPUT ON
DECLARE
    PRECUR_SUBIDA CURSOS.PRECUR%TYPE;
    CODIGO CURSOS.NUMCUR%TYPE := &CODIGO_CURSOS;
BEGIN
    SELECT PRECUR INTO PRECUR_SUBIDA FROM CURSOS WHERE NUMCUR = CODIGO;
    IF PRECUR_SUBIDA > 480 THEN
        RAISE_APPLICATION_ERROR(-20301, 'NO SE PUEDE INCREMENTAR EL PRECIO DEL CURSO POR SER MAYOR A 480€');
    ELSE
        UPDATE CURSOS SET PRECUR = PRECUR * 1.1 WHERE NUMCUR = CODIGO;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'SE HA ACTUALIZADO EL REGISTRO CON CÓDIGO ' || CODIGO);
    END IF;
END;

/* Bloque PL que permita incrementar la comisión un 7.5% a un profesor de la tabla PROFESORES introducido por teclado. Habrá que tener en cuenta que, si la consulta no devuelve ninguna fila, se visualizará un mensaje 'ERROR. NO ENCONTRADO' y, si la comisión es nula, otro mensaje que diga 'ERROR. COMISIÓN NULA' */
SET SERVEROUTPUT ON
DECLARE
    COMISION_NULA EXCEPTION;
    CODIGO PROFESORES.NUMPRO%TYPE := &CODIGO_PROFESOR;
    PROFESOR_SUBIDA PROFESORES.COMPRO%TYPE;
BEGIN
    SELECT COMPRO INTO PROFESOR_SUBIDA FROM PROFESORES WHERE NUMPRO = CODIGO;
    IF PROFESOR_SUBIDA IS NULL THEN
        RAISE COMISION_NULA;
    ELSE
        UPDATE PROFESORES SET COMPRO = COMPRO + (COMPRO * 0.075) WHERE NUMPRO = CODIGO;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'LA COMISIÓN HA SUBIDO UN 7.5%, QUE ES IGUAL A '|| TRUNC(PROFESOR_SUBIDA * 0.075, 2));
    END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR. NO ENCONTRADO');
        WHEN COMISION_NULA THEN
            DBMS_OUTPUT.PUT_LINE('ERROR. COMISIÓN NULA');
END;

/* Programa PL que suba la comisión 50€ a un profesor de la tabla PROFESORES introducido por teclado, teniendo en cuenta que, si esta fuese nula, se lanzará un mensaje (-20010, 'NO SE PUEDE INCREMENTAR POR SER NULA'). Se utilizará el paquete RAISE_APPLICATION_ERROR */
SET SERVEROUTPUT ON
DECLARE
    V_PROFESOR_ID PROFESORES.NUMPRO%TYPE := &PROFESOR_ID;
    V_COMISION PROFESORES.COMPRO%TYPE;
BEGIN
    SELECT COMPRO INTO V_COMISION FROM PROFESORES WHERE NUMPRO = V_PROFESOR_ID;
    IF V_COMISION IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'NO SE PUEDE INCREMENTAR POR SER NULA');
    ELSE
        UPDATE PROFESORES SET COMPRO = COMPRO + 50 WHERE NUMPRO = V_PROFESOR_ID;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'COMISIÓN INCREMENTADA EN 50€ PARA EL PROFESOR ' || V_PROFESOR_ID);
    END IF;
END;

/* Programa que, pasando por teclado un número de profesor y un valor, incremente el salario de ese profesor ese valor. Controlar con excepciones: si el salario es nulo y si no se encuentra al profesor */
SET SERVEROUTPUT ON
DECLARE
    SALARIO_PROFESORES PROFESORES.SALPRO%TYPE;
    CODIGO_PROF PROFESORES.NUMPRO%TYPE := &CODIGO_PROFESOR;
    INCREMENTAR_SALARIO PROFESORES.SALPRO%TYPE := &INCREMENTO;
    SALARIO_NULO EXCEPTION;
BEGIN
    SELECT SALPRO INTO SALARIO_PROFESORES FROM PROFESORES WHERE NUMPRO = CODIGO_PROF;
    IF SALARIO_PROFESORES IS NULL THEN
        RAISE SALARIO_NULO;
    ELSE
        UPDATE PROFESORES SET SALPRO = SALPRO + INCREMENTAR_SALARIO WHERE NUMPRO = CODIGO_PROF;
        SELECT SALPRO INTO SALARIO_PROFESORES FROM PROFESORES WHERE NUMPRO = CODIGO_PROF;
        DBMS_OUTPUT.PUT_LINE (chr(10) || 'EL SALARIO SE HA ACTUALIZADO A: '|| SALARIO_PROFESORES || '€');
    END IF;
    EXCEPTION
        WHEN SALARIO_NULO THEN
            DBMS_OUTPUT.PUT_LINE (chr(10) || 'EL SALARIO ES NULO, NO SE PUEDE INCREMENTAR');
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE (chr(10) || 'NO SE HAN ENCONTRADO DATOS');
END;