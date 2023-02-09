-- Альбомы, вышедшие в 2018 году
SELECT name, year FROM Album
	WHERE year = 2018;

--Название и продолжительность самого длительного трека
SELECT name, length FROM Track
	ORDER BY length DESC  
	LIMIT 1;

--Название трэков не менее 3,5 минут
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