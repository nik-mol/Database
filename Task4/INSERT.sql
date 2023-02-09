INSERT INTO Perfomer (name) VALUES 
	('Nikolay Mold'),
	('Olesya Mold'),
	('Andrey'),
	('Vadim Dub'),
	('Natalya Dub'),
	('Olga Ryx'),
	('Alexandr'),
	('Viktorya');	

INSERT INTO Genre (name) VALUES 
	('Rock'),
	('Pop'),
	('Drive'),
	('Rep'),
	('Trance');		

INSERT INTO Album (name, year) VALUES 
	('Album1', 2018),
	('Album2', 2017),
	('Album3', 2020),
	('Album4', 2000),
	('Album5', 2010),
	('Album6', 1990),
	('Album7', 2018),
	('Album8', 2022);


INSERT INTO Track (name, album_id, length) VALUES 
	('Track1', 3, '00:02:45'),
	('Track2', 5, '00:03:45'),
	('Track3', 4, '00:02:20'),
	('Track4', 1, '00:02:15'),
	('Track5', 7, '00:04:45'),
	('Track6', 5, '00:02:10'),
	('Track7 my', 2, '00:02:22'),
	('Track8', 5, '00:05:10'),
	('Track9', 6, '00:02:00'),
	('Track10', 7, '00:02:40'),
	('Track11', 8, '00:02:50'),
	('Track12 my', 1, '00:01:10'),
	('Track13', 2, '00:02:12'),
	('Track14', 4, '00:06:10'),
	('Track15', 6, '00:02:10');


INSERT INTO Сompilation (name, year) VALUES 
	('Best', 2018),
	('Worse', 2017),
	('Retro2020', 2020),
	('Retro2000', 2000),
	('Retro2010', 2010),
	('Retro1990', 1990),
	('Retro1980', 1980),
	('Hit', 2022);


INSERT INTO Perfomer_Genre (perfomer_id, genre_id) VALUES 
	(1, 2),
	(2, 4),
	(5, 1),
	(3, 5),
	(6, 3),
	(4, 1),
	(7, 4),
	(8, 1);


INSERT INTO Perfomer_Album (perfomer_id, album_id) VALUES 
	(1, 2),
	(2, 4),
	(5, 1),
	(3, 5),
	(6, 3),
	(4, 6),
	(7, 7),
	(8, 8);


INSERT INTO Сompilation_Track (compilation_id, track_id) VALUES 
	(1, 1),
	(2, 2),
	(5, 3),
	(3, 4),
	(6, 5),
	(4, 6),
	(7, 7),
	(8, 8),
	(1, 9),
	(2, 10),
	(5, 11),
	(3, 12),
	(6, 13),
	(4, 14),
	(7, 15);

INSERT INTO perfomer_genre (perfomer_id, genre_id) VALUES 
	(1, 3),
	(2, 5),
	(5, 2);

INSERT INTO Track (name, album_id, length) VALUES 
	('Track16', 3, '00:02:45'),
	('Track17', 5, '00:03:45'),
	('Track18', 4, '00:02:20');