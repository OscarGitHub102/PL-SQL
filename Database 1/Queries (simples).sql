/* TABLE PROFESORES */
/* Nombre y salario de los empleados cuya especialidad es Web */
select NOMPRO, SALPRO from profesores where ESPPRO = 'WEB';

/* Nombre y salario de los empleados que ganan mas de 1500€ */
select NOMPRO, SALPRO from profesores where SALPRO > 1500;

/* Nombre de los profesores nacidos en el año 1992 */
select NOMPRO from profesores where FNAPRO like '%92';

/* Nombres de los profesores que ganan más de 1500€ y cuyo oficio es Redes y Software */
select NOMPRO from profesores where (SALPRO > 1500) AND (ESPPRO LIKE 'REDES' OR ESPPRO LIKE 'SOFTWARE');

/* Nombre de los profesores que tienen una "u" en la segunda letra de su nombre */
select NOMPRO from profesores where NOMPRO like '_U%';

/* Nombre de los profesores cuyo apellido acabe en "o" */
select NOMPRO from profesores where NOMPRO like '%O';

/* TABLE CURSOS */
/* Títulos de los cursos que tengan dos o más ediciones y que el número de créditos sea mayor de tres */
select TITCUR from cursos where EDICUR >= 2 AND CRECUR > 3;

/* Titulos de los cursos cuyo tiempo de desarrollo no exceda de más de 120 días */
select TITCUR from cursos where (FFICUR - FINCUR) < 120;

/* Título del curso, el literal "comienza" y la fecha de inicio del curso con el formato "lunes 6 de junio, 2016" */
select TITCUR, LOWER(TO_CHAR(FINCUR,'"COMIENZA EL "DAY D "DE" MONTH", "YYYY')) "FECHAS PREVISTAS DE INICIO" from cursos;

/* TABLE ALUMNOS */
/* Nombres de los alumnos cuyo tercer dígito de su número de teléfono es 2 por orden alfabético */
select NOMALU from alumnos where TELALU like '__2%' order by NOMALU;

/* Las cuatro primeras letras del nombre de aquellos alumnos que sean de Leganés */
select SUBSTR(UPPER(NOMALU), 1, 4) from alumnos where DIRALU like '%LEGANÉS';