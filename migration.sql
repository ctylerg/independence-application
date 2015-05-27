
CREATE DATABASE march_madness;
\c march_madness
CREATE TABLE teams(id SERIAL PRIMARY KEY, name VARCHAR(255));

CREATE TABLE games(id SERIAL PRIMARY KEY, score INTEGER, season_id INTEGER, teams_a_id INTEGER, teams_b_id INTEGER);

CREATE TABLE seasons(id SERIAL PRIMARY KEY, year INTEGER);

###CREATE TABLE ranks(id SERIAL PRIMARY KEY, region VARCHAR(255), team_id(INTEGER), season_id(INTEGER), seed(INTEGER));
