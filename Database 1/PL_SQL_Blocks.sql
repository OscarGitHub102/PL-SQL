/* Calcular la suma de los salarios de la tabla PROFESORES */
SET SERVEROUTPUT ON
DECLARE
    V_TOTAL NUMBER;
BEGIN
    SELECT SUM(SALPRO) INTO V_TOTAL FROM PROFESORES;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'SUMA DE SALARIOS: ' || V_TOTAL || '€');
END;

/* Visualizar el nombre del profesor y su salario de la tabla PROFESORES de número de profesor 106 */
SET SERVEROUTPUT ON
DECLARE
    V_NOMPRO VARCHAR2(15);
    V_SALPRO NUMBER(8, 2);
BEGIN
    SELECT NOMPRO, SALPRO INTO V_NOMPRO, V_SALPRO FROM PROFESORES WHERE NUMPRO = 106;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'NOMBRE: ' || V_NOMPRO);
    DBMS_OUTPUT.PUT_LINE('SALARIO: ' || V_SALPRO || '€');
END;

/* Bloque PL que obtenga el nombre y el salario del profesor de código 109 */
SET SERVEROUTPUT ON
DECLARE
    NOMBRE PROFESORES.NOMPRO%TYPE;
    SALARIO PROFESORES.SALPRO%TYPE;
BEGIN
    SELECT SALPRO, NOMPRO INTO SALARIO, NOMBRE FROM PROFESORES WHERE NUMPRO = 109;
    DBMS_OUTPUT.PUT_LINE(chr(10) || NOMBRE || ' **** ' || SALARIO || '€');
END;

/* Insertar en la tabla PROFESORES un nuevo profesor de código 111 a través de un bloque PL con los siguientes datos ('Olvido Pino', '14/07/97', 105, '31/08/16', 1100, NULL, 'Web') */
SET SERVEROUTPUT ON
DECLARE
    CODEMPLEADO PROFESORES.NUMPRO%TYPE := 111;
BEGIN
    INSERT INTO PROFESORES VALUES (CODEMPLEADO, 'OLVIDO PINO', '14/07/97', 105, '31/08/16', 1100, NULL, 'WEB');
END;

/* Suprimir el profesor de código 111 */
SET SERVEROUTPUT ON
DECLARE
    V_NUMPRO PROFESORES.NUMPRO%TYPE := 111;
BEGIN
    DELETE FROM PROFESORES WHERE NUMPRO = V_NUMPRO;
END;

/* Borrar de la tabla CURSOS aquellos que sean más de 50 horas, utilizando el cursor ROWCOUNT */
SET SERVEROUTPUT ON
DECLARE
    V_ELIMI CURSOS.HORCUR%TYPE := 60;
BEGIN
    DELETE FROM CURSOS WHERE HORCUR > V_ELIMI;
    DBMS_OUTPUT.PUT_LINE(chr(10) || SQL%ROWCOUNT || ' FILAS ELIMINADAS');
END;

/* Incrementar un 10% a los profesores que son de la especialidad Hardware, asignando a dicho valor una variable declarada */
SET SERVEROUTPUT ON
DECLARE
    AUMENTO NUMBER := 0.1;
BEGIN
    UPDATE PROFFESORES SET SALPRO = SALPRO + SALPRO * AUMENTO WHERE ESPPRO LIKE '%HARDWARE%';
END;

/* Bloque PL sobre la tabla PROFESORES que, introduciendo el número del profesor, muestre el nombre y el salario de este, para posteriormente ser actualizado y mostrado, teniendo en cuenta que, si el sueldo es mayor de 1500€, se incrementará en un 15% y, si es menor, en un 25% */
SET SERVEROUTPUT ON
DECLARE
    N PROFESORES.NUMPRO%TYPE;
    NOMBRE PROFESORES.NOMPRO%TYPE;
    SALARIO PROFESORES.SALPRO%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INTRODUZCA EL NÚMERO DEL PROFESOR');
    N:=&NUMERO;
    SELECT NOMPRO, SALPRO INTO NOMBRE, SALARIO FROM PROFESORES WHERE NUMPRO = N;
    DBMS_OUTPUT.PUT_LINE(NOMBRE || ' ' || SALARIO);
    IF(SALARIO > 1500) THEN
        UPDATE PROFESORES SET SALPRO = SALARIO*1.15;
    ELSE
        UPDATE PROFESORES SET SALPRO = SALARIO*1.25;
    END IF;
    SELECT SALPRO INTO SALARIO FROM PROFESORES WHERE NUMPRO = N;
    DBMS_OUTPUT.PUT_LINE(NOMBRE || ' NUEVO SALARIO ' || SALARIO);
END;
