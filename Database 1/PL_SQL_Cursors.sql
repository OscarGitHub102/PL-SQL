/* Programa que visualice el nombre del profesor la fecha de alta en la academia de la tabla PROFESORES */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C_PROF IS
        SELECT NOMPRO, FINPRO FROM PROFESORES ORDER BY FINPRO;
    V_NOMPRO PROFESORES.NOMPRO%TYPE;
    V_FINPRO PROFESORES.FINPRO%TYPE;
BEGIN
    OPEN C_PROF;
    FETCH C_PROF INTO V_NOMPRO, V_FINPRO;
    WHILE C_PROF%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(V_NOMPRO || ' - ' || V_FINPRO);
        FETCH C_PROF INTO V_NOMPRO, V_FINPRO;
    END LOOP;
    CLOSE C_PROF;
END;

/* Mediante cursores paramétricos, mostrar de la tabla CURSOS, los títulos de los cursos y su precio que han sido impartidos por el profesor que se introduzca por teclado */
SET SERVEROUTPUT ON
DECLARE
    COD CURSOS.NUMPRO%TYPE;
    CURSOR C1 IS
        SELECT TITCUR, PRECUR FROM CURSOS WHERE NUMPRO = COD;
    V_TITCUR CURSOS.TITCUR%TYPE;
    V_PRECUR CURSOS.PRECUR%TYPE;
BEGIN
    COD := &CODIGO;
    OPEN C1;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL PROFESOR ' || COD || ' HA IMPARTIDO');
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    LOOP
        FETCH C1 INTO V_TITCUR, V_PRECUR;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EL CURSO "' || V_TITCUR || '" CON PRECIO: ' || V_PRECUR || '€');
    END LOOP;
    CLOSE C1;
END;

/* Crear una tabla llamada PROFESORES2 que sea copia de PROFESORES. Crear un programa PL que permita borrar a los profesores de la tabla PROFESORES2 que no tienen comisión y los que tienen se dividirá entre dos */
CREATE TABLE PROFESORES2 AS SELECT * FROM PROFESORES;
DECLARE
    CURSOR C IS
        SELECT SALPRO, COMPRO FROM PROFESORES2 FOR UPDATE;
    V_SALPRO PROFESORES2.SALPRO%TYPE;
    V_COMPRO PROFESORES2.COMPRO%TYPE;
BEGIN
    OPEN C;
    LOOP
        FETCH C INTO V_SALPRO, V_COMPRO;
        EXIT WHEN C%NOTFOUND;
        IF V_COMPRO IS NULL THEN
            DELETE FROM PROFESORES2 WHERE CURRENT OF C;
        ELSE
            UPDATE PROFESORES2 SET COMPRO = COMPRO / 2 WHERE CURRENT OF C;
        END IF;
    END LOOP;
    CLOSE C;
END;

/* Programa PL que muestre el nombre del profesor y el nombre de los cursores con las horas que haya realizado */
SET SERVEROUTPUT ON
DECLARE
    NOMBRE PROFESORES.NOMPRO%TYPE;
    CURSO CURSOS.TITCUR%TYPE;
    HORAS CURSOS.HORCUR%TYPE;
    CURSOR C1 IS
        SELECT P.NOMPRO, C.TITCUR, C.HORCUR FROM PROFESORES P, CURSOS C WHERE P.NUMPRO = C.NUMPRO;
BEGIN
    OPEN C1;
    FETCH C1 INTO NOMBRE, CURSO, HORAS;
    WHILE C1%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(NOMBRE || ' - ' || CURSO || ' - ' || HORAS);
        FETCH C1 INTO NOMBRE, CURSO, HORAS;
    END LOOP;
    CLOSE C1;
END;

/* Bloque PL que, recibiendo una cadena, muestre los nombres de los profesores y los nombres de los cursos de aquellos profesores que lleven esa cadena en su nombre */
SET SERVEROUTPUT ON
DECLARE
    V_NOMBRE PROFESORES.NOMPRO%TYPE;
    V_NOMCUR CURSOS.TITCUR%TYPE;
    CURSOR C1 (CADENA PROFESORES.NOMPRO%TYPE) IS
        SELECT NOMPRO, TITCUR FROM PROFESORES P, CURSOS C WHERE C.NUMPRO = P.NUMPRO AND P.NOMPRO LIKE '%'|| CADENA ||'%';
BEGIN
    OPEN C1('&CAD');
    FETCH C1 INTO V_NOMBRE, V_NOMCUR;
    WHILE C1%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('EL PROFESOR/A '||V_NOMBRE||' IMPARTE CLASES EN EL CURSO '||V_NOMCUR);
        FETCH C1 INTO V_NOMBRE, V_NOMCUR;
    END LOOP;
    CLOSE C1;
END;

/* Bloque PL que muestre el profesor que más gana por especialidad */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C_PROF IS
        SELECT NOMPRO, SALPRO, ESPPRO FROM PROFESORES ORDER BY ESPPRO;
    TEMPORAL C_PROF%ROWTYPE;
    ESP_ANT PROFESORES.ESPPRO%TYPE := '*';
    VAR1 PROFESORES.NOMPRO%TYPE;
BEGIN
    OPEN C_PROF;
    FETCH C_PROF INTO TEMPORAL;
    WHILE C_PROF%FOUND LOOP
        IF TEMPORAL.ESPPRO <> ESP_ANT THEN
            ESP_ANT := TEMPORAL.ESPPRO;
            SELECT NOMPRO INTO VAR1 FROM PROFESORES WHERE SALPRO = (SELECT MAX(SALPRO) FROM PROFESORES WHERE ESPPRO=TEMPORAL.ESPPRO) AND ESPPRO = TEMPORAL.ESPPRO;
            DBMS_OUTPUT.PUT_LINE(TEMPORAL.ESPPRO || ': ' || VAR1);
        END IF;
        FETCH C_PROF INTO TEMPORAL;
    END LOOP;
    CLOSE C_PROF;
END;

/* Bloque PL que, introduciendo primero el número de alumnos que se desean visualizar, y después el código de un curso, muestre el nombre del curso y el nombre, correo y nota de los alumnos que están matriculados, siempre que tengan el curso aprobado */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 (CODIGO MATRICULADO.NUMCUR%TYPE) IS
        SELECT TITCUR, NOMALU, EMAALU, CALIFIC FROM ALUMNOS A, MATRICULADO M, CURSOS C WHERE A.NUMALU = M.NUMALU AND M.NUMCUR = C.NUMCUR AND CALIFIC >= 5 AND CODIGO = M.NUMCUR ORDER BY 4 DESC;
    REGIS C1%ROWTYPE;
    V_NUM NUMBER:= &NUMERO;
BEGIN
    OPEN C1(&COD_CURSO);
    FETCH C1 INTO REGIS;
    DBMS_OUTPUT.PUT_LINE(chr(10) || REGIS.TITCUR);
    WHILE (C1%ROWCOUNT <= V_NUM AND C1%FOUND) LOOP
        DBMS_OUTPUT.PUT_LINE(REGIS.NOMALU || ' * ' || REGIS.EMAALU || ' * ' || REGIS.CALIFIC);    
        FETCH C1 INTO REGIS;
    END LOOP;
    CLOSE C1;
END;

/* Visualizar por especialidad de la tabla PROFESORES el nombre de la especialidad y la media de los salarios más la comisión (si es nula se pone a cero). Sin utilizar funciones de grupo */
DECLARE
    V_ESPPRO PROFESORES.ESPPRO%TYPE;
    CONTADOR NUMBER;
    V_SALTOT NUMBER;
    V_MEDIA NUMBER;
    V_SIGUIENTE PROFESORES.ESPPRO%TYPE := '';
    CURSOR C IS
        SELECT ESPPRO, (SALPRO + NVL(COMPRO, 0)) SALTOT FROM PROFESORES ORDER BY 1;
BEGIN
    OPEN C;
    FETCH C INTO V_ESPPRO, V_SALTOT;
    WHILE C%FOUND LOOP
        V_SIGUIENTE := V_ESPPRO;
        V_MEDIA := 0;
        CONTADOR := 0;
        WHILE (V_SIGUIENTE = V_ESPPRO AND C%FOUND) LOOP
            V_MEDIA:= V_MEDIA + V_SALTOT;
            CONTADOR := CONTADOR + 1;
            FETCH C INTO V_ESPPRO, V_SALTOT;
        END LOOP;
        V_MEDIA := TRUNC((V_MEDIA / CONTADOR), 2);
        DBMS_OUTPUT.PUT_LINE ('LA ESPECIALIDAD ' || V_SIGUIENTE || ' TIENE UNA MEDIA DE SALARIOS DE ' || V_MEDIA || '€');
        V_SIGUIENTE := V_ESPPRO;
        END LOOP;
    CLOSE C;
END;

/* Programa que visualice el curso más barato por profesor que lo imparte */
SET SERVEROUTPUT ON
DECLARE 
    CURSOR C1 IS
        SELECT TITCUR, PRECUR, NOMPRO FROM PROFESORES P, CURSOS C WHERE P.NUMPRO = C.NUMPRO ORDER BY NOMPRO ASC;
    NOMBRE PROFESORES.NOMPRO%TYPE;
    PRECIO CURSOS.PRECUR%TYPE;
    CURSO CURSOS.TITCUR%TYPE;
    NOM PROFESORES.NOMPRO%TYPE;
    PREC CURSOS.PRECUR%TYPE;
    CUR CURSOS.TITCUR%TYPE;
BEGIN
    OPEN C1;
    FETCH C1 INTO CURSO, PRECIO, NOMBRE;
    CUR := CURSO;    
    PREC := PRECIO;
    NOM := NOMBRE;
    WHILE C1%FOUND LOOP
        IF(NOMBRE = NOM) THEN
            IF(PRECIO < PREC) THEN
                PREC := PRECIO;
                CUR := CURSO;
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL CURSO MÁS BARATO DEL PROFESOR ' || NOM || ' ES ' || CUR || ' CON ' || PREC || '€');             
            NOM := NOMBRE;
            PREC := PRECIO;
            CUR := CURSO;
        END IF;
        FETCH C1 INTO CURSO, PRECIO, NOMBRE;
    END LOOP;
    CLOSE C1;
END;
