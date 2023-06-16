CREATE DATABASE IF NOT EXISTS dota2;

USE dota2;

CREATE TABLE IF NOT EXISTS dota2.heroes(
	id INT NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
)
COMMENT "This table stores Heros Informations";

CREATE TABLE IF NOT EXISTS dota2.region(
	id INT NOT NULL UNIQUE PRIMARY KEY,
    `name` VARCHAR(255) UNIQUE NOT NULL
)
COMMENT "This table stores Regions Names";

CREATE TABLE IF NOT EXISTS dota2.game_mode(
	id INT NOT NULL UNIQUE PRIMARY KEY,
	`name` VARCHAR(255) UNIQUE NOT NULL,
    balanced BOOL
)
COMMENT "This table stores Game Modes informations";

CREATE TABLE IF NOT EXISTS dota2.teams(
	id INT NOT NULL UNIQUE PRIMARY KEY,
    `name` VARCHAR(255) UNIQUE NOT NULL,
    win INT,
    losses INT
)
COMMENT "This table stores Professional Teams informations";

CREATE TABLE IF NOT EXISTS dota2.team_players(
	account_id INT NOT NULL UNIQUE PRIMARY KEY,
	team_id INT NOT NULL,
    player_name VARCHAR (255) UNIQUE,
    games_player INT,
    win INT,
    current_team_member BOOL NOT NULL,

	FOREIGN KEY (team_id) REFERENCES teams(id)
)
COMMENT "This table stores Players informations relationated to a team";

CREATE TABLE IF NOT EXISTS dota2.players(
	account_id INT UNIQUE NOT NULL,
	solo_competitive_rank INT,
    competitive_rank INT,
    location_country_code VARCHAR(255),
	rank_tier INT,
    mmr_estimate INT,    

	FOREIGN KEY (account_id) REFERENCES team_players(account_id)
)
COMMENT "This table stores players accounts informations";

CREATE TABLE IF NOT EXISTS dota2.matches(
	id VARCHAR(255) UNIQUE NOT NULL PRIMARY KEY,
	game_id INT NOT NULL,
    barracks_status_dire INT,
    barracks_status_radiant INT,
    dire_score INT,
    radiant_score INT,
    radiant_gold_adv INT,
    tower_status_dire INT,
    tower_status_radiant INT,
    
    FOREIGN KEY (game_id) REFERENCES game_mode(id)
)
COMMENT "Thias table stores matches' results";

CREATE TABLE IF NOT EXISTS dota2.matches_player(
	match_id VARCHAR(255) NOT NULL,
    account_id INT NOT NULL,
	hero_id INT NOT NULL,
	game_id INT,
    player_slot INT,
    radiant_win BOOL,
    duration INT,
    kills INT,
    deaths INT,
    assists INT,
    average_rank DECIMAL (10,2),
    
    FOREIGN KEY (match_id) REFERENCES matches(id),
	FOREIGN KEY (account_id) REFERENCES team_players(account_id),
    FOREIGN KEY (hero_id) REFERENCES heroes(id),
    FOREIGN KEY (game_id) REFERENCES game_mode (id)
)

COMMENT "This table stores players matches results";

