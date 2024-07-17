/*EJERCICIO 1a*/
CREATE TABLE PRUEBA1(ESPPRO VARCHAR(25), SALMED NUMBER(7,2));
/*EJERCICIO 1b*/
ALTER TABLE PRUEBA1 ADD PRIMARY KEY (ESPPRO);
/*EJERCICIO 1c*/
INSERT INTO PRUEBA1(ESPPRO, SALMED) select ESPPRO, AVG(SALPRO) from profesores group by ESPPRO;
/*EJERCICIO 1d*/
CREATE TABLE PROFESORES4 as (select * from profesores);
/*EJERCICIO 1e*/
UPDATE profesores4 SET SALPRO = SALPRO + (SALPRO*0.05) where SALPRO > (select MAX(SALPRO)*0.75 from profesores4);
/*EJERCICIO 1f*/
DROP TABLE PRUEBA1;

/*EJERCICIO 2*/
CREATE TABLE PROFESORES5 as select * from profesores
                 
DELETE from profesores5
COMMIT;
                 
ALTER TABLE profesores5 ADD
(CONSTRAINT profesores5_NUMPRO_PK PRIMARY KEY (NUMPRO)
(CONSTRAINT profesores_SALPRO_CK CHECK(SALPRO BETWEEN 1000 AND 6000));
                 
ALTER TABLE profesores5 MODIFY(NOMPRO NOT NULL);

/*EJERCICIO 3*/


--APUNTES--
/*
registros           tabla (commit autom?tica)
INSERT              CREATE
DELETE              DROP
UPDATE              ALTER
a?adir COMMIT;

INSERT INTO PRUEBA1 VALUES ('PEPE', '22154,25');
select * from prueba1
*/