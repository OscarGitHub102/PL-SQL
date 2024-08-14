/* Dar de alta a un nuevo profesor con los siguientes datos (111, Ángel Peña, 14/07/93, 106, SYSDATE, 1200, NULL, Redes) */
INSERT INTO PROFESORES VALUES (111, 'ÁNGEL PEÑA', '14/07/93', 106, SYSDATE, 1200, NULL, 'REDES');

/* Insertar un alumno con los siguientes datos: (327, Alberto López, Riego, 28 Parla, 28981, 633333221, a.lopez@hotmail.com) */
INSERT INTO ALUMNOS VALUES (327, 'ALBERTO LÓPEZ', 'RIEGO, 28 PARLA', 28981, 633333221, 'A.LOPEZ@HOTMAIL.COM');

/* Insertar en la tabla MATRICULADO los siguientes datos: (20, 326, 5.5) */
INSERT INTO MATRICULADO VALUES(20, 326, 5.5);

/* Cambiar la fecha de nacimiento de Ángel Peña al 07/04/94 */
UPDATE PROFESORES SET FNAPRO = '07/04/94' WHERE NUMPRO =
  (SELECT NUMPRO FROM PROFESORES WHERE NOMPRO LIKE 'ÁNGEL PEÑA');

/* Modificar el salario y la comisión de Ángel Peña a 1300 de salario y de comisión 50 */
UPDATE PROFESORES SET SALPRO = 1300, COMPRO = 50 WHERE NOMPRO LIKE '%ÁNGEL PEÑA%';

/* Incrementar el salario un 2,5% a todos los profesores que sean de especialidad Web */
UPDATE PROFESORES SET SALPRO = SALPRO * 1.025 WHERE ESPPRO LIKE 'WEB'

/* Borrar de la tabla a PROFESORES a Ángel Peña */
DELETE FROM PROFESORES WHERE NOMPRO LIKE 'ÁNGEL PEÑA';

/* Borrar de la tabla PROFESORES a Ángel Peña, de la tabla ALUMNOS al alumno de número 326, y de la tabla MATRICULADO el registro (201, 326, 5.5) */
DELETE FROM PROFESORES WHERE NOMPRO LIKE 'ÁNGEL PEÑA';
DELETE FROM ALUMNOS WHERE NUMALU = 326;
DELETE FROM MATRICULADO WHERE NUMCUR = 201 AND NUMALU = 326 AND CALIFIC = 5.5;

/* Crear una tabla vacía llamada CURSOS2 con la misma estructura que la tabla CURSOS. Llenar la tabla con aquellos cursos que empezaron después de 31/12/2019 */
CREATE TABLE CURSOS2 AS SELECT * FROM CURSOS;   -- Copiar estructura
DELETE FROM CURSOS2;    -- Borrar datos
COMMIT;     -- Finalizar transacción
INSERT INTO CURSOS2
  (SELECT * FROM CURSOS WHERE FINCUR > '31/12/2019');

/* Borrar de la tabla CURSOS2 el curso cuyo nombre es AJAX */
DELETE FROM CURSOS2 WHERE TITCUR LIKE '%AJAX%';

/* Borrar de la tabla CURSOS2 aquellos cuyo precio supera el precio medio de cursos de su profesor */
DELETE FROM CURSOS2 C2 WHERE PRECUR >
  (SELECT AVG(PRECUR) FROM CURSOS WHERE NUMPRO = C2.NUMPRO);

/* Borrar todos los datos de la tabla CURSOS2 */
DELETE FROM CURSOS2;

/* Crear una tabla vacía llamada PROFFESORES2 con la misma estructura que PROFESORES. Insertar en la tabla PROFESORES2 una fila por cada profesor cuyo salario total (salario más comisión) supere al salario total medio de su especialidad */
CREATE TABLE PROFESORES2 AS SELECT * FROM PROFESORES;
DELETE FROM PROFESORES2;
COMMIT;
INSERT INTO PROFESORES2
  (SELECT * FROM PROFESORES WHERE SALPRO + NVL(COMPRO, 0) > (SELECT AVG(SALPRO + NVL(COMPRO, 0)) FROM PROFESORES WHERE ESPPRO = PROFESORES.ESPPRO));

/* Sumar en PROFESORES2 la comisión al salario y actualizar este con el nuevo valor, poniendo además nulo en la comisión */
UPDATE PROFESORES2 SET SALPRO = (SALPRO + NVL(COMPRO, 0));
UPDATE PROFESORES2 SET COMPRO = NULL;

/* Disminuir en la tabla PROFESORES2 un 5% el salario a los empleados que superan el 50% del salario máximo de su especialidad */
UPDATE PROFESORES2 SET SALPRO = SALPRO - SALPRO * 0.05 WHERE SALPRO >
  (SELECT MAX(SALPRO*0.05) FROM PROFESORES WHERE ESPPRO = PROFESORES.ESPPRO);

/* Borrar en PROFESORES2 a los profesores cuyo salario (sin incluir comisión) supere al salario medio de los profesores de su especialidad */
DELETE FROM PROFESORES2 WHERE SALPRO >
  (SELECT MAX(AVG(SALPRO)) FROM PROFESORES2 GROUP BY ESPPRO);
