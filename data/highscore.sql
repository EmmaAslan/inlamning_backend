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
  game_id INTEGER NOT NULL,
  player_name VARCHAR(50) NOT NULL,
  score_date DATE NOT NULL,
  score BIGINT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (game_id)
	  REFERENCES game (id)
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
);


INSERT INTO highscore (game_id, player_name, score_date, score)
VALUES 
(1, 'Wofflan', '2022-04-13', 874455),
(1, 'Spelaren22', '2022-04-26', 776421),
(1, 'AndersSON', '2022-02-18', 1874455),
(1, 'GamerZ', '2022-03-26', 4452004),
(2, 'Waffle', '2022-04-13', 8744),
(2, 'Baffle', '2022-01-22', 8992),
(2, 'GamerZ', '2022-04-30', 9942),
(2, 'Waffle', '2022-03-23', 6522),
(3, 'Spelaren22', '2022-04-26', 771),
(3, 'Wofflan', '2022-03-11', 2145),
(3, 'H??k4N', '2022-04-01', 3771),
(3, 'Bertil50', '2022-01-01', 4995),
(4, 'Baffle', '2022-04-26', 22771),
(4, 'Wofflan', '2022-03-11', 62145),
(4, 'H??k4N', '2022-04-01', 43771),
(4, 'Spelaren22', '2022-01-01', 24995),
(5, 'Waffle', '2022-04-26', 422771),
(5, 'GamerZ', '2022-03-11', 862145),
(5, 'AndersSON', '2022-04-01', 543771),
(5, 'Bertil50', '2022-01-01', 124995);