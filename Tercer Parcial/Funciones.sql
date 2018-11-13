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