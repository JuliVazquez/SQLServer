--Obtenga el nombre y apellido de los usuarios que no están relacionados con ninguna feria ordenados por nombre.
SELECT u.nombre, u.apellido
FROM usuario u LEFT JOIN  user_feria uf ON u.id = uf.user_id
WHERE uf.feria_id IS NULL
ORDER BY u.nombre DESC;

--Obtenga el nombre y apellido de los usuarios que están relacionados con SOLAMENTE 1 feria ordenados por apellido.
SELECT MAX(u.nombre)AS Nombre, MAX(u.apellido)AS Apellido
FROM usuario u INNER JOIN user_feria uf ON u.id = uf.user_id
GROUP BY u.id
HAVING COUNT(*) = 1 

--Obtenga el nombre y apellido de los usuarios que no están relacionados con más de una feria.
SELECT u.nombre, u.apellido
FROM usuario u 
WHERE u.id	NOT IN (SELECT u2.id
					FROM usuario u2 INNER JOIN user_feria uf ON u2.id = uf.user_id)			--USUARIOS SIN FERIA
UNION
SELECT MAX(u.nombre)AS Nombre, MAX(u.apellido)AS Apellido
FROM usuario u INNER JOIN user_feria uf ON u.id = uf.user_id
GROUP BY u.id
HAVING COUNT(*) = 1																			--USUARIOS CON SOLO 1 FERIA

--Obtenga el precio por kilo promediado por mes de cada producto, ordenados por tipo de producto ascendente, 
--por especie y variedad del mismo y por precio por kilo descendente.


--Seleccione qué ferias están registradas pero no tienen ninguna declaración.
SELECT f.*
FROM feria f LEFT JOIN declaracion d ON f.id = d.feria_id 
WHERE d.feria_id IS NULL

--Seleccione el nombre, apellido y correo electrónico de los usuarios que hicieron declaraciones de ferias con las 
--que no están relacionados.
SELECT MAX(u.nombre)AS Nombre ,MAX(u.apellido)AS Apellido ,MAX(u.email)AS Email 
FROM user_feria uf	INNER JOIN declaracion d ON uf.feria_id != d.feria_id AND d.user_autor_id = uf.user_id
					INNER JOIN usuario u ON u.id = uf.user_id
GROUP BY u.id

--Obtenga un listado que muestre la cantidad de ferias por zona, ordenados descendentemente por cantidad.
SELECT f.zona, COUNT(*)AS cantidadDeFerias
FROM feria f 
GROUP BY f.zona
HAVING f.zona IS NOT NULL;

--Obtenga un listado que muestre la cantidad de ferias por zona, ordenados descendentemente 
--(el listado debe excluir a las ferias sin declaraciones).	
WITH ferias_con_declaraciones AS(
	SELECT *
	FROM feria f
	WHERE f.id IN (	SELECT DISTINCT d.feria_id
					FROM declaracion d)
)
SELECT fd.zona, COUNT(*) cantidadDeFerias
FROM ferias_con_declaraciones fd
GROUP BY fd.zona

--Obtenga las 3 ferias con más usuarios
SELECT TOP 3 f.id, f.nombre, COUNT(*)AS cantidadDeUsuarios
FROM feria f INNER JOIN user_feria uf ON f.id = uf.feria_id
GROUP BY f.id, f.nombre
ORDER BY cantidadDeUsuarios DESC

--Obtenga el precio primedio por producto 
SELECT p.id, MAX(p.especie)AS especie, MAX(pt.nombre)AS nombre, AVG(di.precio_por_bulto)AS precioPromedoXBulto
FROM producto p INNER JOIN declaracion_individual di ON p.id = di.producto_declarado_id
				INNER JOIN producto_tipo pt ON p.tipo_id = pt.id
GROUP BY p.id
ORDER BY especie ASC


--Obtenga, ordenados alfabéticamente, el nombre y apellido de los usuarios que sólo frutas tienen en sus declaraciones 
--(de acuerdo al tipo de producto).
WITH usuarios_con_frutas_declaradas AS (
					SELECT DISTINCT u.id, u.nombre, u.apellido
					FROM usuario u	INNER JOIN declaracion d ON u.id = d.user_autor_id 
									INNER JOIN declaracion_individual di ON di.declaracion_id = d.id
									INNER JOIN producto p ON p.id = di.producto_declarado_id
					WHERE p.especie = 'Fruta')
SELECT ufd.nombre, ufd.apellido
FROM usuarios_con_frutas_declaradas ufd
WHERE ufd.id NOT IN (	SELECT DISTINCT u.id
						FROM usuario u	INNER JOIN declaracion d ON u.id = d.user_autor_id 
										INNER JOIN declaracion_individual di ON di.declaracion_id = d.id
										INNER JOIN producto p ON p.id = di.producto_declarado_id
						WHERE p.especie != 'Fruta')
ORDER BY ufd.apellido ASC;

