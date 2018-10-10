use library;

select * from calificaciones;

-- consultas de agregacion
select
	no_control,
	concat(paterno,' ',materno,' ',nombre) as 'alumno',
  count(nombre_asignatura) as 'materias'
from calificaciones
group by no_control;

-- consulta que muestre al alumno y el promedio semestral
select
	concat(paterno,' ',materno,' ',nombre) as 'alumno',
	avg((parcial1+parcial2+parcial3)/3) as 'promedio'
from calificaciones
group by no_control;

-- consulta que muestre las materias y promedio grupal
select
	nombre_asignatura as 'asignatura',
  avg((parcial1+parcial2+parcial3)/3) as 'promedio_general'
from calificaciones
group by nombre_asignatura
order by promedio_general;

-- consulta que muestre las materias,promedio grupal,aprobados y reprobados
select
	nombre_asignatura as 'asignatura',
  avg((parcial1+parcial2+parcial3)/3) as 'promedio_general',
  sum(if(tipo_acreditacion='A',1,0)) as 'aprobados',
  sum(if(tipo_acreditacion!='A',1,0)) as 'reprobados',
  count(no_control) as 'total'
from calificaciones
group by nombre_asignatura
order by promedio_general;


-- consulta que muestre cct, plantel sin repetir
select
	clv_centro as 'cct',
  plantel as 'nombre'
from calificaciones
group by clv_centro;

-- consulta que cree una tabla llamada planteles
-- con las columnas cct(pk), plantel
create table planteles as
select
	clv_centro as 'cct',
  plantel as 'nombre'
from calificaciones
group by clv_centro;

-- definir la llave primaria para planteles
describe planteles;
alter table planteles
	add primary key (cct);

-- crear tabla carreras con columnas id, nombre
create table carreras (
	id int auto_increment primary key,
  nombre varchar(200) not null
) engine=innodb, charset=utf8, collate=utf8_general_ci;

-- insertar registros de carreras a partir de calificaciones
insert into carreras (nombre)
select
	distinct carrera
from calificaciones;

-- consulta que extraiga informacion del alumno sin repetir
-- nombre, paterno, materno, curp, generacion, no_control
select
	no_control,
  generacion,
  nombre,paterno,materno,
  curp
from calificaciones
group by curp;

-- crear tabla alumnos a partir de existentes, sin repetir
create table alumnos as
select
	no_control,
  generacion,
  nombre,paterno,materno,
  curp
from calificaciones
group by curp;

-- definir llave primaria para alumnos no_control(pk), curp(uk)
desc alumnos;
alter table alumnos
add primary key (no_control),
add unique key (curp);

-- consulta que devuelva las asignaturas sin repetir
select
	carrera,
	nombre_asignatura
from calificaciones
group by carrera, nombre_asignatura;

-- crear la tabla asignaturas
create table asignaturas (
	id int auto_increment primary key,
  carrera_id int not null,
  nombre varchar(200) not null
) engine=innodb, charset=utf8, collate=utf8_general_ci;

-- insertar asignaturas
insert into asignaturas (carrera_id, nombre)
select
	(select id from carreras where nombre = c.carrera),
	nombre_asignatura
from calificaciones c
group by carrera, nombre_asignatura;




