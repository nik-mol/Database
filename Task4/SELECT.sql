-- Альбомы, вышедшие в 2018 году
SELECT name, year FROM Album
	WHERE year = 2018;

--Название и продолжительность самого длительного трека
SELECT name, length FROM Track
	ORDER BY length DESC  
	LIMIT 1;

-- Название трэков не менее 3,5 минут
SELECT name FROM Track
	WHERE length >= '00:03:30';

--Название сборников с 2018 по 2020 год включительно
SELECT name FROM Сompilation 
	WHERE year BETWEEN 2018 AND 2020;

--Исполнители из одного слова
SELECT name FROM Perfomer
	WHERE name NOT LIKE '% %';

--Название треков, содержащих "my"
SELECT name FROM Track
	WHERE name LIKE '%my%';

-- ------------------------------Task4-------------------------------------------------

--Количество исполнителей в каждом жанре
SELECT g.name, COUNT(pg.perfomer_id) AS count_perfomer
  FROM genre g 
 	   INNER JOIN perfomer_genre pg  
 	   ON g.id = pg.genre_id
 GROUP BY g.name
 ORDER BY count_perfomer;

--Количество треков, вошедших в альбомы 2019-2020 годов
SELECT COUNT(t.id) AS count_track
  FROM track t
  	   INNER JOIN album a 
  	   ON t.album_id = a.id 
 WHERE a."year" BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому
SELECT a."name" , AVG(t.length) AS avg_track
  FROM album a 
  	   INNER JOIN track t
  	   ON a.id = t.album_id
 GROUP BY a."name"
 ORDER BY avg_track;

--Все исполнители, которые не выпустили альбомы в 2020 году
SELECT p."name" 
  FROM perfomer p 
	   INNER JOIN perfomer_album pa  
	   ON p.id  = pa.perfomer_id
	   INNER JOIN album a
	   ON a.id = pa.album_id
 WHERE a."year" != 2020;

--Названия сборников, в которых присутствует конкретный исполнитель (Nikolay Mold)
SELECT c."name" 
  FROM compilation c 
  	   JOIN compilation_track ct ON c.id  = ct.track_id
  	   JOIN track t ON ct.track_id = t.id
  	   JOIN album a ON t.album_id = a.id
  	   JOIN perfomer_album pa ON pa.album_id = a.id
  	   JOIN perfomer p ON p.id = pa.perfomer_id 
  	  		AND p."name" = 'Nikolay Mold';

--Название альбомов, в которых присутствуют исполнители более 1 жанра
--1-й вариант
 WITH number_info AS (
	SELECT  a."name", COUNT(g."name") AS count_g_name
	  FROM album a 
	  	   JOIN perfomer_album pa ON pa.album_id = a.id
	  	   JOIN perfomer p ON p.id = pa.perfomer_id
	  	   JOIN perfomer_genre pg ON pg.perfomer_id  = p.id 
	  	   JOIN genre g ON g.id = pg.genre_id
	 GROUP BY a.name)	  	   
SELECT name FROM number_info
 WHERE count_g_name > 1;
--2-й вариант
SELECT  a."name", COUNT( DISTINCT g."name")
  FROM album a 
  	   JOIN perfomer_album pa ON pa.album_id = a.id
  	   JOIN perfomer p ON p.id = pa.perfomer_id
  	   JOIN perfomer_genre pg ON pg.perfomer_id  = p.id 
  	   JOIN genre g ON g.id = pg.genre_id
 GROUP BY a."name"
HAVING COUNT( DISTINCT g."name") > 1; 

--Наименование треков, которые не входят в сборники
SELECT t."name"
  FROM track t 
       LEFT JOIN compilation_track ct ON t.id = ct.track_id
 WHERE ct.track_id IS NULL;

--Исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
SELECT p."name"
  FROM perfomer p 
       JOIN perfomer_album pa ON pa.perfomer_id = p.id 
       JOIN album a ON a.id = pa.album_id 
       JOIN track t ON t.album_id  = a.id
 WHERE t.length = (SELECT MIN(length) FROM track);
     
-- Название альбомов, содержащих наименьшее количество треков
WITH album_track AS (
	SELECT a."name", COUNT(t."name") AS count_track
	  FROM album a 
	       JOIN track t ON t.album_id = a.id 
	 GROUP BY a."name")
SELECT name , count_track
  FROM album_track
 WHERE count_track = (SELECT MIN(count_track) FROM album_track);