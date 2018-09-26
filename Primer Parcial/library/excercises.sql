SET @curp = 'GAGI020404HSLRZNA2';

-- realiza una consulta que muestre la curp
-- en una columna y en otra la longitud
-- los titulos de las columnas deben ser curp, longitud
SELECT
	@curp AS 'curp',
  LENGTH(@curp) AS 'longitud';

-- realiza una consulta que muestre la curp
-- la longitud de la cadena y la validacion
-- si es de 18 que diga correcta sino incorrecta
-- titulos de columnas, curp, longitud, validacion
SELECT
	@curp AS 'curp',
  LENGTH(@curp) AS 'longitud',
  IF (LENGTH(@curp)=18,'CORRECTA','INCORRECTA') AS 'validacion';

-- realiza una consulta que muestre la curp
-- y una columna que diga 'HOMBRE' o 'MUJER'
-- segun sea el caso del caracter numero 11
-- si es H o M, nombre de columnas curp, genero
SELECT
	@curp AS 'curp',
  IF (SUBSTR(@curp,11,1)='H','HOMBRE','MUJER') AS 'genero';

-- resolver la consulta anterior con consulta anidada
SELECT
	c.curp,
  IF (c.genero='H','HOMBRE','MUJER') AS 'hombreMujer'
FROM
	(SELECT
		@curp AS 'curp',
		SUBSTR(@curp,11,1) AS 'genero') c

-- realiza una consulta que extraiga las siglas
-- del estado de nacimiento



