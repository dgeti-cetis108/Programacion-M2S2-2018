## Diseña y administra base de datos avanzadas

### Evaluación de primer parcial

#### Instrucciones

1. Utilizando MySQL Workbench realiza una conexión al servidor con la siguiente configuración:

   | Configuración             | Valor                                         |
   | ------------------------- | --------------------------------------------- |
   | Nombre de conexión        | Primer Parcial                                |
   | Nombre de host            | 10.108.0.136  *(ó la que el docente indique)* |
   | Puerto                    | 3306                                          |
   | Nombre de usuario         | alumno                                        |
   | Contraseña                | cetis108                                      |
   | Base de datos por defecto | library                                       |

   ![mysql workbench config](./images/mysql-workbench-config.png)

2. En la base de datos `library` encontrarás una tabla llamada `calificaciones` la cual tiene la siguiente descripción:

   | Campo             | Tipo                | Descripción                                                  |
   | ----------------- | ------------------- | ------------------------------------------------------------ |
   | clv_centro        | varchar(20)         | Clave de centro de trabajo                                   |
   | plantel           | varchar(20)         | Nombre corto del plantel                                     |
   | carrera           | varchar(255)        | Nombre de la carrera                                         |
   | generacion        | varchar(20)         | Generación del alumno                                        |
   | turno             | varchar(20)         | Turno escolar                                                |
   | semestre          | tinyint(4)          | Semestre en turno (1-6)                                      |
   | grupo             | varchar(10)         | Nombre de grupo (2A)                                         |
   | no_control        | varchar(20)         | Número de control del alumno                                 |
   | nombre            | varchar(50)         | Nombre del alumno                                            |
   | paterno           | varchar(50)         | Apellido paterno del alumno                                  |
   | materno           | varchar(50)         | Apellido materno del alumno                                  |
   | curp              | varchar(18)         | CURP (Clave única de registro de población)                  |
   | nombre_asignatura | varchar(255)        | Nombre de la asignatura                                      |
   | parcial1          | float(3,1)          | Calificación de primer parcial                               |
   | parcial2          | float(3,1)          | Calificación de segundo parcial                              |
   | parcial3          | float(3,1)          | Calificación de tercer parcial                               |
   | asistencias1      | int(11)             | Número de horas de asistencia<br />del primer parcial        |
   | asistencias2      | int(11)             | Número de horas de asistencia<br />del segundo parcial       |
   | asistencias3      | int(11)             | Número de horas de asistencia<br />del tercer parcial        |
   | tipo_acreditacion | enum('A','NA','NP') | Tipo de acreditación<br />A = Acreditado<br />NA = No Acreditado por calificación<br />NP = No Acreditado por faltas |

   3. Realiza las siguientes consultas utilizando la tabla `calificaciones`, escribe las consultas en MySQL Workbench y al finalizar guarda el archivo con el nombre formado por tus INICIALES EN MAYÚSCULA seguido de _PrimerParcial.sql por ejemplo para mi caso sería `BAC_PrimerParcial.sql`
      *Sugerencia: descarga el archivo con las indicaciones debajo mostradas, abrelo en MySQL Workbench y empieza a resolver las consultas, al final le renombras en base a la indicación.*

   [Descarga indicaciones](./_PrimerParcial.sql)

   ```
   -- ----------------------------------------- --
   -- Primer Parcial de base de datos avanzadas --
   -- ----------------------------------------- --
   /* Alumno(a): Escribe tu nombre aqui */
   
   /* 01: Realiza una consulta que muestre el nombre completo del alumno
      en una sola columna titulada 'alumno' */
   /* Información: como habrás notado con el resultado de la consulta anterior
      el nombre del alumno aparece repetido 1 vez por cada asignatura,
      si puedes hacer que solo muestre valores únicos sin repetir, obtendrás
      una bonoficación en la calificación */
   
   
   /* 02: Realiza una consulta que muestre el nombre completo del alumno y
      la calificación de los 3 parciales de la asignatura 'INGLÉS II' */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, par1, par2, par3
   
   
   /* 03: Realiza una consulta que muestre el nombre completo del alumno,
      la calificación de los 3 parciales de la asignatura 'QUÍMICA II' y
      calcula el promedio */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, par1, par2, par3, promedio
   
   
   /* 04: Realiza una consulta que muestre el nombre completo del alumno,
      el nombre de la asignatura, el número de horas de asistencia para
      cada parcial y la sumatoria de las asistencias de los 3 parciales */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, ast1, ast2, ast3, total_asistencias
   
   
   /* 05: Realiza una consulta que muestre el nombre de la carrera, la
      generación, turno, semestre, número de control, nombre completo del
      alumno, nombre de la asignatura, de todos aquellos alumnos que
      reprobaron por calificación, ordenados por la curp */
      -- Las columnas resultantes deberán llamarse
      -- carrera, generacion, turno, semestre, num_control, alumno, asignatura
   
   
   /* 06: Realiza una consulta que muestre el nombre de la carrera, la
      generación, turno, semestre, número de control, nombre completo del
      alumno, nombre de la asignatura, de todos aquellos alumnos que
      reprobaron por faltas, ordenados por número de control */
      -- Las columnas resultantes deberán llamarse
      -- carrera, generacion, turno, semestre, num_control, alumno, asignatura
   
   
   /* 07: Realiza una consulta que muestre el nombre completo del alumno
      y el nombre de asignatura, de todos aquellos alumnos que obtuvieron
      promedio de 10 en la asignatura y que no estan reprobados por faltas */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, promedio
   
   
   /* 08: Realiza una consulta que muestre el nombre completo del alumno
      y el nombre de asignatura, de aquellos alumnos que obtuvieron un
      promedio aprobatorio (>= 6) pero que estan reprobados por faltas */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, promedio
   
   
   /* 09: Realiza una consulta que muestre el nombre completo de la alumna,
      el nombre de asignatura y motivo de reprobación de las alumnas que
      reprobaron alguna asignatura por cualquier motivo (calificación o faltas)
      en la columna causa_reprobacion deberá decir 'Por faltas' ó 'Por calificación'
      dependiendo de la causa de reprobación */
      -- Las columnas resultantes deberán llamarse
      -- alumna, asignatura, causa_reprobacion
   
   /* 10: Realiza una consulta que muestre tus calificaciones y asistencias
      de la asignatura 'DISEÑA Y ADMINISTRA BASES DE DATOS SIMPLES'
      calcula el promedio y el total de asistencias */
      -- Las columnas resultantes deberán llamarse
      -- alumno, asignatura, par1, par2, par3, promedio,
      -- ast1, ast2, ast3, total_asistencias
   ```

   4. A continuación realiza la entrega del archivo realizado y comprueba que ha sido recibido.
      [Entregar solución](./entrega.php)

