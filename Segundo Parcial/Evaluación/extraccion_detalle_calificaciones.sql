-- obtener alumnos del 2AV-PR y 3AV-PR de la generación 2017-2020
select
	no_control,
	nombre,
	paterno,
	materno,
	curp,
	substr(curp,11,1) as 'genero',
	date(substr(curp,5,6)) as 'fecha_nacimiento',
	substr(curp,12,2) as 'estado_2c',
	generacion
from cetis108.detalle_calificaciones
where periodo in ('semestral 2 - 2017','semestral 1 - 2018')
	and semestre in (2,3)
	and carrera = 'programacion'
	and turno = 'vespertino'
	and generacion = '2017-2020'
group by
	no_control;

-- obtener carreras
select
	distinct carrera
from cetis108.detalle_calificaciones;

-- obtener asignaturas
select
	(select id from carreras where nombre = d.carrera) as 'carrera_id',
	nombre_asignatura as 'nombre',
	semestre,
	0 as 'horas'
from cetis108.detalle_calificaciones d
where es_modulo = 'no'
group by carrera, nombre_asignatura
order by carrera, semestre, nombre_asignatura;

-- obtener grupos
select
	c.id as 'carrera_id',
	d.semestre,
	d.turno,
	concat(d.grupo,left(turno,1),'-',c.nombre_2c) as 'nombre',
	d.periodo
from cetis108.detalle_calificaciones d
join carreras c
	on d.carrera = c.nombre
join alumnos a
	on d.no_control = a.no_control
where periodo_tipo = 'semestral'
group by nombre;

-- obtener calificaciones
select
	g.id as 'grupo_id',
	a.id as 'alumno_id',
	s.id as 'asignatura_id',
	if(d.parcial1='',NULL,d.parcial1) as 'parcial1',
	if(d.parcial2='',NULL,d.parcial2) as 'parcial2',
	if(d.parcial3='',NULL,d.parcial3) as 'parcial3',
	if(d.asistencias1='',NULL,d.asistencias1) as 'asistencias1',
	if(d.asistencias2='',NULL,d.asistencias2) as 'asistencias2',
	if(d.asistencias3='',NULL,d.asistencias3) as 'asistencias3',
	d.tipo_acreditacion
from cetis108.detalle_calificaciones d
join grupos g on d.gpo = g.nombre and d.periodo = g.periodo
join alumnos a on d.no_control = a.no_control
join (carreras c join asignaturas s on s.carrera_id = c.id)
on g.carrera_id = c.id and d.nombre_asignatura = s.nombre
where d.periodo_tipo = 'semestral';