-- funcion para obtener el numero maximo de asistencias en un parcial
DELIMITER ;;
CREATE FUNCTION MaxAsistenciaPorParcial(id_grupo INT, id_asignatura INT, parcial INT)
RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = 0;

    IF (parcial = 1) THEN
        SELECT MAX(asistencias1)
          FROM calificaciones
         WHERE grupo_id = id_grupo
           AND asignatura_id = id_asignatura
          INTO resultado;
    ELSEIF (parcial = 2) THEN
        SELECT MAX(asistencias2)
          FROM calificaciones
         WHERE grupo_id = id_grupo
           AND asignatura_id = id_asignatura
          INTO resultado;
    ELSEIF (parcial = 3) THEN
        SELECT MAX(asistencias3)
          FROM calificaciones
         WHERE grupo_id = id_grupo
           AND asignatura_id = id_asignatura
          INTO resultado;
    ELSE
        SET resultado = NULL;
    END IF;

    RETURN resultado;
END;;

-- definir una funcion que obtenga el maximo total de asistencias de un periodo
DELIMITER ;;
CREATE FUNCTION MaxAsistenciaPorPeriodo(id_grupo INT, id_asignatura INT)
RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = 0;

    SELECT MAX(IFNULL(asistencias1,0)+IFNULL(asistencias2,0)+IFNULL(asistencias3,0))
      FROM calificaciones
     WHERE grupo_id = id_grupo
       AND asignatura_id = id_asignatura
      INTO resultado;

    RETURN resultado;
END;;

-- definir una funcion que obtenga el total de asistencias por materia de un alumno
DELIMITER ;;
CREATE FUNCTION TotalAsistenciaPorAlumnoAsignatura(id_grupo INT, id_asignatura INT, id_alumno INT)
RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = 0;

    SELECT (IFNULL(asistencias1,0)+IFNULL(asistencias2,0)+IFNULL(asistencias3,0))
      FROM calificaciones
     WHERE grupo_id = id_grupo
       AND asignatura_id = id_asignatura
       AND alumno_id = id_alumno
      INTO resultado;

    RETURN resultado;
END;;


-- definir una funcion que obtenga el porcentaje de asistencias por materia de un alumno
DELIMITER ;;
DROP FUNCTION IF EXISTS PorcentajeAsistenciaPorAlumnoAsignatura;;
CREATE FUNCTION PorcentajeAsistenciaPorAlumnoAsignatura(id_grupo INT, id_asignatura INT, id_alumno INT)
RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = 0;

    SELECT (TotalAsistenciaPorAlumnoAsignatura(grupo_id, asignatura_id, alumno_id)/MaxAsistenciaPorPeriodo(grupo_id, asignatura_id))*100
      FROM calificaciones
     WHERE grupo_id = id_grupo
       AND asignatura_id = id_asignatura
       AND alumno_id = id_alumno
      INTO resultado;

    RETURN resultado;
END;;

-- definir una consulta que obtenga el resultado de una boleta
DELIMITER ;;
CREATE PROCEDURE ImprimirBoletasGrupales(
  IN _periodo VARCHAR(30),
  IN _turno VARCHAR(10),
  IN _semestre INT,
  IN _carrera INT,
  IN _grupo CHAR(6)
)
BEGIN
  DECLARE id_grupo INT;
  SET id_grupo = NULL;

  SELECT id
    FROM grupos
   WHERE periodo = _periodo
     AND turno = _turno
     AND semestre = _semestre
     AND carrera_id = _carrera
     AND nombre = _grupo
    INTO id_grupo;

  select
    g.id as 'grupo_id',
    g.periodo,
    g.turno,
    g.semestre,
    g.nombre as 'grupo',
    r.nombre as 'carrera',
    a.id as 'alumno_id',
    concat(a.nombre,' ',a.paterno,' ',a.materno) as 'alumno',
    a.no_control,
    a.generacion,
    s.id as 'clave_asignatura',
    s.nombre as 'asignatura',
    ifnull(c.parcial1,'') as 'parcial1',
    ifnull(c.parcial2,'') as 'parcial2',
    ifnull(c.parcial3,'') as 'parcial3',
    ifnull(c.asistencias1,'') as 'asistencias1',
    ifnull(c.asistencias2,'') as 'asistencias2',
    ifnull(c.asistencias3,'') as 'asistencias3',
    PorcentajeAsistenciaPorAlumnoAsignatura(c.grupo_id, c.asignatura_id, c.alumno_id) as 'porcentaje_asistencia'
  from calificaciones c
  join asignaturas s
    on c.asignatura_id = s.id
  join grupos g
    on c.grupo_id = g.id
  join carreras r
    on g.carrera_id = r.id
  join alumnos a
    on c.alumno_id = a.id
  where grupo_id = id_grupo;
END;;

CALL ImprimirBoletasGrupales('semestral 1 - 2018', 'vespertino', 3, 4, '3av-pr');;