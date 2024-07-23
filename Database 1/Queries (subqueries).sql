/* Visualizar el título del libro, el nombre del profesor y el salario de cualquier profesor cuyo salario y comisión coincidan las dos con el salario y comisión de cualquier profesor de especialidad ‘Redes’ */
select C.TITCUR, P.NOMPRO, P.SALPRO from profesores P, cursos C where P.NUMPRO = C.NUMPRO and (P.SALPRO, NVL(P.COMPRO,0)) in (select SALPRO, NVL(COMPRO,0) from profesores where ESPPRO like 'REDES');

/* Crear una consulta para visualizar el nombre, la fecha de alta y el salario de todos los profesores que tengan el mismo salario más la comisión que Pilar Gómez excluyendo a esta */
select NOMPRO,FINPRO, SALPRO from profesores where SALPRO = (select SALPRO + NVL(COMPRO, 0) from profesores where NOMPRO like 'PILAR GÓMEZ') and NOMPRO != 'PILAR GÓMEZ';

/* Crear una consulta para visualizar a los profesores que ganan un salario superior al salario mínimo de especialidad Web. ordenar el resultado por salario descendentemente */
select NOMPRO, SALPRO from profesores where SALPRO > ANY (select SALPRO from profesores where ESPPRO like 'WEB') order by 2 desc;

/* Obtener el título de los cursos que tienen un precio igual al del curso 208 */
select TITCUR, PRECUR from cursos where PRECUR = (select PRECUR from cursos where NUMCUR = 208);

/* Obtener por orden el número del curso, el título y el número de créditos de todos aquellos cuyo precio del curso supere al doble del precio mínimo */
select NUMCUR, TITCUR, CRECUR from cursos where PRECUR > 2 * (select MIN(PRECUR) from cursos);

/* Visualizar la edad en años cumplidos del profesor más joven que es de la especialidad Software */
select NOMPRO, TRUNC(MONTHS_BETWEEN(SYSDATE, FNAPRO)/12) AÑOS from profesores where FNAPRO in (select MAX(FNAPRO) from profesores where ESPPRO like 'SOFTWARE');

/* Hallar el salario medio de los profesores cuyo salario no supera en más de un 90% al salario máximo de los profesores se especialidad Software */
select CONCAT(AVG(SALPRO), '€') "SALARIO MEDIO" from profesores where SALPRO < (select MAX(SALPRO)*0.9 from profesores where ESPPRO like 'SOFTWARE');

/* Hallar el salario medio por profesor agrupados por especialidades para aquellos cuyo salario máximo es inferior al salario medio de todos los profesores */
select ESPPRO, AVG(SALPRO) "SALARIO MEDIO" from profesores group by ESPPRO having MAX(SALPRO)< (select AVG(SALPRO) from profesores);

/* Para los profesores en los que la antigüedad media supera a la de la academia, hallar el salario mínimo, máximo y media de los profesores por especialidad */
select ESPPRO, MIN(SALPRO) "SALARIO MÍNIMO", MAX(SALPRO) "SALARIO MÁXIMO", TRUNC(AVG(SALPRO), 2) "SALARIO MEDIO" from profesores group by ESPPRO having AVG(MONTHS_BETWEEN(SYSDATE, FINPRO)/12) > ALL (select AVG(MONTHS_BETWEEN(SYSDATE,FinPRO)/12) from profesores);

/* Visualizar en media el valor de los cursos impartidos por los diferentes profesores */
select NUMPRO, TRUNC(AVG(PRECUR), 2) "MEDIA CRÉDITOS" from cursos where NUMPRO in (select NUMPRO from profesores) group by NUMPRO order by NUMPRO;

/* Obtener por orden alfabético los nombres de los profesores cuyo salario medio supera al de su propia especialidad */
select NOMPRO, SALPRO from profesores where SALPRO > ALL (select TRUNC(AVG(SALPRO), 2) from profesores P where ESPPRO = P.ESPPRO) order by 1;

/* Obtener por orden alfabético, los títulos de los cursos cuyo precio medio supera al del impartido por su profesor */
select TITCUR from cursos where PRECUR > ALL (select AVG(PRECUR) from cursos C where TITCUR = C.TITCUR group by NUMPRO) order by TITCUR;

/* Obtener mediante una subconsulta por orden alfabético el nombre del profesor si hay algún curso con un precio mayor de 250€ */
select NOMPRO from profesores where NUMPRO in (select NUMPRO from cursos where PRECUR > 250) order by NOMPRO;

/* Obtener mediante una subconsulta, que muestre el título del curso de aquellos cuyos créditos del curso supere a la media de los profesores que lo imparten */
select TITCUR from cursos where CRECUR > ALL (select AVG(CRECUR) from cursos group by NUMPRO);

/* Diseñar una subconsulta que muestre el nombre del profesor cuya comisión supere a la media de su especialidad. Si la comisión es nula se contabilizará como cero */
select NOMPRO, NVL(COMPRO, 0) COMISIÓN from profesores where NVL(COMPRO, 0) > (select AVG(NVL(COMPRO, 0)) from profesores P where ESPPRO = P.ESPPRO) order by "COMISIÓN" desc;

/* Para los profesores cuyo salario medio supera al de su especialidad, hallar cuántas especialidades tienen */
select ESPPRO, COUNT(ESPPRO) "Nº PROFESORES DE LA ESPECIALIDAD" from profesores where SALPRO > (select AVG(SALPRO) from profesores P where ESPPRO = P.ESPPRO) group by ESPPRO;

/* Visualizar el título del curso en los cuales hayan aprobado todos sus alumnos */
select C.TITCUR from cursos C where C.NUMCUR not in (select M.NUMCUR from matriculado M where M.CALIFIC < 5 and M.NUMCUR = C.NUMCUR);

/* Obtener por orden alfabético el nombre de los cursos que hayan tenido como media más de un 7 */
select TITCUR from cursos where NUMCUR in (select NUMCUR from matriculado group by NUMCUR having AVG(CALIFIC) > 7) order by 1;

/* Visualizar los alumnos que tengan una nota de 8 */
select NOMALU from alumnos where NUMALU in (select NUMALU from matriculado where CALIFIC = 8);

/* Hallar por orden alfabético, los nombres de los cursos que tienen alumnos con notas superiores a 8,5 */
select TITCUR from cursos where NUMCUR in (select NUMCUR from matriculado where CALIFIC > 8.5) order by 1;

/* Obtener el nombre y el email de los alumnos que han obtenido una nota comprendida entre 8,5 y 10 */
select NOMALU, EMAALU from alumnos where NUMALU in (select NUMALU from matriculado where CALIFIC between 8.5 and 10);

/* Obtener el nombre de los alumnos y su nota de que son del curso de número 202 */
select NOMALU, M.CALIFIC from matriculado M, alumnos A where M.NUMALU = A.NUMALU and (M.NUMALU, NUMCUR) in (select NUMALU, NUMCUR from matriculado where NUMCUR = 202);

/* Obtener por orden alfabético los alumnos que han realizado el curso AJAX */
select NUMALU, NOMALU from alumnos where NUMALU in (select NUMALU from matriculado M, cursos C where TITCUR = 'AJAX' and M.NUMCUR = C.NUMCUR) order by 2;

/* Obtener por orden alfabético el nombre de los cursos que ha realizado el alumno Antonio Gil */
select TITCUR from cursos where NUMCUR in (select NUMCUR from matriculado where NUMALU = (select NUMALU from alumnos where NOMALU like 'ANTONIO GIL')) order by TITCUR;

/* Diseñar una consulta en la se muestre el título del curso y el nombre del alumno que ha obtenido la nota máxima por cada curso */
select TITCUR, NOMALU, M.CALIFIC from cursos C, matriculado M, alumnos A where M.NUMCUR = C.NUMCUR and M.NUMALU = A.NUMALU and (CALIFIC, C.NUMCUR) in (select MAX(CALIFIC), NUMCUR from matriculado group by NUMCUR) order by M.CALIFIC desc;

/* Diseñar una consulta en la que se muestren el nombre de aquellos alumnos en la que la nota del curso es superior a la media de su curso */
select NOMALU from alumnos where NUMALU in (select NUMALU from matriculado where CALIFIC > (select AVG(CALIFIC) from matriculado M where NUMCUR = M.NUMCUR));

/* Realizar una consulta que obtenga la nota máxima de cada curso y el nombre del alumno que la haya obtenido */
select M.CALIFIC, C.TITCUR, A.NOMALU from matriculado M, alumnos A, cursos C where M.NUMALU = A.NUMALU and M.NUMCUR = C.NUMCUR and M.CALIFIC = (select MAX(M.CALIFIC) from matriculado M where M.NUMCUR = C.NUMCUR);

/* Crear una consulta para visualizar el nombre y la fecha de ingreso de cualquier empleado contratado después del profesor de código 106 */
select NOMPRO, FINPRO from profesores where FINPRO > (select FINPRO from profesores where NUMPRO = 106);
