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
CREATE FUNCTION PorcentajeAsistenciaPorAlumnoAsignatura(id_grupo INT, id_asignatura INT, id_alumno INT)
RETURNS INT
BEGIN
    DECLARE resultado INT;
    SET resultado = 0;

    SELECT TotalAsistenciaPorAlumnoAsignatura(grupo_id, asignatura_id, alumno_id)/MaxAsistenciaPorPeriodo(grupo_id, asignatura_id)
      FROM calificaciones
     WHERE grupo_id = id_grupo
       AND asignatura_id = id_asignatura
       AND alumno_id = id_alumno
      INTO resultado;

    RETURN resultado;
END;;

-- definir una consulta que obtenga el resultado de una boleta
DELIMITER ;
select
	s.id as 'clave_asignatura',
  s.nombre as 'asignatura',
  c.parcial1,
  c.parcial2,
  c.parcial3,
  c.asistencias1,
  c.asistencias2,
  c.asistencias3,
  PorcentajeAsistenciaPorAlumnoAsignatura(c.grupo_id, c.asignatura_id, c.alumno_id) as 'porcentaje_asistencia'
from calificaciones c
join asignaturas s
  on c.asignatura_id = s.id
where grupo_id = 11
  and alumno_id = 1;