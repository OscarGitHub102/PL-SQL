INSERT INTO PROFESORES VALUES
(101, 'JUAN PÉREZ', '14/12/1990', NULL, '31/08/2015',1950, NULL, 'WEB');
INSERT INTO PROFESORES VALUES
(102, 'ELENA ÁLVAREZ', '22/10/1993', 101,'31/08/2018', 1450, 300, 'REDES');
INSERT INTO PROFESORES VALUES
(103, 'ALEJANDRO CASTILLO', '20/03/1989', 101,'31/10/2015', 1950, 150, 'HARDWARE');
INSERT INTO PROFESORES VALUES
(105, 'MARTA SÁNCHEZ', '01/01/1990', 101,'30/09/2016', 1700, NULL, 'WEB');
INSERT INTO PROFESORES VALUES
(106, 'PILAR GÓMEZ', '03/03/1992', 102, '30/11/2017',1650, NULL, 'REDES');
INSERT INTO PROFESORES VALUES
(107, 'ISMAEL GARCÍA', '01/12/1992', 101,'31/08/2016', 1700, NULL, 'SOFTWARE');
INSERT INTO PROFESORES VALUES
(104, 'MIGUEL ENCINAS', '14/02/1991', 107,'28/02/2017', 1650, 300, 'SOFTWARE');
INSERT INTO PROFESORES VALUES
(108, 'EVA GALERA', '20/07/1991', 107, '30/04/2017',1650, 150, 'SOFTWARE');
INSERT INTO PROFESORES VALUES
(109, 'RUFINO DELGADO', '14/07/1991', 105,'31/08/2016', 1800, 150, 'WEB');
INSERT INTO PROFESORES VALUES
(110, 'ANTONIO DELGADO', '14/08/1991', 101,'01/08/2018', 1500, NULL, 'WEB');

INSERT INTO CURSOS VALUES
(201, 'INTRODUCCIÓN A XML', 600, 1, 30, '01/09/2017','01/09/2017', 3, 101);
INSERT INTO CURSOS VALUES
(202, 'PROGRAMACIÓN EN JAVA', 550, 1, 60,'01/10/2017', '15/12/2017', 6, 104);
INSERT INTO CURSOS VALUES
(203, 'HTML 5 Y CSS', 400, 1, 40, '15/04/2019','30/06/2019', 4, 105);
INSERT INTO CURSOS VALUES
(204, 'PROCESADORES', 300, 1, 30, '01/05/2019','01/09/2019', 3, 103);
INSERT INTO CURSOS VALUES
(205, 'REDES LOCALES I', 425, 1, 40, '01/12/2019','28/02/2020', 4, 102);
INSERT INTO CURSOS VALUES
(206, 'PROGRAMACIÓN PYTHON', 550, 1, 40,'15/01/2018', '28/02/1018', 4, 104);
INSERT INTO CURSOS VALUES
(207, 'PROGRAMACIÓN C#', 550, 2, 40, '01/03/2018','31/05/1018', 4, 104);
INSERT INTO CURSOS VALUES
(208, 'PROGRAMACIÓN RUBY', 550, 3, 40, '15/01/2019','01/04/2019', 4, 104);
INSERT INTO CURSOS VALUES
(209, 'REDES LOCALES II', 450, 2, 40, '01/03/2020','31/05/2020', 4, 102);
INSERT INTO CURSOS VALUES
(210, 'ANDROID', 600, 1, 40, '01/06/2020','31/08/2020', 4, 107);
INSERT INTO CURSOS VALUES
(211, 'SERVICIOS EN RED', 500, 3, 40, '01/06/2020','31/08/2020', 4, 102);
INSERT INTO CURSOS VALUES
(212, 'CONCEPTOS BÁSICOS RAL', 300, 1, 30,'01/12/2020', '31/12/2021', 3, 106);
INSERT INTO CURSOS VALUES
(213, 'MONGO DB', 700, 1, 30, '01/09/2018','31/10/2018', 3, 108);
INSERT INTO CURSOS VALUES
(214, 'XBASE', 500, 2, 30, '01/11/2018','15/01/2019', 3, 108);
INSERT INTO CURSOS VALUES
(215, 'ÚLTIMAS TECNOLOGÍAS PB', 350, 1, 30,'01/10/2018', '30/11/2018', 3, 103);
INSERT INTO CURSOS VALUES
(216, 'AJAX', 600, 1, 40, '15/12/2020', '28/02/2021', 4, 109);
INSERT INTO CURSOS VALUES
(217, 'WORDPRESS', 600,1, 30, '01/03/2021','30/04/2021', 3, 109);
INSERT INTO CURSOS VALUES
(218, 'JOOMLA', 600,1, 30, '01/04/2021','30/05/2021', 3, NULL);

INSERT INTO TIPOS_SALARIO VALUES ('BAJO',0, 1200);
INSERT INTO TIPOS_SALARIO VALUES ('MEDIO', 1201,2800);
INSERT INTO TIPOS_SALARIO VALUES ('ALTO', 2801,4999);

INSERT INTO ALUMNOS VALUES
(301, 'AARÓN CORREA', 'LAGUNA 25, MADRID', 28025,620352322, 'A.CORREA@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(302, 'LUCAS BERNAL', 'ABASTOS 5, GETAFE', 28905,620352203, 'L.BERNAL@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(303, 'RUBÉN DÍAZ', 'OROPESA 2, MADRID', 28025,620352322, 'R.DIAZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(304, 'ROBERTO GIL', 'VALENCIA 5, PARLA', 28981,620352322, 'R.GIL@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(305, 'ÁNGEL ALMANSA', 'ALEGRÍA 1, GETAFE', 28905,622032322, 'A.ALMANSA@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(306, 'IVÁN GARCÍA', 'LUSITANA 6, MADRID', 28025,620993222, 'I.GARCIA@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES 
(307, 'MIGUEL SÁNCHEZ', 'SAL 7, LEGANÉS', 28914, 699352322, 'M.SANCHEZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(308, 'EMILIO ORTEGA', 'GORRIÓN 1, MADRID', 28025,620993322, 'E.ORTEGA@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(309, 'MARIANO SIERRA', 'LEGANÉS 2, GETAFE', 28905,620352993, 'M.SIERRA@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(310, 'EVARISTO SANZ', 'GETAFE 9, MADRID', 28025,620352322, 'E.SANZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(311, 'DANIEL BLAYA', 'ISRAEL 8, GETAFE', 28905,628882322, 'D.BLAYA@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(312, 'DAVID LÓPEZ', 'JAZMÍN 15, PINTO', 28320,620389022, 'D.LOPEZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(313, 'ANDRÉS SIMA', 'SOL 63, GETAFE', 28905,677752322, 'A.SIMA@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(314, 'FELIPE COSO', 'SATURNO 12, MADRID', 28025,678752322, 'F.COSO@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(315, 'RUBÉN NARANJO', 'NEPTUNO 5, GETAFE', 28905,620410322, 'R.NARANJO@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(316, 'LUIS DELGADO', 'REAL 45, LEGANÉS', 28914,620000022, 'L.DELGADO@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(317, 'ANTONIO GIL', 'MAR 25, PARLA', 28981,
612152322, 'A.GIL@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(318, 'JESÚS ELEZ', 'RIOJA 6, MADRID', 28025,620311322, 'J.ELEZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(319, 'JOSÉ RICO', 'ALICIA 4, LEGANÉS', 28914,620322322, 'J.RICO@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(320, 'LUÍS MARTÍN', 'LEÓN 78, MADRID', 28025,622222322, 'L.MARTIN@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(321, 'JUAN CERRO', 'GANDÍA 1, GETAFE', 28905,620333322, 'J.CERRO@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(322, 'ANA RAMOS', 'GRAMÍNEA 2, PARLA', 28981,620636322, 'A.RAMOS@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(323, 'SHEILA MARCOS', 'MÉXICO 2, PARLA', 28025,624141322, 'S.MARCOS@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(324, 'FLOR ROSADO', 'TORREJÓN 35, GETAFE', 28905,643252322, 'F.ROSADO@GMAIL.COM');
INSERT INTO ALUMNOS VALUES
(325, 'ALBA MUÑOZ', 'MANCHA 12, PARLA', 28981,611152322, 'A.MUNOZ@HOTMAIL.COM');
INSERT INTO ALUMNOS VALUES
(326, 'ÁLVARO BRAVO', 'GALLO 2, GETAFE', 28905,62035552, 'A.BRAVO@HOTMAIL.COM');

INSERT INTO MATRICULADO VALUES (201, 301, 5.1);
INSERT INTO MATRICULADO VALUES (201, 302, 7.2);
INSERT INTO MATRICULADO VALUES (201, 304, 6.5);
INSERT INTO MATRICULADO VALUES (201, 305, 4.2);
INSERT INTO MATRICULADO VALUES (201, 306, 3.0);
INSERT INTO MATRICULADO VALUES (202, 303, 9.4);
INSERT INTO MATRICULADO VALUES (202, 310, 8.2);
INSERT INTO MATRICULADO VALUES (202, 307, 9.0);
INSERT INTO MATRICULADO VALUES (202, 308, 2.2);
INSERT INTO MATRICULADO VALUES (203, 309, 5.0);
INSERT INTO MATRICULADO VALUES (203, 312, 5.2);
INSERT INTO MATRICULADO VALUES (203, 311, 7.2);
INSERT INTO MATRICULADO VALUES (204, 316, 6.1);
INSERT INTO MATRICULADO VALUES (204, 313, 7.2);
INSERT INTO MATRICULADO VALUES (205, 314, 6.1);
INSERT INTO MATRICULADO VALUES (205, 315, 7.2);
INSERT INTO MATRICULADO VALUES (205, 320, 1.9);
INSERT INTO MATRICULADO VALUES (206, 317, 4.5);
INSERT INTO MATRICULADO VALUES (207, 319, 6.6);
INSERT INTO MATRICULADO VALUES (207, 318, 7.7);
INSERT INTO MATRICULADO VALUES (207, 325, 8.8);
INSERT INTO MATRICULADO VALUES (208, 321, 7.2);
INSERT INTO MATRICULADO VALUES (208, 322, 6.5);
INSERT INTO MATRICULADO VALUES (209, 324, 9.7);
INSERT INTO MATRICULADO VALUES (209, 323, 3.8);
INSERT INTO MATRICULADO VALUES (209, 326, 5.7);
INSERT INTO MATRICULADO VALUES (210, 301, 4.5);
INSERT INTO MATRICULADO VALUES (210, 302, 5.9);
INSERT INTO MATRICULADO VALUES (211, 305, 6.2);
INSERT INTO MATRICULADO VALUES (211, 306, 8.5);
INSERT INTO MATRICULADO VALUES (211, 310, 8.0);
INSERT INTO MATRICULADO VALUES (212, 312, 7.0);
INSERT INTO MATRICULADO VALUES (212, 313, 7.7);
INSERT INTO MATRICULADO VALUES (212, 314, 7.2);
INSERT INTO MATRICULADO VALUES (213, 316, 7.5);
INSERT INTO MATRICULADO VALUES (213, 317, 3.2);
INSERT INTO MATRICULADO VALUES (214, 306, 4.2);
INSERT INTO MATRICULADO VALUES (214, 320, 7.2);
INSERT INTO MATRICULADO VALUES (215, 321, 6.6);
INSERT INTO MATRICULADO VALUES (215, 322, 7.3);
INSERT INTO MATRICULADO VALUES (216, 323, 9.1);
INSERT INTO MATRICULADO VALUES (217, 308, 8.8);
INSERT INTO MATRICULADO VALUES (217, 309, 7.7);
INSERT INTO MATRICULADO VALUES (217, 325, 7.7);
INSERT INTO MATRICULADO VALUES (217, 326, 2.7);
