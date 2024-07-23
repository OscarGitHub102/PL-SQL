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

/* Nombre, precio y la media de las notas de su curso, excluyendo aquellos cursos cuyas notas estén suspensas */
select TITCUR, PRECUR, ROUND(AVG(CALIFIC), 2) "NOTA MEDIA" from cursos C, matriculado M where C.NUMCUR = M.NUMCUR AND CALIFIC > 5 group by TITCUR, PRECUR order by "NOTA MEDIA" desc;

/* Número de alumnos matriculados en Android con más de un 4 de nota */
select COUNT(NUMALU) "Nº ALUMNOS" from matriculado M, cursos C where M.NUMCUR = C.NUMCUR AND TITCUR = 'ANDROID' AND CALIFIC > 4;

/* Nombre y nota de los alumnos matriculados en el curso 201 y con el profesor 101 */
select NOMALU, CALIFIC from alumnos A, matriculado M, profesores P, cursos C where A.NUMALU = M.NUMALU AND M.NUMCUR = C.NUMCUR AND P.NUMPRO = 101 AND C.NUMCUR = 201 order by NOMALU;

/* Nombre de los alumnos que hayan suspendido el curso Programación en Python en la primera edición */
select NOMALU, CALIFIC from alumnos A, matriculado M, cursos C where A.NUMALU = M.NUMALU AND M.NUMCUR = C.NUMCUR AND C.TITCUR like'%PYTHON%' AND C.EDICUR = 1 AND M.CALIFIC <= 5;

/* Nombre del curso y media aritmética obtenida en los diferentes cursos, excluyendo aquellos cuya media sea suspensa */
select TITCUR, TRUNC(AVG(CALIFIC), 2) "MEDIA ARITMÉTICA" from cursos C, matriculado M where C.NUMCUR = M.NUMCUR group by TITCUR having AVG(CALIFIC) >= 5 order by "MEDIA ARITMÉTICA" desc;

/*Créditos y nota mínima de cada tipo, excluyendo aquellos cuya nota mínima sea aprobada */
select CRECUR, MIN(CALIFIC) "NOTA MÍNIMA" from cursos C, matriculado M where C.NUMCUR = M.NUMCUR group by CRECUR having MIN(CALIFIC) <= 5 order by "NOTA MÍNIMA";

/* Nombre y número del profesor junto con el nombre de sus jefes y número de jefe */
select P.NOMPRO PROFESOR, P.NUMPRO "CÓDIGO PROFESOR", J.NOMPRO "NOMBRE JEFE", J.NUMPRO "NÚMERO JEFE" from profesores P, profesores J where J.NUMPRO = P.JEFPRO; 

/* Nombre y fecha de ingreso de cualquier empleado contratado después del profesor de código 106 */
select P.NOMPRO, P.FINPRO, P.NUMPRO, F.NUMPRO, F.FINPRO from profesores P, profesores F where F.NUMPRO = 106 AND P.FINPRO > F.FINPRO;

/* Nombre y fecha de contratación junto con los nombres de jefes y fecha de contratación de los profesores que fueron contratados antes que sus jefes */
select P.NOMPRO, P.FINPRO, D.JEFPRO, D.FINPRO from profesores P, profesores D where P.JEFPRO = D.NUMPRO and P.FINPRO < D.FINPRO;

/* Nombre del curso y número de alumnos matriculados en él */
select TITCUR, COUNT(NOMALU) "Nº ALUMNOS" from cursos C, matriculado M, alumnos A where C.NUMCUR = M.NUMCUR AND M.NUMALU = A.NUMALU group by TITCUR order by "Nº ALUMNOS" desc;

/* Nota mínima de cada curso */
select TITCUR, MIN(CALIFIC) "NOTA MÍNIMA" from cursos C, matriculado M where C.NUMCUR = M.NUMCUR group by TITCUR order by "NOTA MÍNIMA" desc;

/* Nota máxima por créditos, excluyendo aquellos cuya nota máxima sea mayor o igual a cinco */
select CRECUR, MAX(CALIFIC) "NOTA MÁXIMA" from cursos C, matriculado M where C.NUMCUR = M.NUMCUR group by CRECUR, C.NUMCUR having MAX(CALIFIC) <= 5 order by CRECUR;

/* Número de alumnos matriculados en el curso 201 y la media aritmética de las notas de este */
select COUNT(NOMALU) "Nº ALUMNOS", AVG(CALIFIC) "MEDIA ARITMÉTICA" from alumnos A, matriculado M where A.NUMALU = M.NUMALU and NUMCUR = 201;
