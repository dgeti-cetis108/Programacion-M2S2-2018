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

-- consulta que muestre los grupos y asignaturas
-- debe tener una asignatura por cada grupo sin repetir
-- agregar la columna periodo con el valor 'SEMESTRAL 2 - 2017'
-- nota: por cada carrera existen grupos con asignaturas
insert into grupos (carrera_id,turno,grupo,semestre,periodo)
select
	(select id from carreras where nombre = c.carrera) as 'carrera_id',
  turno,
	concat(grupo,left(turno,1),'-',left(carrera,3)) as 'grupo', -- 2AV-PRO
  semestre,
  'SEMESTRAL 2 - 2017' as 'periodo'
from calificaciones c
group by carrera, turno, c.grupo;

-- crear tabla grupos
create table grupos (
	id int auto_increment primary key,
  carrera_id int not null,
  turno enum('MATUTINO','VESPERTINO') not null,
  grupo char(7) not null,
  semestre tinyint unsigned not null,
  periodo varchar(100) not null,
  unique key (grupo, periodo)
) engine=innodb, charset=utf8, collate=utf8_general_ci;

-- consulta para mostrar calificaciones del alumno
insert into notas (no_control,grupo_id,asignatura_id,parcial1,parcial2,parcial3,asistencias1,asistencias2,asistencias3,tipo_acreditacion)
SELECT 
    no_control,
    (SELECT 
            id
        FROM
            grupos
        WHERE
            grupo = CONCAT(c.grupo,
                    LEFT(c.turno, 1),
                    '-',
                    LEFT(c.carrera, 3))
                AND periodo = 'SEMESTRAL 2 - 2017') AS 'grupo_id',
    (select id from asignaturas where nombre = c.nombre_asignatura) as 'asignatura_id',
    parcial1,
    parcial2,
    parcial3,
    asistencias1,
    asistencias2,
    asistencias3,
    tipo_acreditacion
FROM
    calificaciones c;
	
-- crear tabla para notas
create table notas (
	id int auto_increment primary key,
  no_control varchar(20) not null,
  grupo_id int not null,
  asignatura_id int not null,
  parcial1 float(3,1) default null,
  parcial2 float(3,1) default null,
  parcial3 float(3,1) default null,
  asistencias1 int default null,
  asistencias2 int default null,
  asistencias3 int default null,
  tipo_acreditacion enum('A','NA','NP') default null
) engine=innodb, charset=utf8, collate=utf8_general_ci;

select group_concat(distinct tipo_acreditacion) from calificaciones;

select * from notas;

select
	n.no_control,
  a.nombre,
  a.paterno,
  a.materno,
  n.parcial1,
  n.asistencias1
from notas n
join alumnos a
  on n.no_control = a.no_control
where n.no_control = '17325061080099';





