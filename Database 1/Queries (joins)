/* Nombre, número de profesor y nombre de los cursos que imparte */
select NOMPRO, P.NUMPRO, TITCUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO;

/* Nombre del profesor, título del curso y precio de este, de todos los empleados que no tienen comisión */
select NOMPRO, TITCUR, PRECUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO and P.COMPRO is null;

/* Nombre del profesor y el título de los cursos que imparte de los profesores cuyo nombre empieza por 'M' */
select NOMPRO, TITCUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO and NOMPRO like 'M%';

/* Nombre y salario total (salario + comisión) de los profesores, así como el título de los cursos que imparten todos aquellos que tengan más de tres créditos */
select NOMPRO, (SALPRO + NVL(COMPRO, 0)) "SALARIO TOTAL", TITCUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO and CRECUR > 3;

/* Número de cursos y la suma de horas de los diferentes cursos para los profesores cuya especialidad sea Web */
select NOMPRO, COUNT(NUMCUR) "Nº CURSOS", SUM(HORCUR) "Nº HORAS" from profesores P, cursos C where P.NUMPRO = C.NUMPRO and ESPPRO = 'WEB' group by NOMPRO;

/* Número de profesor por cada número de créditos para los cursos cuyo crédito es superior cuatro */
select COUNT(NOMPRO)/CRECUR "PROPORCIÓN" from profesores P, cursos C where P.NUMPRO = C.NUMPRO and CRECUR > 4 group by CRECUR;

/* Nombre de los profesores que cuyo nombre empieza por 'E' y tienen algún curso de 40 horas */
select NOMPRO from profesores P, cursos C where P.NUMPRO = C.NUMPRO and NOMPRO like 'E%' and HORCUR = 40 group by NOMPRO order by NOMPRO;

/* Nombre de los profesores y de los cursos  con un precio superior a 500€ */
select NOMPRO, TITCUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO and PRECUR > 500 order by NOMPRO;

/* Número de profesor, nombre, salario y título del curso ordenados por número de profesor de forma decreciente de los cursos de la primera edición */
select P.NUMPRO, NOMPRO, SALPRO, TITCUR from profesores P, cursos C where P.NUMPRO = C.NUMPRO and EDICUR = 1 order by P.NUMPRO desc;
