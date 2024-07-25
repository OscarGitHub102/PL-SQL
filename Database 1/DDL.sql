/* Crear la tabla CURSOS3 que incluya los cursos de un crédito cargándola con estos */
CREATE TABLE CURSOS3 AS SELECT * FROM CURSOS WHERE EDICUR = 1;

/* En CURSOS3, crear un nuevo campo llamado DESCRIPCION de tipo VARCHAR2 con una longitud de 30 caracteres */
ALTER TABLE CURSOS3 ADD (DESCRIPCION VARCHAR2(30));

/* Modificar el campo DESCRIPCION para que pase a tener una longitud de 60 caracteres */
ALTER TABLE CURSOS3 MODIFY (DESCRIPCION VARCHAR2(60));

/* Renombrar la columna DESCRIPCION por DESCCUR*/
ALTER TABLE CURSOS3 RENAME COLUMN DESCRIPCION TO DESCCUR;

/* Renombrar la tabla CURSOS3 a CURSOS4 */
RENAME TABLE TO CURSOS4;

/* Eliminar la tabla CURSOS4 */
DROP TABLE CURSOS4;

/* Crear una tabla llamada PRUEBA que contenga la especialidad del profesor de dimensión VARCHAR2(25) y el salario medio por especialidad de dimensión NUMBER(7, 2) */
CREATE TABLE PRUEBA(ESPPRO VARCHAR(25), SALMED NUMBER(7, 2));

/* Escribir una restricción Primary Key al campo especialida del profesor de la tabla PRUEBA */
ALTER TABLE PRUEBA ADD PRIMARY KEY (ESPPRO);

/* Cargar en la tabla PRUEBA los registros basándose en PROFESORES */
INSERT INTO PRUEBA(ESPPRO, SALMED) SELECT ESPPRO, AVG(SALPRO) AS "SALARIO MEDIO" FROM PROFESORES GROUP BY ESPPRO ORDER BY "SALARIO MEDIO";

/* Eliminar la tabla PRUEBA */
DROP TABLE PRUEBA;

/* Crear la tabla PROFESORES2 basándose en la tabla PROFESORES */
CREATE TABLE PROFESORES2 AS (SELECT * FROM PROFESORES);

/* Cargar PROFESORES2 disminuyendo un 5% el salario de los profesores que superan el 75% del salario máximo */
UPDATE PROFESORES2 SET SALPRO = SALPRO + (SALPRO*0.05) WHERE SALPRO > (SELECT MAX(SALPRO)*0.75 FROM PROFESORES2);

/* Eliminar la tabla PROFESORES2 */
DROP TABLE PROFESORES2;

/* Crear una tabla PROFESORES3 basada en PROFESORES, vaciarla y validarla. Añadir una PK al campo NUMPRO llamada PROFESORES3_NUMPRO_PK, otra de tipo CHECK al campo SALPRO llamada PROFESORES3_SALPRO_CK que permita salarios comprendidos entre 1000 y 6000 €, y una NOT NULL al campo NOMPRO. Finalmente, eliminar la tabla PROFESORES3 */
CREATE TABLE PROFESORES3 AS SELECT * FROM PROFESORES;
                 
DELETE FROM PROFESORES3;
COMMIT;
                 
ALTER TABLE PROFESORES3 ADD
(CONSTRAINT PROFESORES3_NUMPRO_PK PRIMARY KEY (NUMPRO)
(CONSTRAINT PROFESORES3_SALPRO_CK CHECK(SALPRO BETWEEN 1000 AND 6000));
                 
ALTER TABLE PROFESORES3 MODIFY(NOMPRO NOT NULL);

DROP TABLE PROFESORES3;
