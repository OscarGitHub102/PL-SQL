/* Bloque PL que utilizando un cursor, seleccione de la tabla PROFESORES el campo NUMPRO y NOMPRO, lo cargue en un registro y visualice los campos del registro posteriormente. Se introducirá un valor por pantalla que indique las filas del cursor que se quieren visualizar*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NUMPRO, NOMPRO FROM PROFESORES ORDER BY NUMPRO;
    TYPE REGISTRO IS RECORD
    (NUMPRO PROFESORES.NUMPRO%TYPE,
    NOMPRO PROFESORES.NOMPRO%TYPE);
    REG REGISTRO;
    V_NUM NUMBER := &NUMERO_FILAS;
BEGIN
    OPEN C1;
    FETCH C1 INTO REG;
    WHILE (C1%ROWCOUNT <= V_NUM) AND (C1%FOUND) LOOP
        DBMS_OUTPUT.PUT_LINE(REG.NUMPRO || ' - ' || REG.NOMPRO);    
        FETCH C1 INTO REG;
    END LOOP;
    CLOSE C1;
END;

/* Ejercicio anterior utilizando el atributo %ROWTYPE */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NUMPRO, NOMPRO FROM PROFESORES ORDER BY NUMPRO;
    REG C1%ROWTYPE;
    V_NUM NUMBER := &NUMERO_FILAS;
BEGIN
    OPEN C1;
    FETCH C1 INTO REG;
    WHILE (C1%ROWCOUNT <= V_NUM) AND (C1%FOUND) LOOP
        DBMS_OUTPUT.PUT_LINE(REG.NUMPRO || ' - ' || REG.NOMPRO);    
        FETCH C1 INTO REG;
    END LOOP;
    CLOSE C1;
END;

/* Mostrar los nombres y los salarios de los profesores mediante un cursor. Almacenando estos en dos variables para posteriormente almacenarlos en dos vectores. Después se visualizarán los datos de los dos vectores cargados. El número de datos que se cargarán e los vectores dependerá de una variable de sustitución que se pide por pantalla */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NOMPRO, SALPRO FROM PROFESORES ORDER BY SALPRO;
    TYPE NOMPRO_VECTOR IS TABLE OF PROFESORES.NOMPRO%TYPE INDEX BY BINARY_INTEGER;
    NOM_VEC NOMPRO_VECTOR;
    TYPE SALPRO_VECTOR IS TABLE OF PROFESORES.SALPRO%TYPE INDEX BY BINARY_INTEGER;
    SAL_VEC SALPRO_VECTOR;
    V_NOMPRO PROFESORES.NOMPRO%TYPE;
    V_SALPRO PROFESORES.SALPRO%TYPE;
    I BINARY_INTEGER := 0;
    V_NUM NUMBER := &NUM_FILAS;
BEGIN
    OPEN C1;
    FETCH C1 INTO V_NOMPRO, V_SALPRO;
    WHILE (C1%ROWCOUNT <= V_NUM) AND (C1%FOUND) LOOP
        I := I + 1;
        NOM_VEC(I) := V_NOMPRO;
        SAL_VEC(I) := V_SALPRO;
        FETCH C1 INTO V_NOMPRO, V_SALPRO;
    END LOOP;
    CLOSE C1;
    FOR I IN 1..V_NUM LOOP
        DBMS_OUTPUT.PUT_LINE(NOM_VEC(I));    
        DBMS_OUTPUT.PUT_LINE(SAL_VEC(I));
    END LOOP;
END;

/* Diseñar un vector de registros que contenga de la tabla PROFESORES, el número, el nombre, el salario y la comisión, basados en el cursor */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NUMPRO, NOMPRO, SALPRO, NVL(COMPRO, 0) AS COMPRO FROM PROFESORES ORDER BY NUMPRO;
    TYPE PROFESOR_C1_VECTOR IS TABLE OF C1%ROWTYPE INDEX BY BINARY_INTEGER;
    C1_VECTOR PROFESOR_C1_VECTOR;
    REG C1%ROWTYPE;
    I BINARY_INTEGER := 0;
BEGIN
    OPEN C1;
    FETCH C1 INTO REG;
    WHILE (C1%FOUND) LOOP
        I := I + 1;
        C1_VECTOR(I) := REG;
        FETCH C1 INTO REG;
    END LOOP;
    CLOSE C1;
    FOR I IN C1_VECTOR.FIRST..C1_VECTOR.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(C1_VECTOR(I).NUMPRO || ' - ' || C1_VECTOR(I).NOMPRO || ' - ' || C1_VECTOR(I).SALPRO || '€ - ' || C1_VECTOR(I).COMPRO || '€');
    END LOOP;
END;

/* Programa que guarde en un vector las notas de los alumnos de la tabla MATRICULADO para posteriormente ir leyendo las notas del vector y calcular la media de todas las notas */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT CALIFIC FROM MATRICULADO;
    TYPE NOTAS_VECTOR IS TABLE OF MATRICULADO.CALIFIC%TYPE INDEX BY BINARY_INTEGER;
    NOTAS NOTAS_VECTOR;
    REG C1%ROWTYPE;
    SUMA NUMBER := 0;
    MEDIA NUMBER;
    I BINARY_INTEGER := 0;
BEGIN
    OPEN C1;
    FETCH C1 INTO REG;
    WHILE (C1%FOUND) LOOP
        I := I + 1;
        NOTAS(I) := REG.CALIFIC;
        SUMA := SUMA + REG.CALIFIC;
        FETCH C1 INTO REG;
    END LOOP;
    FOR I IN NOTAS.FIRST .. NOTAS.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('LA NOTA ' || I || ' ES: ' || NOTAS(I));
    END LOOP;
    MEDIA := ROUND(SUMA/C1%ROWCOUNT, 2);
    DBMS_OUTPUT.PUT_LINE(chr(10) ||'LA MEDIA ES: ' || MEDIA);
    CLOSE C1;
END;

/* Bloque PL que calcule la suma del salario (salario + comisión) de los profesores de la tabla PROFESORES guardándolos en un vector */
SET SERVEROUTPUT ON
DECLARE
    TYPE TIPO_SALARIOS IS TABLE OF PROFESORES.SALPRO%TYPE INDEX BY BINARY_INTEGER;
    TABLA_SALARIOS TIPO_SALARIOS;
    I BINARY_INTEGER := 0;
    CURSOR C1 IS
        SELECT SALPRO + NVL(COMPRO, 0) FROM PROFESORES;
    SALAR NUMBER(8, 2);
    SUMA NUMBER(8, 2) := 0;
BEGIN
    OPEN C1;
    FETCH C1 INTO SALAR;
    WHILE (C1%FOUND) LOOP
        TABLA_SALARIOS(I) := SALAR;
        FETCH C1 INTO SALAR;
        I := I + 1;
    END LOOP;
    CLOSE C1;
    FOR A IN 0 .. (I - 1) LOOP
        DBMS_OUTPUT.PUT_LINE('SALARIO ' || (A + 1) || ': ' || TABLA_SALARIOS(A) || '€');
        SUMA := SUMA + (TABLA_SALARIOS(A));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10) || 'SALARIO TOTAL: ' || SUMA || '€');
END;

/* Programa que guarde en un vector el nombre del alumno de la tabla ALUMNO, en otro la nota de la tabla MATRICULADO, y en otro el título del curso, para posteriormente ir leyendo y visualizando. */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT NOMALU, CALIFIC, TITCUR FROM ALUMNOS A, MATRICULADO M, CURSOS C WHERE A.NUMALU = M.NUMALU AND M.NUMCUR = C.NUMCUR;
    REG_ALU C1%ROWTYPE;
    TYPE NOMBRE_ALU IS TABLE OF ALUMNOS.NOMALU%TYPE INDEX BY BINARY_INTEGER;
    ALUMNO NOMBRE_ALU;
    TYPE NOTA_TABLA IS TABLE OF MATRICULADO.CALIFIC%TYPE INDEX BY BINARY_INTEGER;
    NOTA NOTA_TABLA;
    TYPE CURSO_TABLA IS TABLE OF CURSOS.TITCUR%TYPE INDEX BY BINARY_INTEGER;
    CURSO CURSO_TABLA;
    I BINARY_INTEGER := 0;
BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO REG_ALU;
        EXIT WHEN C1%NOTFOUND;
        ALUMNO(I) := REG_ALU.NOMALU;
        NOTA(I) := REG_ALU.CALIFIC;
        CURSO(I) := REG_ALU.TITCUR;
        I := I + 1;
    END LOOP;
    FOR J IN ALUMNO.FIRST..ALUMNO.LAST LOOP
            DBMS_OUTPUT.PUT_LINE (ALUMNO(J) || ' TIENE UN ' || NOTA(J) || ' EN ' || CURSO(J));
    END LOOP;
END;

/* Programa que guarde en un vector un registro formado por el nombre y el código postal de la tabla ALUMNOS. Paralelamente se creará un vector con las notas de la tabla MATRICULADO */
SET SERVEROUTPUT ON
DECLARE
    CURSOR C1 IS
        SELECT AVG(CALIFIC) MEDIA FROM MATRICULADO GROUP BY NUMALU ORDER BY NUMALU;
    CURSOR C2 IS
        SELECT NOMALU, CPOALU FROM ALUMNOS ORDER BY NUMALU;
    REG C1%ROWTYPE;
    REG2 C2%ROWTYPE;
    TYPE NOTAS_VECTOR IS TABLE OF MATRICULADO.CALIFIC%TYPE INDEX BY BINARY_INTEGER;
    NOTAS NOTAS_VECTOR;
    TYPE NOMBRES_VECTOR IS TABLE OF REG2%TYPE INDEX BY BINARY_INTEGER;
    NOMBRES NOMBRES_VECTOR;
    I BINARY_INTEGER := 0;
BEGIN
    OPEN C1;
    FETCH C1 INTO REG;
    WHILE (C1%FOUND) LOOP
        I := I + 1;
        NOTAS(I) := REG.MEDIA;
        FETCH C1 INTO REG;
    END LOOP;
    I := 0;
    OPEN C2;
    FETCH C2 INTO REG2;
    WHILE (C2%FOUND) LOOP
        I := I + 1;
        NOMBRES(I) := REG2;
        FETCH C2 INTO REG2;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10) || '********* DATOS ALUMNOS *********');
    FOR I IN NOTAS.FIRST .. NOTAS.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
        DBMS_OUTPUT.PUT_LINE('EL NOMBRE ES: '|| NOMBRES(I).NOMALU);
        DBMS_OUTPUT.PUT_LINE('EL CÓDIGO POSTAL ES: '|| NOMBRES(I).CPOALU);
        DBMS_OUTPUT.PUT_LINE('LA NOTA ES: '|| NOTAS(I));
    END LOOP;
    CLOSE C2;
    CLOSE C1;
END;

/* Introduciendo la especialidad en la tabla PROFESORES, cargar un cursor en una tabla de registros, para posteriormente, ordenar dicha tabla alfabéticamente y mostrarla */
SET SERVEROUTPUT ON
DECLARE
  CURSOR C1 IS
    SELECT * FROM PROFESORES WHERE ESPPRO = '&ESPECIALIDAD';
  REGISTRO C1%ROWTYPE;
  TYPE TABLA IS TABLE OF REGISTRO%TYPE INDEX BY BINARY_INTEGER;
  MATRIZ TABLA;
  I NUMBER;
  J NUMBER;
BEGIN
  OPEN C1;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'PROFESORES' || chr(10) || '-------------------');
  LOOP
    FETCH C1 INTO REGISTRO;
    EXIT WHEN C1%NOTFOUND;    
    MATRIZ(C1%ROWCOUNT) := REGISTRO;
    DBMS_OUTPUT.PUT_LINE(C1%ROWCOUNT || ' - ' || MATRIZ(C1%ROWCOUNT).NOMPRO);
  END LOOP;
  FOR I IN 1..MATRIZ.COUNT - 1 LOOP
    FOR J IN I..MATRIZ.COUNT LOOP
      IF MATRIZ(I).NOMPRO > MATRIZ(J).NOMPRO THEN
        REGISTRO := MATRIZ(I);
        MATRIZ(I) := MATRIZ(J);
        MATRIZ(J) := REGISTRO;
      END IF;
    END LOOP;
  END LOOP;
   DBMS_OUTPUT.PUT_LINE(chr(10) || '-------------------');
   DBMS_OUTPUT.PUT_LINE('VALORES ORDENADOS');
   DBMS_OUTPUT.PUT_LINE('-------------------');
  FOR I IN 1..MATRIZ.COUNT LOOP  
     DBMS_OUTPUT.PUT_LINE(MATRIZ(I).NOMPRO);
  END LOOP;
END;