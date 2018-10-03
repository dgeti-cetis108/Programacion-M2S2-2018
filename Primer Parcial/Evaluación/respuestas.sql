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
select concat(nombre,' ',paterno,' ',materno) as 'alumno'
from calificaciones
group by no_control;
​


/* 02: Realiza una consulta que muestre el nombre completo del alumno y
   la calificación de los 3 parciales de la asignatura 'INGLÉS II' */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, par1, par2, par3
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	parcial1 as 'par1',
	parcial2 as 'par2',
	parcial3 as 'par3'
from calificaciones
where nombre_asignatura = 'INGLÉS II';

​

/* 03: Realiza una consulta que muestre el nombre completo del alumno,
   la calificación de los 3 parciales de la asignatura 'QUÍMICA II' y
   calcula el promedio */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, par1, par2, par3, promedio
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	parcial1 as 'par1',
	parcial2 as 'par2',
	parcial3 as 'par3',
	(parcial1+parcial2+parcial3)/3 as 'promedio'
from calificaciones
where nombre_asignatura = 'QUÍMICA II';
​

​

/* 04: Realiza una consulta que muestre el nombre completo del alumno,
   el nombre de la asignatura, el número de horas de asistencia para
   cada parcial y la sumatoria de las asistencias de los 3 parciales */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, ast1, ast2, ast3, total_asistencias
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	asistencias1 as 'ast1',
	asistencias2 as 'ast2',
	asistencias3 as 'ast3',
	asistencias1+asistencias2+asistencias3 as 'total_asistencias'
from calificaciones;
​

​

/* 05: Realiza una consulta que muestre el nombre de la carrera, la
   generación, turno, semestre, número de control, nombre completo del
   alumno, nombre de la asignatura, de todos aquellos alumnos que
   reprobaron por calificación, ordenados por la curp */
   -- Las columnas resultantes deberán llamarse
   -- carrera, generacion, turno, semestre, num_control, alumno, asignatura
;
select
	carrera,
	generacion,
	turno,
	semestre,
	no_control as 'num_control',
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura'
from calificaciones
where
	tipo_acreditacion = 'NA'
order by curp;
​

​

/* 06: Realiza una consulta que muestre el nombre de la carrera, la
   generación, turno, semestre, número de control, nombre completo del
   alumno, nombre de la asignatura, de todos aquellos alumnos que
   reprobaron por faltas, ordenados por número de control */
   -- Las columnas resultantes deberán llamarse
   -- carrera, generacion, turno, semestre, num_control, alumno, asignatura
;
select
	carrera,
	generacion,
	turno,
	semestre,
	no_control as 'num_control',
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura'
from calificaciones
where
	tipo_acreditacion = 'NP'
order by no_control;
​

​

/* 07: Realiza una consulta que muestre el nombre completo del alumno
   y el nombre de asignatura, de todos aquellos alumnos que obtuvieron
   promedio de 10 en la asignatura y que no estan reprobados por faltas */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, promedio
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	(parcial1+parcial2+parcial3)/3 as 'promedio'
from calificaciones
where (parcial1+parcial2+parcial3)/3 = 10.0
  and tipo_acreditacion != 'NP';
​

​

/* 08: Realiza una consulta que muestre el nombre completo del alumno
   y el nombre de asignatura, de aquellos alumnos que obtuvieron un
   promedio aprobatorio (>= 6) pero que estan reprobados por faltas */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, promedio
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	(parcial1+parcial2+parcial3)/3 as 'promedio'
from calificaciones
where (parcial1+parcial2+parcial3)/3 >= 6
and tipo_acreditacion = 'NP';
;
​

/* 09: Realiza una consulta que muestre el nombre completo de la alumna,
   el nombre de asignatura y motivo de reprobación de las alumnas que
   reprobaron alguna asignatura por cualquier motivo (calificación o faltas)
   en la columna causa_reprobacion deberá decir 'Por faltas' ó 'Por calificación'
   dependiendo de la causa de reprobación */
   -- Las columnas resultantes deberán llamarse
   -- alumna, asignatura, causa_reprobacion
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumna',
	nombre_asignatura as 'asignatura',
	if(tipo_acreditacion='NA','Por Calificación','Por Faltas') as 'causa_reprobacion'
from calificaciones
where
	substring(curp,11,1) = 'M' and
	tipo_acreditacion != 'A';

/* 10: Realiza una consulta que muestre tus calificaciones y asistencias
   de la asignatura 'DISEÑA Y ADMINISTRA BASES DE DATOS SIMPLES'
   calcula el promedio y el total de asistencias */
   -- Las columnas resultantes deberán llamarse
   -- alumno, asignatura, par1, par2, par3, promedio,
   -- ast1, ast2, ast3, total_asistencias
;
select
	concat(nombre,' ',paterno,' ',materno) as 'alumno',
	nombre_asignatura as 'asignatura',
	parcial1 as 'par1',
	parcial2 as 'par2',
	parcial3 as 'par3',
	(parcial1+parcial2+parcial3)/3 as 'promedio',
	asistencias1 as 'ast1',
	asistencias2 as 'ast2',
	asistencias3 as 'ast3',
	asistencias1+asistencias2+asistencias3 as 'total_asistencias'
from calificaciones
where
	nombre= 'mariana' and
	paterno = 'chaides' and
	materno = 'cervantes';
	




