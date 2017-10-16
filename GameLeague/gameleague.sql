   
-- CREATE YOUR TABLES HERE

CREATE TABLE Player (
	id INT,
	handle TEXT
);

CREATE TABLE Game ( 
	id INT,
	name TEXT
);

CREATE TABLE HighScore (
	id INT,
	game INT,
	player INT,
	score INT
);

CREATE TABLE Guild (
	id INT,
	name TEXT,
	game INT
);

CREATE TABLE GuildMembership (
	id INT,
	guild INT,
	player INT,
	role INT
);

CREATE TABLE Following (
	id INT,
	player INT,
	follow INT
);

-- DO YOUR INSERTS HERE

-- create players
INSERT INTO Player VALUES(1, 'kittens27');
INSERT INTO Player VALUES(2, 'thelolcat');
INSERT INTO Player VALUES(3, 'harveykeitel16');
INSERT INTO Player VALUES(4, 'pluto');
-- create games
INSERT INTO Game VALUES(1, 'Another Moba');
INSERT INTO Game VALUES(2, 'Open World Walking');
-- create high scores
INSERT INTO HighScore VALUES(1, 1, 1, 999);
INSERT INTO HighScore VALUES(2, 1, 2, 1000);
INSERT INTO HighScore VALUES(3, 1, 3, 852);
INSERT INTO HighScore VALUES(4, 1, 4, 311);
INSERT INTO HighScore VALUES(5, 2, 1, 12345);
INSERT INTO HighScore VALUES(6, 2, 2, 110);
INSERT INTO HighScore VALUES(7, 2, 4, 23456);
-- create guilds
INSERT INTO Guild VALUES(1, 'lolcatz', 1);
INSERT INTO Guild VALUES(2, 'thedawgs', 1);
INSERT INTO Guild VALUES(3, 'nightelfmohawks', 2);
INSERT INTO Guild VALUES(4, 'corruptedbloodincident', 2);

INSERT INTO GuildMembership VALUES(1, 1, 1, 'member');
INSERT INTO GuildMembership VALUES(2, 1, 2, 'leader');
INSERT INTO GuildMembership VALUES(3, 2, 3, 'member');
INSERT INTO GuildMembership VALUES(4, 2, 4, 'leader');
INSERT INTO GuildMembership VALUES(5, 3, 1, 'leader');
INSERT INTO GuildMembership VALUES(6, 4, 2, 'member');
INSERT INTO GuildMembership VALUES(7, 3, 3, 'member');
INSERT INTO GuildMembership VALUES(8, 4, 4, 'member');

-- create followings
INSERT INTO Following VALUES(1, 1, 2);
INSERT INTO Following VALUES(2, 1, 4);
INSERT INTO Following VALUES(3, 2, 1);
INSERT INTO Following VALUES(4, 2, 3);
INSERT INTO Following VALUES(5, 2, 4);
INSERT INTO Following VALUES(6, 3, 4);

-- Write your queries below the print statements
-- Please keep these settings
.echo off
.headers on
.width 25 25 25
.mode column
--

-- DONE: All player handles
SELECT handle FROM Player;
-- DONE: All game names
SELECT name FROM Game;
-- DONE: All guilds and their game, sorted by game name
SELECT Guild.name, Game.name 
	FROM Guild, Game
	WHERE Guild.game = Game.id 
	ORDER BY Game.name ASC;
-- DONE: List the Top 3 high scores and players handles for Another Moba, ranked by highest score
SELECT HighScore.score, Player.handle FROM Player, HighScore, Game
	WHERE Player.id=HighScore.player AND Game.id=HighScore.game AND Game.name='Another Moba'
 	ORDER BY HighScore.score DESC LIMIT 3;
-- DONE: List all high scores and players handles for Open World Walking, ranked by highest score. Do NOT show any players who do NOT have a high score.
SELECT HighScore.score, Player.handle FROM Player, HighScore, Game 
	WHERE Game.name='Open World Walking' AND HighScore.game=Game.id AND Player.id=HighScore.player
	ORDER BY HighScore.score DESC;
-- DONE: List the name, high score, and guild name of guild leaders in Open World Walking, ranked by score
SELECT HighScore.score, Player.handle, Guild.name 
	FROM Player, HighScore, GuildMembership, Guild, Game
	WHERE GuildMembership.role = 'leader'
		AND Guild.id = GuildMembership.guild
		AND Game.name = 'Open World Walking'
		AND Guild.game = Game.id
		AND Player.id = GuildMembership.player
		AND HighScore.player = Player.id
		AND HighScore.game = Game.id
	ORDER BY HighScore.score DESC;
-- List the followers of pluto, alphabetically
SELECT Player.handle 
	FROM Following,Player 
	WHERE Following.follow=
		(SELECT Player.id 
		FROM Player 
		WHERE Player.handle='pluto') 
	AND Following.player=Player.id 
	ORDER BY Player.handle ASC;

-- List the followers of Pluto who also play Open World Walking, alphabetically
SELECT Player.handle
        FROM Following,Player,Game,HighScore
        WHERE Following.follow=
                (SELECT Player.id
                FROM Player
                WHERE Player.handle='pluto')
        AND Following.player=Player.id
	AND HighScore.player=Player.id
	AND Game.name='Open World Walking'
	AND HighScore.game=Game.id
        ORDER BY Player.handle ASC;
