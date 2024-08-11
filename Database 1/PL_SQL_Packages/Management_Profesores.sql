/* Crear un paquete para la gesti�n de la tabla PROFESORES:
    1. Insertar un nuevo profesor, introduciendo los atributos de la tabla. Controlar como excepci�n si se repitiera el n�mero del profesor.
    2. Incrementar el salario de un profesor (porcentaje), introduciendo el n�mero del profesor y el porcentaje como par�metros de entrada.
    3. Reducir el salario de un profesor (porcentaje), introduciendo el n�mero del profesor y el porcentaje como par�metros de entrada.
    4. Incrementar el salario de todos los profesores (porcentaje), introduciendo el porcentaje como par�metro de entrada.
    5. Reducir el salario de todos los profesores (porcentaje), introduciendo el porcentaje como par�metro de entrada.
    6. Visualizar los datos del profesor, introduciendo el n�mero del profesor como par�metro de entrada
    7. Visualizar los datos del profesor, introduciendo el nombre del profesor como par�metro de entrada
    8. Mostrar los nombres de los profesores, introduciendo la especialidad como par�metro de entrada.
    9. Calcular y devolver la edad de un profesor, introduciendo el n�mero del profesor como par�metro de entrada.
    10. Borrar un profesor, introduciendo el n�mero del profesor como par�metro de entrada. Al borrar el profesor todos los que depend�an de �l pasan a su jefe. Controlar como excepci�n si no existiera el profesor.
    11. (FUNCI�N INTERNA) Buscar un profesor por el nombre, introduciendo el nombre del profesor como par�metro de entrada.
    12. (PROCEDIMIENTO INTERNO) Visualizar los datos del profesor */ 
    
CREATE OR REPLACE PACKAGE GESTION_PROFESORES AS
    
    PROCEDURE INSERTAR_PROFESOR
    (V_NUMPRO PROFESORES.NUMPRO%TYPE,
    V_NOMPRO PROFESORES.NOMPRO%TYPE,
    V_FNAPRO PROFESORES.FNAPRO%TYPE,
    V_JEFPRO PROFESORES.JEFPRO%TYPE,
    V_FINPRO PROFESORES.FINPRO%TYPE,
    V_SALPRO PROFESORES.SALPRO%TYPE,
    V_COMPRO PROFESORES.COMPRO%TYPE,
    V_ESPPRO PROFESORES.ESPPRO%TYPE);
    PROCEDURE INCREMENTAR_SALARIO(V_NUMPRO IN PROFESORES.NUMPRO%TYPE, PORCENTAJE NUMBER);
    PROCEDURE REDUCIR_SALARIO(V_NUMPRO IN PROFESORES.NUMPRO%TYPE, PORCENTAJE NUMBER);
    PROCEDURE INCREMENTAR_SALARIO_PROFESORES(PORCENTAJE NUMBER);
    PROCEDURE REDUCIR_SALARIO_PROFESORES(PORCENTAJE NUMBER);
    PROCEDURE VISUALIZAR_DATOS_PROFESOR_POR_NUM_PROFESOR(V_NUM_PROFESOR PROFESORES.NUMPRO%TYPE);    
    PROCEDURE VISUALIZAR_DATOS_PROFESOR_POR_NOMBRE_PROFESOR(V_NOMBRE_PROFESOR PROFESORES.NOMPRO%TYPE);
    PROCEDURE MOSTRAR_PROFESOR(ESPE IN PROFESORES.ESPPRO%TYPE);
    FUNCTION VER_EDAD_PROFESOR(V_NUMPRO PROFESORES.NUMPRO%TYPE)
        RETURN NUMBER;
    PROCEDURE BORRAR_PROFESOR(V_NUM_PROF PROFESORES.NUMPRO%TYPE);
    
END GESTION_PROFESORES;
/

------------------------------------

CREATE OR REPLACE PACKAGE BODY GESTION_PROFESORES AS
    FUNCTION BUSCAR_PROFESOR_POR_NOMBRE(V_NOM_PROF PROFESORES.NOMPRO%TYPE)
        RETURN NUMBER;
    PROCEDURE VER_PROFESOR(V_NUM_PROF PROFESORES.NUMPRO%TYPE);    

------------
    
    PROCEDURE INSERTAR_PROFESOR
    (V_NUMPRO PROFESORES.NUMPRO%TYPE,
    V_NOMPRO PROFESORES.NOMPRO%TYPE,
    V_FNAPRO PROFESORES.FNAPRO%TYPE,
    V_JEFPRO PROFESORES.JEFPRO%TYPE,
    V_FINPRO PROFESORES.FINPRO%TYPE,
    V_SALPRO PROFESORES.SALPRO%TYPE,
    V_COMPRO PROFESORES.COMPRO%TYPE,
    V_ESPPRO PROFESORES.ESPPRO%TYPE)
    IS
    BEGIN
        INSERT INTO PROFESORES VALUES(V_NUMPRO, V_NOMPRO, V_FNAPRO, V_JEFPRO, V_FINPRO, V_SALPRO, V_COMPRO, V_ESPPRO);
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'SE HA INSERTADO EL PROFESOR ' || V_NUMPRO || ' DE NOMBRE ' || V_NOMPRO);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ERROR. N�MERO DE PROFESOR DUPLICADO');
    END INSERTAR_PROFESOR;

------------

    PROCEDURE INCREMENTAR_SALARIO(V_NUMPRO IN PROFESORES.NUMPRO%TYPE, PORCENTAJE NUMBER)
    IS
    BEGIN
        UPDATE PROFESORES SET SALPRO = SALPRO + ((SALPRO * PORCENTAJE) / 100) WHERE NUMPRO = V_NUMPRO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'PROFESOR NO ENCONTRADO');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'SALARIO DEL PROFESOR DE C�DIGO ' || V_NUMPRO || ' INCREMENTADO CORRECTAMENTE');       
        END IF;  
    END INCREMENTAR_SALARIO;
    
------------    
    
    PROCEDURE REDUCIR_SALARIO(V_NUMPRO IN PROFESORES.NUMPRO%TYPE, PORCENTAJE NUMBER)
    IS
    BEGIN
        UPDATE PROFESORES SET SALPRO = SALPRO - ((SALPRO * PORCENTAJE) / 100) WHERE NUMPRO = V_NUMPRO;
        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'PROFESOR NO ENCONTRADO');
        ELSE
            DBMS_OUTPUT.PUT_LINE(chr(10) || 'SALARIO DEL PROFESOR DE C�DIGO ' || V_NUMPRO || ' REDUCIDO CORRECTAMENTE');       
        END IF;   
    END REDUCIR_SALARIO;
   
------------    
    
    PROCEDURE INCREMENTAR_SALARIO_PROFESORES(PORCENTAJE NUMBER)
    IS
        CURSOR C1 IS
            SELECT NUMPRO, SALPRO FROM PROFESORES;
        V_NUMPRO PROFESORES.NUMPRO%TYPE;
        V_SALPRO PROFESORES.SALPRO%TYPE;    
    BEGIN
        OPEN C1;
        FETCH C1 INTO V_NUMPRO, V_SALPRO;
        WHILE C1%FOUND LOOP
            UPDATE PROFESORES SET SALPRO = SALPRO + ((SALPRO * PORCENTAJE) / 100) WHERE NUMPRO = V_NUMPRO;
            FETCH C1 INTO V_NUMPRO, V_SALPRO;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'SALARIOS DE TODOS LOS PROFESORES INCREMENTADOS UN ' || PORCENTAJE || '%');
    END INCREMENTAR_SALARIO_PROFESORES;
    
------------    
    
    PROCEDURE REDUCIR_SALARIO_PROFESORES(PORCENTAJE NUMBER)
    IS
        CURSOR C1 IS
            SELECT NUMPRO, SALPRO FROM PROFESORES;
        V_NUMPRO PROFESORES.NUMPRO%TYPE;
        V_SALPRO PROFESORES.SALPRO%TYPE;    
    BEGIN
        OPEN C1;
        FETCH C1 INTO V_NUMPRO, V_SALPRO;
        WHILE C1%FOUND LOOP
            UPDATE PROFESORES SET SALPRO = SALPRO - ((SALPRO * PORCENTAJE) / 100) WHERE NUMPRO = V_NUMPRO;
            FETCH C1 INTO V_NUMPRO, V_SALPRO;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'SALARIOS DE TODOS LOS PROFESORES REDUCIDOS UN ' || PORCENTAJE || '%');
    END REDUCIR_SALARIO_PROFESORES;
    
------------

    PROCEDURE VISUALIZAR_DATOS_PROFESOR_POR_NUM_PROFESOR(V_NUM_PROFESOR PROFESORES.NUMPRO%TYPE)
    IS
    BEGIN
        VER_PROFESOR(V_NUM_PROFESOR);
    END VISUALIZAR_DATOS_PROFESOR_POR_NUM_PROFESOR;
    
------------

    PROCEDURE VISUALIZAR_DATOS_PROFESOR_POR_NOMBRE_PROFESOR(V_NOMBRE_PROFESOR PROFESORES.NOMPRO%TYPE)
    IS
        V_NUM_PROF PROFESORES.NUMPRO%TYPE;
    BEGIN
        V_NUM_PROF := BUSCAR_PROFESOR_POR_NOMBRE(UPPER(V_NOMBRE_PROFESOR));
        VER_PROFESOR(V_NUM_PROF);
    END VISUALIZAR_DATOS_PROFESOR_POR_NOMBRE_PROFESOR;

------------

    PROCEDURE MOSTRAR_PROFESOR(ESPE IN PROFESORES.ESPPRO%TYPE)
    IS
        CURSOR C1 IS
            SELECT NOMPRO FROM PROFESORES WHERE ESPPRO LIKE '' || UPPER(ESPE) || '';
        REG C1%ROWTYPE;
        C NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('');
        OPEN C1;
        LOOP
            FETCH C1 INTO REG;
            EXIT WHEN C1%NOTFOUND;
            C := C + 1;
            DBMS_OUTPUT.PUT_LINE(REG.NOMPRO);
        END LOOP;
        IF(C = 0) THEN
            DBMS_OUTPUT.PUT_LINE('NO HAY NING�N PROFESOR CON ESA ESPECIALIDAD');
        END IF;
    END MOSTRAR_PROFESOR;
    
------------    

    FUNCTION VER_EDAD_PROFESOR(V_NUMPRO PROFESORES.NUMPRO%TYPE)
    RETURN NUMBER
    AS
        NACIMIENTO VARCHAR2(20);
        EDAD NUMBER;
    BEGIN
        SELECT FNAPRO INTO NACIMIENTO FROM PROFESORES WHERE NUMPRO = V_NUMPRO;
        EDAD := TRUNC(MONTHS_BETWEEN(SYSDATE, NACIMIENTO) / 12);
        RETURN EDAD;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO SE ENCONTR� EL PROFESOR CON EL N�MERO ' || V_NUMPRO);    
                RETURN NULL;
    END VER_EDAD_PROFESOR;

------------

    PROCEDURE BORRAR_PROFESOR(V_NUM_PROF PROFESORES.NUMPRO%TYPE)
    IS
        PROF_DIR PROFESORES.JEFPRO%TYPE;
        CONTADOR NUMBER := 0;
        JEFE EXCEPTION;
        NO_EXISTE_PROFESOR EXCEPTION;
    BEGIN
        SELECT COUNT(NUMPRO) INTO CONTADOR FROM PROFESORES WHERE NUMPRO = V_NUM_PROF;
        IF(CONTADOR = 0) THEN
            RAISE NO_EXISTE_PROFESOR;
        ELSE
            SELECT JEFPRO INTO PROF_DIR FROM PROFESORES WHERE NUMPRO = V_NUM_PROF;
            IF PROF_DIR IS NULL THEN
                RAISE JEFE;
            ELSE
                DELETE FROM PROFESORES WHERE NUMPRO = V_NUM_PROF;
                UPDATE PROFESORES SET JEFPRO = PROF_DIR WHERE JEFPRO = V_NUM_PROF;
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'PROFESOR DE C�DIGO ' || V_NUM_PROF || ' BORRADO CORRECTAMENTE');
            END IF;    
        END IF;
        EXCEPTION
            WHEN JEFE THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ERROR. NO SE PUEDE BORRAR AL JEFE');
            WHEN NO_EXISTE_PROFESOR THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'ERROR. NO EXISTE DICHO PROFESOR');
    END BORRAR_PROFESOR;

------------

    FUNCTION BUSCAR_PROFESOR_POR_NOMBRE(V_NOM_PROF PROFESORES.NOMPRO%TYPE)
    RETURN NUMBER
    IS
        COD PROFESORES.NUMPRO%TYPE;
    BEGIN
        SELECT NUMPRO INTO COD FROM PROFESORES WHERE NOMPRO = V_NOM_PROF;
        RETURN COD;
    END BUSCAR_PROFESOR_POR_NOMBRE;
    
------------
    
    PROCEDURE VER_PROFESOR(V_NUM_PROF PROFESORES.NUMPRO%TYPE)
    IS
        REG_PROFESOR PROFESORES%ROWTYPE;
    BEGIN
        SELECT * INTO REG_PROFESOR FROM PROFESORES WHERE NUMPRO = V_NUM_PROF;
        DBMS_OUTPUT.PUT_LINE(chr(10) || 'N�MERO: ' || REG_PROFESOR.NUMPRO);
        DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || REG_PROFESOR.NOMPRO);
        DBMS_OUTPUT.PUT_LINE('FECHA DE NACIMIENTO: ' || REG_PROFESOR.FNAPRO);
        DBMS_OUTPUT.PUT_LINE('C�DIGO JEFE: ' || REG_PROFESOR.JEFPRO);
        DBMS_OUTPUT.PUT_LINE('FECHA DE INGRESO: ' || REG_PROFESOR.FINPRO);
        DBMS_OUTPUT.PUT_LINE('SALARIO: ' || REG_PROFESOR.SALPRO);
        DBMS_OUTPUT.PUT_LINE('COMISI�N: ' || REG_PROFESOR.COMPRO);
        DBMS_OUTPUT.PUT_LINE('ESPECIALIDAD: ' || REG_PROFESOR.ESPPRO);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE(chr(10) || 'NO SE ENCONTR� EL PROFESOR');
    END VER_PROFESOR;
    
END GESTION_PROFESORES;