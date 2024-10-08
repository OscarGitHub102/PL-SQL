/****************************** TABLE PROFESORES ******************************/

/* Nombre y salario de los empleados cuya especialidad es Web */
select NOMPRO, SALPRO from profesores where ESPPRO = 'WEB';

/* Nombre y salario de los empleados que ganan mas de 1500€ */
select NOMPRO, SALPRO from profesores where SALPRO > 1500;

/* Nombre de los profesores nacidos en el año 1992 */
select NOMPRO from profesores where FNAPRO like '%92';

/* Nombre de los profesores que ganan más de 1500€ y cuyo oficio es Redes y Software */
select NOMPRO from profesores where (SALPRO > 1500) and (ESPPRO LIKE 'REDES' or ESPPRO LIKE 'SOFTWARE');

/* Nombre de los profesores que tienen una "u" en la segunda letra de su nombre */
select NOMPRO from profesores where NOMPRO like '_U%';

/* Nombre de los profesores cuyo apellido acabe en "o" */
select NOMPRO from profesores where NOMPRO like '%O';

/* Antigüedad máxima en años completos de los profesores por especialidad */
select TRUNC(MAX(SYSDATE - FINPRO)/365) ANTIGÜEDAD, ESPPRO from profesores group by ESPPRO order by ANTIGÜEDAD;

/* Salario medio por especialidad, exluyendo aquellos cuya media sea menor a 1800€ */
select ESPPRO, TRUNC(AVG(SALPRO), 2) as "SALARIO MEDIO" from profesores group by ESPPRO having AVG(SALPRO) < 1800 order by "SALARIO MEDIO";

/* Nombre y salario de los profesores con el icono del dolar al final */
select NOMPRO, RPAD(SALPRO, 5, '$') SALARIO from profesores order by NOMPRO;

/* Nombre de los profesores cuya comisión es igual o superior al 10% de su salario, en orden decreciente */
select NOMPRO, SALPRO, COMPRO from profesores where COMPRO >= SALPRO*0.1 order by NOMPRO desc;

/* Nombre de los profesores y el número de trienios que lleva en la empresa */
select NOMPRO, TRUNC(((SYSDATE - FINPRO)/365)/3) TRIENIOS from profesores order by NOMPRO;

/* Nombre de los profesores y la suma del salario más comisión. Si la comisión es nula se convertirá a cero */
select NOMPRO, SALPRO + NVL(COMPRO, 0) "SALARIO + COMISIÓN" from profesores order by NOMPRO;

/* Nombre y edad con la que empezaron a trabajar (sin decimales) */
select NOMPRO, TRUNC((FINPRO - FNAPRO)/365) as "EDAD INGRESO" from profesores order by "EDAD INGRESO";

/* Nombre de los profesores que hayan ingresado después de 28/02/17 */
select SUBSTR(NOMPRO, 1, INSTR(NOMPRO, ' ')) NOMBRE from profesores where FINPRO > '28/02/17' order by NOMPRO;

/* Apellido de los profesores que hayan ingresado después de 28/02/17 */
select SUBSTR(NOMPRO, INSTR(NOMPRO, ' ') + 1) APELLIDO from profesores where FINPRO > '28/02/17' order by NOMPRO;

/* Nombre, especialidad y salario de los profesores cuya especilidad sea REDES y SOFTWARE y su salario no sea igual a 1450 o 1700 € */
select NOMPRO, ESPPRO, SALPRO from profesores where (ESPPRO = 'REDES' or ESPPRO = 'SOFTWARE') and SALPRO not in (1450, 1700);

/* Nombre de los profesores cuyo apellido empieza por "G" */
select NOMPRO from profesores where NOMPRO like '% G%' order by NOMPRO desc;

/* Salario medio por especialidad */
select ESPPRO, TRUNC(AVG(SALPRO), 2) as "SALARIO MEDIO" from profesores group by ESPPRO order by "SALARIO MEDIO";

/* Incrementar a los profesores que son de SOFTWARE un 10% y al resto un 5% de su salario */
select NOMPRO, DECODE(ESPPRO, 'SOFTWARE', SALPRO*1.1, SALPRO*1.05) as "SALARIO INCREMENTADO" from profesores order by "SALARIO INCREMENTADO" desc;

/* Salario medio y número de profesores que hay en la empresa */
select AVG(SALPRO) "SALARIO MEDIO", COUNT(*) "   Nº PROFESORES" from profesores;

/* Nombre, fecha de ingreso y fecha de revisión del salario, la cual es el primer lunes después de nueve meses de trabajo, con el formato "lunes 6 de junio, 2016" */
select NOMPRO, FINPRO, TO_CHAR(NEXT_DAY(ADD_MONTHS(FINPRO, 9), 'LUNES'), 'DAY DD "de" MONTH "," YYYY') "REVISIÓN SALARIAL" from profesores order by NOMPRO;

/* Primera letra en mayúscula y el resto en minúsculas del nombre de los profesores y la longitud de sus nombres, para los profesores cuyos nombres empiecen por E, A o I */
select INITCAP(NOMPRO) NOMBRE, LENGTH(NOMPRO) "LONGITUD NOMBRE" from profesores where NOMPRO like 'E%' or NOMPRO like 'A%' or NOMPRO like 'I%' order by NOMPRO;

/* Nombre y tiempo (ordenado por antigüedad de mayor a menor) que llevan los profesores en la empresa expresado en años, meses y días */
select NOMPRO, TRUNC((SYSDATE-FINPRO) /365) as "AÑOS", TRUNC((((SYSDATE-FINPRO) /365)-TRUNC((SYSDATE-FINPRO) /365))*12) as "MESES", TRUNC(((((SYSDATE-FINPRO)/365)-TRUNC((SYSDATE-FINPRO)/365)))*30) as "DÍAS" from profesores order by "AÑOS" desc, "MESES" desc, "DÍAS" desc; 

/* Nombre y salarios en dólares de aquellos profesores cuyo apellido termina en "z" */
select NOMPRO, CONCAT((SALPRO*1.15), '$') AS "SALARIO" from profesores where NOMPRO like '%Z' order by "SALARIO" desc;

/* Nombre y fecha de nacimiento de los profesores que son de Software y ganan más de 1650€ */
select NOMPRO, FNAPRO from profesores where ESPPRO = 'SOFTWARE' and SALPRO > 1650 order by NOMPRO;

/* Nombre, fecha de nacimiento y salario anual más comisión de los profesores nacidos en 1991 */
select NOMPRO, FNAPRO, CONCAT((SALPRO + NVL(COMPRO, 0)) * 12, '€') "SALARIO ANUAL (CON COMISIÓN)" from profesores where EXTRACT(YEAR from FNAPRO) = 1991 order by NOMPRO;

/* Número de profesores con el mismo salario, descartando los que ganan menos de 1500€ */
select SALPRO, COUNT(SALPRO) "Nº PROFESORES" from profesores where SALPRO >= 1500 group by SALPRO order by SALPRO;

/* Número y salario de los profesores con menor salario que dependen de cada jefe. Excluyendo a aquellos cuyo jefe no se identifique y cuyo mínimo salario sea inferior a 1700€ */
select JEFPRO, MIN(SALPRO) "SALARIO MÍNIMO" from profesores where JEFPRO is not null group by JEFPRO having MIN(SALPRO) < 1700 order by JEFPRO;

/* Edad máxima en años cumplidos de cada especialidad */
select ESPPRO, MAX(TRUNC((SYSDATE - FNAPRO)/365)) as "EDAD MÁXIMA" from profesores group by ESPPRO order by "EDAD MÁXIMA";

/* Número de profesores que empezaron a trabajar en los diferentes años */
select EXTRACT(YEAR from FINPRO) AÑO, COUNT(FINPRO) "Nº INGRESOS" from profesores group by EXTRACT(YEAR from FINPRO) order by EXTRACT(YEAR from FINPRO);

/****************************** TABLE CURSOS ******************************/

/* Título de los cursos que tengan dos o más ediciones y que el número de créditos sea mayor de tres */
select TITCUR from cursos where EDICUR >= 2 AND CRECUR > 3;

/* Titulo de los cursos cuyo tiempo de desarrollo no exceda de más de 120 días */
select TITCUR from cursos where (FFICUR - FINCUR) < 120;

/* Título del curso, el literal "comienza" y la fecha de inicio del curso con el formato "lunes 6 de junio, 2016" */
select TITCUR, LOWER(TO_CHAR(FINCUR,'"COMIENZA EL "DAY DD "DE" MONTH", "YYYY')) "FECHAS PREVISTAS DE INICIO" from cursos;

/* Cursos que tengan un título con menos de cinco caracteres */
select TITCUR, LENGTH(TITCUR) LONGITUD from cursos where LENGTH(TITCUR) < 5;

/* Total de créditos de cada profesor, excluyendo aquellos cuyo total de créditos sea igual o menor a 4 */
select NUMPRO, SUM(CRECUR) CRÉDITOS from cursos group by NUMPRO having SUM(CRECUR) > 4 order by NUMPRO;

/* Valor total de los cursos por el número de créditos de aquellos cuya edición es la primera */
select SUM(PRECUR)*SUM(CRECUR) VALOR from cursos where EDICUR = 1;

/* Título del curso y la fecha correspondiente a lunes después de la fecha de inicio de los cursos */
select TITCUR, FINCUR, NEXT_DAY(FINCUR, 'LUNES') as "LUNES" from cursos order by "LUNES";

/* Posponer 1 mes la fecha de finalización de las aulas con cursos de Web */
select FFICUR, ADD_MONTHS(FFICUR, 1) MES from cursos where NUMPRO in (101, 105, 109, 110);

/* Número de cursos que imparte cada profesor */
select NUMPRO, COUNT(NUMCUR) "Nº CURSOS" from cursos group by NUMPRO order by NUMPRO;

/* Número de cursos que empiezan en los diferentes años */
select EXTRACT(YEAR from FINCUR) as "AÑO", COUNT(EXTRACT(YEAR from FINCUR)) "Nº CURSOS" from cursos group by EXTRACT(YEAR from FINCUR) order by "AÑO";
select TO_CHAR(FINCUR, 'YYYY') as "AÑO", COUNT(TO_CHAR(FINCUR, 'YYYY')) "Nº CURSOS" from cursos group by TO_CHAR(FINCUR, 'YYYY') order by 1;

/* Media de los precios de los cursos por edición, excluyendo aquellos cuya media sea superior a 800€ */
select EDICUR, TRUNC(AVG(PRECUR), 2) "MEDIA PRECIO" from cursos group by EDICUR having AVG(PRECUR) < 800;

/****************************** TABLE ALUMNOS ******************************/

/* Nombre de los alumnos cuyo tercer dígito de su número de teléfono es 2 por orden alfabético */
select NOMALU from alumnos where TELALU like '__2%' order by NOMALU;

/* Las cuatro primeras letras del nombre de aquellos alumnos que sean de Leganés */
select SUBSTR(UPPER(NOMALU), 1, 4) "INIT" from alumnos where DIRALU like '%LEGANÉS';

/* Códigos postales sin los dos primeros caracteres */
select SUBSTR(CPOALU, 3, 5) CP from alumnos group by SUBSTR(CPOALU, 3, 5) order by 1;

/* Número de alumnos en los diferentes códigos postales */
select CPOALU, COUNT(NOMALU) as "Nº ALUMNOS" from alumnos group by CPOALU order by "Nº ALUMNOS";

/* Número de alumnos en los diferentes dominios de su cuenta de correo electrónico */
select SUBSTR(EMAALU, INSTR(EMAALU, '@') +1) DOMINIO, COUNT(NUMALU) "Nº ALUMNOS" from alumnos group by SUBSTR(EMAALU, INSTR(EMAALU, '@') +1);

/* Nombre y correo electrónico sin el dominio */
select NOMALU, SUBSTR(EMAALU, 1, INSTR(EMAALU, '@') -1) "CORREO (SIN DOMINIO)" from alumnos;

/* Apellido de los alumnnos de Getafe */
select SUBSTR(NOMALU, INSTR(NOMALU, ' ')) APELLIDO from alumnos where DIRALU like '% GETAFE' order by APELLIDO;

/* Nombre y apellidos, y ciudad de los que tienen un correo de hotmail.com */
select NOMALU, DIRALU, EMAALU from alumnos where EMAALU like '%@HOTMAIL.COM' order by NOMALU;
