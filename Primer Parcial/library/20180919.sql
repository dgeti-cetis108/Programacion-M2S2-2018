/* 01: Realiza una consulta que muestre nombre y fecha de nacimiento
       de los alumnos que nacieron en el mes de septiembre, ordenados
       por fecha de nacimiento
+-----------------+------------------+
| nombre          | fecha_nacimiento |
+-----------------+------------------+
| JUSTIN GABRIEL  | 2001-09-13       |
| MAYRA ELIZETH   | 2001-09-21       |
| JOSE CARLOS     | 2002-09-02       |
| MARIANA         | 2002-09-25       |
| JUDA JUAN PABLO | 2002-09-28       |
+-----------------+------------------+
... */
SELECT nombre, fecha_nacimiento
  FROM alumnos
--  WHERE SUBSTRING(fecha_nacimiento, 6, 2) = '09'
 WHERE MONTH(fecha_nacimiento) = 9
 ORDER BY fecha_nacimiento;

/* 02: Realiza una consulta que muestre el numero de control,
       nombre, apellidos en una sola columna con alias 'apellidos'
       de los alumnos que su apellido paterno sea igual a
       'CASTRO', 'ALVAREZ' ó 'VEA', ordenados por apellido paterno
+----------------+----------------+----------------+
| no_control     | nombre         | apellidos      |
+----------------+----------------+----------------+
| 17325061080322 | JESUS PAUL     | ALVAREZ LOPEZ  |
| 17325061080367 | JOSE CARLOS    | ALVAREZ LOPEZ  |
| 17325061080146 | ANDRES ANTONIO | CASTRO BELTRAN |
| 17325061080192 | JOSUE          | CASTRO LOPEZ   |
| 17325061080132 | IRMA GUADALUPE | VEA SALAZAR    |
| 17325061080317 | MAYRA ELIZETH  | VEA FALOMIR    |
+----------------+----------------+----------------+
... */
SELECT no_control, nombre, CONCAT(paterno,' ',materno) as 'apellidos'
  FROM alumnos
--  WHERE paterno='CASTRO' OR paterno='ALVAREZ' OR paterno='VEA'
 WHERE paterno IN ('CASTRO', 'ALVAREZ', 'VEA')
 ORDER BY paterno;

/* 03: Realiza una consulta que muestre la curp de los alumnos
       donde esta termine con el caracter '0' ordenadas en
       forma descendente
+--------------------+
| curp               |
+--------------------+
| VAED021004MSLLSYA0 |
| SAAK020204MSLNYRA0 |
| OAZE000630MSLVZDA0 |
| MOCE020821HSLNRXA0 |
| EESJ020403HSLLTRA0 |
| CAPN020430MSLRRCA0 |
+--------------------+
... */
SELECT curp
  FROM alumnos
--  WHERE SUBSTRING(curp, 18, 1) = '0'
--  WHERE RIGHT(curp, 1) = '0'
 WHERE curp LIKE '%0'
 ORDER BY curp DESC;

/* 04: Realiza una consulta que muestre el nombre completo
       de los alumnos, en los cuales su primer nombre
       sea igual a 'JESUS' ordenados por apellido paterno
       y materno
+---------------------------------+
| alumno                          |
+---------------------------------+
| JESUS PAUL ALVAREZ LOPEZ        |
| JESUS ARMANDO DIMAS OBESO       |
| JESUS ARMANDO ESPARZA MOYA      |
| JESUS FERNANDO MELENDREZ ROMERO |
+---------------------------------+
... */
SELECT CONCAT(nombre,' ',paterno,' ',materno) as 'alumno'
  FROM alumnos
 WHERE nombre LIKE 'JESUS%'
--  WHERE LEFT(nombre,5) = 'JESUS'
 ORDER BY paterno, materno;

/* 05: Realiza una consulta que muestre el nombre completo
       de los alumnos, en los cuales se encuentre el
       nombre 'JUAN' ordenados en forma ascendente
+---------------------------------+
| alumno                          |
+---------------------------------+
| JUDA JUAN PABLO TORRES ESPINOZA |
| JUAN DE DIOS INZUNZA RODRIGUEZ  |
+---------------------------------+
... */
SELECT CONCAT(nombre,' ',paterno,' ',materno) as 'alumno'
  FROM alumnos
 WHERE nombre LIKE '%JUAN%'
 ORDER BY alumno;

/* 06: Realiza una consulta que muestre el nombre completo
       de los alumnos hombres que nacieron en sinaloa
       y el nombre del estado, ordenados por curp
+-------------------------------------+---------+
| alumno                              | estado  |
+-------------------------------------+---------+
| JOSE CARLOS ALVAREZ LOPEZ           | SINALOA |
| JESUS PAUL ALVAREZ LOPEZ            | SINALOA |
| JUSTIN GABRIEL ABOITE GONZALEZ      | SINALOA |
| OBED RUBIO GUTIERREZ                | SINALOA |
| JUDA JUAN PABLO TORRES ESPINOZA     | SINALOA |
| YERCO SEBASTIAN VALENZUELA VIDOVICH | SINALOA |
| BRAYAN JACOBO VERDUGO GALVEZ        | SINALOA |
+-------------------------------------+---------+
... */
SELECT CONCAT(nombre,' ',paterno,' ',materno) AS 'alumno',
       'SINALOA' AS 'estado'
  FROM alumnos
 WHERE genero = 'HOMBRE' AND estado_2c = 'SL'
 ORDER BY curp;

/* 07: Realiza una consulta que muestre el nombre completo
       de las alumnas mujeres que nacieron en sinaloa en el
       mes de enero, ordenadas por apellido paterno y materno
+------------------------------+
| alumna                       |
+------------------------------+
| EVELYN JASIVE SANCHEZ IBARRA |
| GRISEL YAVIER SAÑUDO LOPEZ   |
+------------------------------+
... */
SELECT CONCAT(nombre,' ',paterno,' ',materno) AS 'alumna'
  FROM alumnos
 WHERE genero = 'MUJER' AND estado_2c = 'SL' AND MONTH(fecha_nacimiento) = 1
 ORDER BY paterno, materno;

/* 08: Realiza una consulta que muestre la curp de los
       alumnos, cuando esta inicie con la letra 'C'
       ordenados de forma ascendente
+--------------------+
| curp               |
+--------------------+
| CABA021118HSLSLNA4 |
| CACM020925MSLHRRA6 |
| CALJ030409HNESPAA2 |
| CAPN020430MSLRRCA0 |
+--------------------+
... */
SELECT curp
  FROM alumnos
 WHERE curp LIKE 'C%'
--  WHERE LEFT(curp,1) = 'C'
 ORDER BY curp;

/* 09: Realiza una consulta que muestre las columnas
       id, nombre, paterno, materno de los alumnos
       cuyo id sea mayor a 30
+----+-----------------+---------+-----------+
| id | nombre          | paterno | materno   |
+----+-----------------+---------+-----------+
| 31 | JOSE CARLOS     | ALVAREZ | LOPEZ     |
| 32 | EXIQUIO EDUARDO | MONTES  | CRUZ      |
| 33 | EDLIN YAMILETH  | OVALLES | ZAZUETA   |
| 34 | DAYAN RAFAELA   | VALLE   | ESCALANTE |
| 35 | EVELIN ESTEFANI | ROSALES | ESPINOZA  |
| 36 | ELEAZAR         | FELIX   | ACEVEDO   |
| 37 | EVELYN JASIVE   | SANCHEZ | IBARRA    |
+----+-----------------+---------+-----------+
... */
SELECT id, nombre, paterno, materno
  FROM alumnos
 WHERE id > 30;

/* 10: Realiza una consulta que muestre las columnas
       id, nombre, paterno, materno de los alumnos
       cuyo id tenga valor entre 10 y 15
+----+-----------------+-----------+----------+
| id | nombre          | paterno   | materno  |
+----+-----------------+-----------+----------+
| 10 | JESUS ARMANDO   | DIMAS     | OBESO    |
| 11 | JORGE IVAN      | ELENES    | SOTO     |
| 12 | GRISEL YAVIER   | SAÑUDO    | LOPEZ    |
| 13 | JUDA JUAN PABLO | TORRES    | ESPINOZA |
| 14 | SURIEL ADRIAN   | BOJORQUEZ | ARMENTA  |
| 15 | JOSUE           | CASTRO    | LOPEZ    |
+----+-----------------+-----------+----------+
... */
SELECT id, nombre, paterno, materno
  FROM alumnos
--  WHERE id >= 10 AND id <= 15;
 WHERE id BETWEEN 10 AND 15;

/* 11: Realiza una consulta que muestre las columnas
       id, nombre, paterno, materno de los alumnos
       cuyo id tenga valor menor a 4 ó mayor a 30
+----+-------------------+---------+-----------+
| id | nombre            | paterno | materno   |
+----+-------------------+---------+-----------+
|  1 | MARIANA           | CHAIDES | CERVANTES |
|  2 | MELINA SADDAY     | PEREZ   | VIZCARRA  |
|  3 | MALITZIN ANAYANCI | RUBIO   | CAMACHO   |
| 31 | JOSE CARLOS       | ALVAREZ | LOPEZ     |
| 32 | EXIQUIO EDUARDO   | MONTES  | CRUZ      |
| 33 | EDLIN YAMILETH    | OVALLES | ZAZUETA   |
| 34 | DAYAN RAFAELA     | VALLE   | ESCALANTE |
| 35 | EVELIN ESTEFANI   | ROSALES | ESPINOZA  |
| 36 | ELEAZAR           | FELIX   | ACEVEDO   |
| 37 | EVELYN JASIVE     | SANCHEZ | IBARRA    |
+----+-------------------+---------+-----------+
... */
SELECT id, nombre, paterno, materno
  FROM alumnos
 WHERE id < 4 OR id > 30;