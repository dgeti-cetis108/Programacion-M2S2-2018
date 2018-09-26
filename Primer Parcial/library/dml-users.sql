-- Crear un registro en la tabla users
INSERT INTO `users` (`name`, `password`, `firstname`, `lastname`, `email`)
VALUES ('admin', sha('123'), 'Administrador', 'General', 'admin@general.com');

-- Actualizar el registro para cambiar el nombre y apellido
UPDATE `users` SET
	`firstname` = 'Bill',
	`lastname` = 'Gates'
WHERE `id` = 1;