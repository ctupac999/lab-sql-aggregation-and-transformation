-- Desafío 1

-- 1. Debe utilizar las funciones integradas de SQL para obtener información relacionada con la duración de las películas:
-- 1.1 Determine las **duraciones más cortas y más largas de las películas** y nombre los valores como `max_duration` y `min_duration`.

SELECT 
    MAX(length) AS max_duration_min,
    MIN(length) AS min_duration_min
FROM film;


-- 1.2. Exprese la **duración promedio de las películas en horas y minutos**. No utilice decimales.

SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours,
    FLOOR(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2. Debe obtener información relacionada con las fechas de alquiler:
-- 2.1 Calcule la **cantidad de días que la empresa ha estado operando**.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS total_days
FROM rental;

-- 2.2 Recupere la información de alquiler y agregue dos columnas adicionales para mostrar el **mes y el día de la semana del alquiler**. 
-- Devuelva 20 filas de resultados.

SELECT 
    *,
    MONTH(rental_date) AS month,
    DAYOFWEEK(rental_date) AS day
FROM rental
LIMIT 20;

-- 3. Debes asegurarte de que los clientes puedan acceder fácilmente a la información sobre la colección de películas. 
-- Para lograr esto, recupera los **títulos de las películas y su duración de alquiler**. 
-- Si algún valor de duración de alquiler es **NULL, reemplázalo** con la cadena **'Not Available'**. 
-- Ordena los resultados del título de la película en orden ascendente.

SELECT 
    title,
    COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;


-- Desafío 2

-- 1. A continuación, debe analizar las películas de la colección para obtener más información. Con la tabla `películas`, determine:
-- 1.1 El **número total de películas** que se han estrenado.

SELECT COUNT(*) AS total
FROM film;

-- 1.2 El **número de películas para cada clasificación**.

SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating;

-- 1.3 El **número de películas para cada clasificación, ordenando** los resultados en orden descendente según el número de películas.

SELECT rating, COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;


-- 2. Con la tabla `películas`, determine:
-- 2.1 La **duración media de las películas para cada clasificación** y ordene los resultados en orden descendente según la duración media. 
-- Redondee las duraciones medias a dos decimales. Esto le ayudará a identificar las duraciones de películas más populares para cada categoría.

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
ORDER BY average_duration DESC;

-- 2.2 Identifique **qué clasificaciones tienen una duración media de más de dos horas** para ayudar a seleccionar 
-- películas para los clientes que prefieren películas más largas.

SELECT 
    rating, 
    ROUND(AVG(length), 2) AS average_duration
FROM film
GROUP BY rating
HAVING average_duration > 120;
