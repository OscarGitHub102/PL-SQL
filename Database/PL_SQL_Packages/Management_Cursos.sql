/* Crear un paquete para la gesti�n de la tabla CURSOS:
    1. Insertar un nuevo curso, introduciendo los atributos de la tabla. Controlar como excepci�n si se repitiera el n�mero del curso
    2. Modificar la fecha de inicio, introduciendo el n�mero del curso y la nueva fecha de inicio como par�metros de entrada
    3. Modificar la fecha final, introduciendo el n�mero del curso y la nueva fecha de finalizaci�n como par�metros de entrada
    4. Incrementar el precio de un curso (porcentaje), introduciendo el n�mero del curso y el porcentaje como par�metros de entrada.
    5. Reducir el precio de un curso (porcentaje), introduciendo el n�mero del curso y el porcentaje como par�metros de entrada.
    6. Incrementar el precio de un curso (porcentaje), introduciendo el n�mero del profesor y el porcentaje como par�metros de entrada.
    7. Reducir el precio de un curso (porcentaje), introduciendo el n�mero del profesor y el porcentaje como par�metros de entrada.
    8. Visualizar los datos del curso, introduciendo el n�mero del curso como par�metro de entrada
    9. Visualizar los datos del curso, introduciendo el nombre del curso como par�metro de entrada
    10. Visualizar los cursos que tienen m�s cr�ditos
    11. Borrar un curso, introduciendo el n�mero del curso como par�metro de entrada. Controlar como excepci�n si no existiera el curso
    12. (FUNCI�N INTERNA)s Buscar un curso por el nombre, introduciendo el nombre del curso como par�metro de entrada
    13. (PROCEDIMIENTO INTERNO) Visualizar los datos del curso */
    
CREATE OR REPLACE PACKAGE GESTION_CURSOS AS
    
    PROCEDURE INSERTAR_CURSO
    (V_NUMCUR CURSOS.NUMCUR%TYPE,
    V_TITCUR CURSOS.TITCUR%TYPE,
    V_PRECUR CURSOS.PRECUR%TYPE,
    V_EDICUR CURSOS.EDICUR%TYPE,
    V_HORCUR CURSOS.HORCUR%TYPE,
    V_FINCUR CURSOS.FINCUR%TYPE,
    V_FFICUR CURSOS.FFICUR%TYPE,
    V_CRECUR CURSOS.CRECUR%TYPE,
    V_NUMPRO CURSOS.NUMPRO%TYPE);
    PROCEDURE MODIFICAR_FECHA_INICIO_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE, V_FECHAINI CURSOS.FINCUR%TYPE);
    PROCEDURE MODIFICAR_FECHA_FIN_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE, V_FECHA_FIN CURSOS.FINCUR%TYPE);
    PROCEDURE INCREMENTAR_PRECIO_CURSO_POR_NUM_CURSO(V_NUM_CURSO IN CURSOS.NUMCUR%TYPE, PORCENTAJE NUMBER);
    PROCEDURE REDUCIR_PRECIO_CURSO_POR_NUM_CURSO(V_NUM_CURSO IN CURSOS.NUMCUR%TYPE, PORCENTAJE NUMBER);
    PROCEDURE INCREMENTAR_PRECIO_CURSO_POR_NUM_PROFESOR(V_NUM_PROFESOR CURSOS.NUMPRO%TYPE, PORCENTAJE NUMBER);
    PROCEDURE REDUCIR_PRECIO_CURSO_POR_NUM_PROFESOR(V_NUM_PROFESOR CURSOS.NUMPRO%TYPE, PORCENTAJE NUMBER);
    PROCEDURE VISUALIZAR_DATOS_CURSO_POR_NUM_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE);
    PROCEDURE VISUALIZAR_DATOS_CURSO_POR_TITULO(V_TITULO_CURSO CURSOS.TITCUR%TYPE);
    PROCEDURE MAX_CREDITOS_CURSO;
    PROCEDURE BORRAR_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE);
    
END GESTION_CURSOS;
/

------------------------------------

CREATE OR REPLACE PACKAGE BODY GESTION_CURSOS AS
    FUNCTION BUSCAR_CURSO_POR_TITULO(V_NOM_CURSO CURSOS.TITCUR%TYPE)
        RETURN NUMBER;
    PROCEDURE VER_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE);

------------
    
    PROCEDURE INSERTAR_CURSO
    (V_NUMCUR CURSOS.NUMCUR%TYPE,
    V_TITCUR CURSOS.TITCUR%TYPE,
    V_PRECUR CURSOS.PRECUR%TYPE,
    V_EDICUR CURSOS.EDICUR%TYPE,
    V_HORCUR CURSOS.HORCUR%TYPE,
    V_FINCUR CURSOS.FINCUR%TYPE,
    V_FFICUR CURSOS.FFICUR%TYPE,
    V_CRECUR CURSOS.CRECUR%TYPE,
    V_NUMPRO CURSOS.NUMPRO%TYPE)
    IS
    BEGIN
        INSERT INTO CURSOS VALUES(V_NUMCUR, V_TITCUR, V_PRECUR, V_EDICUR, V_HORCUR, V_FINCUR, V_FFICUR, V_CRECUR, V_NUMPRO);
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'SE HA INSERTADO EL CURSO ' || V_NUMCUR || ' DE T�TULO ' || V_TITCUR);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ERROR. N�MERO DE CURSO DUPLICADO');
    END INSERTAR_CURSO;

------------
    
    PROCEDURE MODIFICAR_FECHA_INICIO_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE, V_FECHAINI CURSOS.FINCUR%TYPE)
    IS
    BEGIN
        UPDATE CURSOS SET FINCUR = V_FECHAINI WHERE NUMCUR = V_NUM_CURSO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL CURSO NO EXISTE Y NO SE HA PODIDO MODIFICAR');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'SE HA MODIFICADO LA FECHA DE INICIO DEL CURSO ' || V_NUM_CURSO);
        END IF;
    END MODIFICAR_FECHA_INICIO_CURSO;

------------
    
    PROCEDURE MODIFICAR_FECHA_FIN_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE, V_FECHA_FIN CURSOS.FINCUR%TYPE)
    IS
    BEGIN
        UPDATE CURSOS SET FFICUR = V_FECHA_FIN WHERE NUMCUR = V_NUM_CURSO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL CURSO NO EXISTE Y NO SE HA PODIDO MODIFICAR');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'SE HA MODIFICADO LA FECHA DE INICIO DEL CURSO ' || V_NUM_CURSO);
        END IF;
    END MODIFICAR_FECHA_FIN_CURSO;

------------

    PROCEDURE INCREMENTAR_PRECIO_CURSO_POR_NUM_CURSO(V_NUM_CURSO IN CURSOS.NUMCUR%TYPE, PORCENTAJE NUMBER)
    IS
    BEGIN
        UPDATE CURSOS SET PRECUR = PRECUR + ((PRECUR * PORCENTAJE) / 100) WHERE NUMCUR = V_NUM_CURSO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'CURSO NO ENCONTRADO');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'PRECIO DEL CURSO DE C�DIGO ' || V_NUM_CURSO || ' INCREMENTADO CORRECTAMENTE');
        END IF;   
    END INCREMENTAR_PRECIO_CURSO_POR_NUM_CURSO;

------------

    PROCEDURE REDUCIR_PRECIO_CURSO_POR_NUM_CURSO(V_NUM_CURSO IN CURSOS.NUMCUR%TYPE, PORCENTAJE NUMBER)
    IS
    BEGIN
        UPDATE CURSOS SET PRECUR = PRECUR - ((PRECUR * PORCENTAJE) / 100) WHERE NUMCUR = V_NUM_CURSO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'CURSO NO ENCONTRADO');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'PRECIO DEL CURSO DE C�DIGO ' || V_NUM_CURSO || ' REDUCIDO CORRECTAMENTE');
        END IF;   
    END REDUCIR_PRECIO_CURSO_POR_NUM_CURSO;

------------

    PROCEDURE INCREMENTAR_PRECIO_CURSO_POR_NUM_PROFESOR(V_NUM_PROFESOR CURSOS.NUMPRO%TYPE, PORCENTAJE NUMBER)
    IS
        CURSOR C1 IS 
            SELECT NUMPRO, TITCUR, PRECUR FROM CURSOS WHERE NUMPRO = V_NUM_PROFESOR;
        REG C1%ROWTYPE;
    BEGIN
        OPEN C1;
        FETCH C1 INTO REG;
        WHILE C1%FOUND LOOP
            UPDATE CURSOS SET PRECUR = PRECUR + ((PRECUR * PORCENTAJE) / 100) WHERE NUMPRO = V_NUM_PROFESOR;
            FETCH C1 INTO REG;   
        END LOOP;
        IF C1%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL PRECIO DE LOS CURSOS IMPARTIDOS POR EL PROFESOR DE C�DIGO ' || V_NUM_PROFESOR || ' SE HAN INCREMENTADO CORRECTAMENTE');        
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO SE ENCONTRARON CURSOS IMPARTIDOS POR EL PROFESOR DE C�DIGO ' || V_NUM_PROFESOR);
        END IF;
        CLOSE C1;
    END INCREMENTAR_PRECIO_CURSO_POR_NUM_PROFESOR;
    
------------    
    
    PROCEDURE REDUCIR_PRECIO_CURSO_POR_NUM_PROFESOR(V_NUM_PROFESOR CURSOS.NUMPRO%TYPE, PORCENTAJE NUMBER)
    IS
        CURSOR C1 IS 
            SELECT NUMPRO, TITCUR, PRECUR FROM CURSOS WHERE NUMPRO = V_NUM_PROFESOR;
        REG C1%ROWTYPE;
    BEGIN
        OPEN C1;
        FETCH C1 INTO REG;
        WHILE C1%FOUND LOOP
            UPDATE CURSOS SET PRECUR = PRECUR - ((PRECUR * PORCENTAJE) / 100) WHERE NUMPRO = V_NUM_PROFESOR;
            FETCH C1 INTO REG;   
        END LOOP;
        IF C1%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'EL PRECIO DE LOS CURSOS IMPARTIDOS POR EL PROFESOR DE C�DIGO ' || V_NUM_PROFESOR || ' SE HAN REDUCIDO CORRECTAMENTE');        
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO SE ENCONTRARON CURSOS IMPARTIDOS POR EL PROFESOR DE C�DIGO ' || V_NUM_PROFESOR);
        END IF;
        CLOSE C1;
    END REDUCIR_PRECIO_CURSO_POR_NUM_PROFESOR;

------------
    
    PROCEDURE VISUALIZAR_DATOS_CURSO_POR_NUM_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE)
    IS
    BEGIN
        VER_CURSO(V_NUM_CURSO);        
    END VISUALIZAR_DATOS_CURSO_POR_NUM_CURSO;

------------
    
    PROCEDURE VISUALIZAR_DATOS_CURSO_POR_TITULO(V_TITULO_CURSO CURSOS.TITCUR%TYPE)
    IS
        V_NUM_CURSO CURSOS.NUMCUR%TYPE;
    BEGIN
        V_NUM_CURSO := BUSCAR_CURSO_POR_TITULO(UPPER(V_TITULO_CURSO));
        VER_CURSO(V_NUM_CURSO);
    END VISUALIZAR_DATOS_CURSO_POR_TITULO;

------------

    PROCEDURE MAX_CREDITOS_CURSO
    IS
        CURSOR C1 IS
            SELECT TITCUR, CRECUR FROM CURSOS WHERE CRECUR = (SELECT MAX(CRECUR) FROM CURSOS);
        REG C1%ROWTYPE;
    BEGIN
        OPEN C1;
        FETCH C1 INTO REG;
        WHILE C1%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(chr(10) || REG.TITCUR || ' TIENE: ' || REG.CRECUR );
            FETCH C1 INTO REG;
        END LOOP;
        CLOSE C1;
    END MAX_CREDITOS_CURSO;

------------

    PROCEDURE BORRAR_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE)
    IS
        CONTADOR NUMBER := 0;
        NO_EXISTE_CURSO EXCEPTION;
    BEGIN
        SELECT COUNT(NUMCUR) INTO CONTADOR FROM CURSOS WHERE NUMCUR = V_NUM_CURSO;
        IF CONTADOR = 0 THEN
            RAISE NO_EXISTE_CURSO;
        ELSE
            DELETE FROM CURSOS WHERE NUMCUR = V_NUM_CURSO;
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'CURSO ' || V_NUM_CURSO || ' BORRADO CORRECTAMENTE');
        END IF;
        EXCEPTION
            WHEN NO_EXISTE_CURSO THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ERROR. NO EXISTE DICHO CURSO');
    END BORRAR_CURSO; 

------------

    FUNCTION BUSCAR_CURSO_POR_TITULO(V_NOM_CURSO CURSOS.TITCUR%TYPE)
    RETURN NUMBER
    IS
        COD CURSOS.NUMCUR%TYPE;
    BEGIN
        SELECT NUMCUR INTO COD FROM CURSOS WHERE TITCUR = V_NOM_CURSO; 
        RETURN COD;    
    END BUSCAR_CURSO_POR_TITULO;
 
------------    
    
    PROCEDURE VER_CURSO(V_NUM_CURSO CURSOS.NUMCUR%TYPE)
    IS
        REG_CURSO CURSOS%ROWTYPE;
    BEGIN
        SELECT * INTO REG_CURSO FROM CURSOS WHERE NUMCUR = V_NUM_CURSO;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'N�MERO: ' || REG_CURSO.NUMCUR);
        DBMS_OUTPUT.PUT_LINE('T�TULO: ' || REG_CURSO.TITCUR);
        DBMS_OUTPUT.PUT_LINE('PRECIO: ' || REG_CURSO.PRECUR);
        DBMS_OUTPUT.PUT_LINE('EDICI�N: ' || REG_CURSO.EDICUR);
        DBMS_OUTPUT.PUT_LINE('HORAS: ' || REG_CURSO.HORCUR);
        DBMS_OUTPUT.PUT_LINE('FECHA DE INICIO: ' || REG_CURSO.FINCUR);
        DBMS_OUTPUT.PUT_LINE('FECHA DE FINAL: ' || REG_CURSO.FFICUR);
        DBMS_OUTPUT.PUT_LINE('CR�DITOS: ' || REG_CURSO.CRECUR);
        DBMS_OUTPUT.PUT_LINE('N�MERO PROFESOR: ' || REG_CURSO.NUMPRO);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO SE ENCONTR� EL CURSO');   
    END VER_CURSO;
    
END GESTION_CURSOS;