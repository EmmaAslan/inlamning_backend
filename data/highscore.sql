------------------
-- CREATE TABLE --
------------------

CREATE TABLE game (
  id INTEGER GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(500) NOT NULL,
  genre VARCHAR(50) NOT NULL,
  image_url VARCHAR(250) NOT NULL,
  release_year SMALLINT NOT NULL,
  url_slug VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (url_slug)
);

CREATE TABLE highscore (
  id INTEGER GENERATED ALWAYS AS IDENTITY,
  game VARCHAR(50) NOT NULL,
  player_name VARCHAR(50) NOT NULL,
  score_date DATE NOT NULL,
  score BIGINT NOT NULL,
  PRIMARY KEY (id)
  -- UNIQUE (game, player_name, score, score_date)
);

CREATE TABLE game_highscore (
  game_id INTEGER NOT NULL,
  highscore_id INTEGER NOT NULL,
  PRIMARY KEY (game_id, highscore_id),
  FOREIGN KEY (game_id)
      REFERENCES game (id)
     ON DELETE CASCADE,
  FOREIGN KEY (highscore_id)
      REFERENCES highscore (id)
     ON DELETE CASCADE
);

----------------
--INSERT INTO --
----------------

INSERT INTO game (name, description, genre, image_url, release_year, url_slug) 
VALUES 
(
'Tetris', 
'In Tetris, players complete lines by moving differently shaped pieces (tetrominoes), which descend onto the playing field. The completed lines disappear and grant the player points, and the player can proceed to fill the vacated spaces. The game ends when the playing field is filled. The longer the player can delay this outcome, the higher their score will be.', 
'Puzzle', 
'https://via.placeholder.com/320x480.png', 
1987, 
'tetris'
),
(
'Pac-Man', 
'The goal is to move Pac-Man around the maze-like screen to consume lines of 240 dots and avoiding or attacking one of four hunting ghosts (sometimes called monsters).',
'Maze', 
'https://play-lh.googleusercontent.com/V-lvUzA5kK0Xw3wdg8Ct3vfIMXUX5vXYcNLPmudaZ-eyQjedYz-luqIuLmJO6KodE0Y', 
1980, 
'pac-man'
),
(
'Donkey Kong', 
'In each level the jumpman has to save Pauline, a pink-clad female character, from the giant ape Donkey Kong. Utilizing timely jumps and ladder-climbing skills, players navigated an extensive series of levels, using hammer power-ups to destroy objects and collecting bonus items along the way for additional points.', 
'Adventure', 
'https://via.placeholder.com/320x480.png', 
1981, 
'donkey-kong'
),
(
'Cabal Online', 
'Cabal Online takes place in a fictional world known as Nevareth, nearly a thousand years after its devastation by a powerful group of idealistic men, the CABAL. Hoping to turn their world into a utopia, they inadvertently fueled the forces and laws of nature to rebel against them, causing the event known as the Apocalypse. After the destruction, only eight members of the CABAL survived, including their leader, Faust.',
'Online Multiplayer',
'https://via.placeholder.com/320x480.png',
2006,
'cabal-online'
),
(
'Asteroids',
'The object of the game is to shoot and destroy the asteroids and saucers, while not colliding with either, or being hit by the saucers'' counter-fire. The game becomes harder as the number of asteroids increases.',
'Multidirectional shooter',
'https://via.placeholder.com/320x480.png',
1979,
'asteroids'
)

INSERT INTO highscore (game, player_name, score_date, score)
VALUES 
('Tetris', 'Wofflan', '2022-04-13', 874455),
('Tetris', 'Spelaren22', '2022-04-26', 776421),
('Tetris', 'AndersSON', '2022-02-18', 1874455),
('Tetris', 'GamerZ', '2022-03-26', 4452004),
('Pac-Man', 'Waffle', '2022-04-13', 8744),
('Pac-Man', 'Baffle', '2022-01-22', 8992),
('Pac-Man', 'GamerZ', '2022-04-30', 9942),
('Pac-Man', 'Waffle', '2022-03-23', 6522),
('Donkey Kong', 'Spelaren22', '2022-04-26', 771),
('Donkey Kong', 'Wofflan', '2022-03-11', 2145),
('Donkey Kong', 'Håk4N', '2022-04-01', 3771),
('Donkey Kong', 'Bertil50', '2022-01-01', 4995),
('Cabal Online', 'Baffle', '2022-04-26', 22771),
('Cabal Online', 'Wofflan', '2022-03-11', 62145),
('Cabal Online', 'Håk4N', '2022-04-01', 43771),
('Cabal Online', 'Spelaren22', '2022-01-01', 24995),
('Asteroids', 'Waffle', '2022-04-26', 422771),
('Asteroids', 'GamerZ', '2022-03-11', 862145),
('Asteroids', 'AndersSON', '2022-04-01', 543771),
('Asteroids', 'Bertil50', '2022-01-01', 124995);


INSERT INTO game_highscore (game_id, highscore_id)
VALUES 
-- ANPASSA SIFFRORNA EFTER DATA, 
-- siffra 1 = game_id
-- siffra 2 = highscore_id
-- Tetris = 1 - Pac-Man = 2 - Donkey Kong = 3 - Cabal = 4 - Asteroids = 5
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(5, 17),
(5, 18),
(5, 19),
(5, 20);


----------------
-- INNER JOIN --
----------------

-- TIPS
--ORDER BY i SELECT när jag ska sortera ut varje spels högsta highscore på sida 1
SELECT game.name as game_name,
	   highscore.game as highscore_game,
	   highscore.player_name as highscore_player_name,
	   highscore.score_date as highscore_score_date,
	   highscore.score as highscore_score
	FROM game
	INNER JOIN game_highscore
		ON game_highscore.game_id = game.id
	INNER JOIN highscore
		ON highscore.id = game_highscore.highscore_id
 WHERE game.url_slug = $1;