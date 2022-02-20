drop schema if exists projectschema cascade;
create schema projectschema;
set search_path to projectschema;

-- A tuple in this relation represents a team that competed in the tournament, where tName is the name of a Team.
DROP TABLE IF EXISTS Team cascade;
Create Table Team(
	tName TEXT,
	Primary key (tName)
);

-- A tuple in this relation represents a player that competed in the tournament, where pName is the name of the Player, and tName is the name of the team that Player belongs to.
DROP TABLE IF EXISTS Player cascade;
Create Table Player(
	pName TEXT,
	tName TEXT NOT NULL,
	Primary key (pName),
	foreign key (tName) references Team(tName)
);

-- A tuple in this relation represents a match that occurred in the tournament, and various details about its results, where matchID is a unique identifier, redTeam is name of the team that played the red position in this match, blueTeam is the name of the team that played the blue position in this match, winner is the name of the team that won this match, length is the duration of time this match lasted in minutes, fDragT is the time the first dragon in this match was slain, fBloodT is the time of the first blood, fTowerT is the time the first tower was destroyed, and fBaronT is the time the first Baron was slain.
DROP TABLE IF EXISTS Match cascade;
Create Table Match(
	matchID INTEGER,
	redTeam TEXT NOT NULL,
	blueTeam TEXT NOT NULL,
	winner TEXT NOT NULL,
	length FLOAT NOT NULL,
	fDragT FLOAT NOT NULL,
	fBloodT FLOAT NOT NULL,
	fTowerT FLOAT NOT NULL,
	fBaronT FLOAT,
	PRIMARY KEY (matchID),
	foreign key(redTeam) references Team(tName),
	foreign key(blueTeam) references Team(tName),
	foreign key(winner) references Team(tName)
);

-- A tuple in this relation represents the total number of matches that a Champion accumulated over the course of the tournament, based on the side of the map, match time durations, and overall where champID is a unique identifier for the champion, cName is the name of the champion, total is the total number of matches where the champion was used, totalBlue was the total number of matches where teams that started on the blue side of the match used this champion, totalBlue was the total number of matches where teams that started on the red side of the match used this champion, and totalX represent the total number of matches where the champion was used, where the champion was used for X amount of time. LT25 indicates less than 25 minutes, 25T30 is 25-30 minutes, 30T35 is 30-35 minutes, 35T40 is 35-40 minutes, 40T45 is 40-45 minutes, and GT45 is greater than 45 minutes.
DROP TABLE IF EXISTS Champion cascade;
Create Table Champion(
   champID INTEGER,
   cName TEXT NOT NULL,
   total INTEGER NOT NULL,
   totalBlue INTEGER NOT NULL,
   totalRed INTEGER NOT NULL,
   totalLT25 INTEGER NOT NULL,
   total25T30 INTEGER NOT NULL,
   total30T35 INTEGER NOT NULL,
   total35T40 INTEGER NOT NULL,
   total40T45 INTEGER NOT NULL,
   totalGT45  INTEGER NOT NULL,
   Primary key (champID)
);



-- A tuple in this relation represents the performance of a player in a particular match, giving various statistics about their performance as an individual and if they achieved certain milestones first.
-- matchID: The unique identification number of the match
-- tName: The name of the team that this player belongs to
-- champID: The unique identification number of the Champion the player was using in the match
-- position: the position of the player in the match
-- mvp: whether the player is the MVP of the match
-- kills: The total kills in the match for the player
-- deaths: The total deaths in the match for the player
-- assists: The total assists in the match for the player
-- fBlood: A boolean representing whether the player got the first kill of the match
-- fBVictim: A boolean representing whether the player was the first death of the match
 DROP TABLE IF EXISTS PlayerPerformance cascade;
Create Table PlayerPerformance(
	matchID INTEGER NOT NULL,
	pName TEXT NOT NULL,
	tName TEXT NOT NULL,
	champID INTEGER NOT NULL,
	position TEXT NOT NULL,
	mvp BOOL NOT NULL,
	kills INTEGER NOT NULL,
	deaths INTEGER NOT NULL,
	assists INTEGER NOT NULL,
	fBlood BOOL NOT NULL,
	fBVictim BOOL NOT NULL,
	Primary key (matchID, pName),
	Foreign key (matchID) references Match(matchID),
	Foreign key (pName) references Player(pName),
	Foreign key (tName) references Team(tName),
	Foreign key (champID) references Champion(champID)
);

-- A tuple in this relation represents the performance of a team in a particular match.
-- matchID: The unique identification number for the match
-- tName: The name of the team
-- tKills: The total kills in the match for the team
-- tDeaths: The total deaths in the match for the team
-- tDragK: The total dragon kills in the match for the team
-- tBaronK: The total baron kills in the match for the team
-- fTBlood: Whether the team had first blood
-- fTower: Whether the team destroyed the first tower
-- fBaron: Whether the team killed the first baron
DROP TABLE IF EXISTS TeamPerformance cascade;
Create Table TeamPerformance(
   matchID INTEGER,
   tName TEXT,
   tKills INTEGER NOT NULL,
   tDeaths INTEGER NOT NULL,
   tDragK INTEGER NOT NULL,
   tBaronK INTEGER NOT NULL,
   fTBlood BOOL NOT NULL,
   fTower BOOL NOT NULL,
   fBaron BOOL,
   Primary key (matchID, tName),
   Foreign key (matchID) references Match(matchID),
   Foreign key (tName) references Team(tName)
);


-- A tuple in this relation represents various total win rates that a Champion accumulated
-- over the course of the tournament, based on the side of the map, various  time durations, and overall.
-- champID: A unique identification number for the champion
-- wRTotal: The total win rate of matches in the tournament where the champion was used
-- wRBlue: The total win rate of matches in the tournament where the champion was used by the team starting on the blue side of the map
-- wRRed: The total win rate of matches in the tournament where the champion was used by the team starting on the red side of the map
-- wRLT25: The total win rate of matches in the tournament in which the champion was used that lasted less than 25 minutes
-- wR25T30: The total win rate of matches in the tournament in which the champion was used that lasted between 25 and 30 minutes
-- wR30T35: The total win rate of matches in the tournament in which the champion was used that lasted between 30 and 35 minutes
-- wR35T40: The total win rate of matches in the tournament in which the champion was used that lasted between 35 and 40 minutes
-- wR40T45: The total win rate of matches in the tournament in which the champion was used that lasted between 40 and 45 minutes
-- wRGT45 The total win rate of matches in the tournament in which the champion was used that lasted more than 45 minutes
DROP TABLE IF EXISTS WinRate cascade;
Create Table WinRate(
   champID INTEGER,
   wRTotal FLOAT NOT NULL,
   wRBlue FLOAT NOT NULL,
   wRRed FLOAT NOT NULL,
   wRLT25 FLOAT NOT NULL,
   wR25T30 FLOAT NOT NULL,
   wR30T35 FLOAT NOT NULL,
   wR35T40 FLOAT NOT NULL,
   wR40T45 FLOAT NOT NULL,
   wRGT45 FLOAT NOT NULL,
   Primary key (champID),
   Foreign key (champID) references Champion(champID)
);
