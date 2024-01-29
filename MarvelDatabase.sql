-- DROP EXISTING TABLES/VIEWS

DROP TABLE IF EXISTS ProjectCharacter;
DROP TABLE IF EXISTS ProjectCrewMember;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS `Character`;
DROP TABLE IF EXISTS CrewMember;
DROP TABLE IF EXISTS Universe;
DROP TABLE IF EXISTS Studio;

DROP TABLE IF EXISTS MCU;
DROP TABLE IF EXISTS MCU_Movies;
DROP TABLE IF EXISTS MCU_TV;
DROP TABLE IF EXISTS Raimiverse;
DROP TABLE IF EXISTS Webbverse;
DROP TABLE IF EXISTS `X-Men`;
DROP TABLE IF EXISTS SSU;


-- CREATE TABLES

CREATE TABLE Studio(
    Name varchar(50) PRIMARY KEY,
    DateFounded date,
    President varchar(50)
);

CREATE TABLE Universe(
    Earth varchar(6) PRIMARY KEY,
    EditorialName varchar(50) UNIQUE,
    StudioName varchar(50),
    FOREIGN KEY (StudioName) REFERENCES Studio(Name)
        ON DELETE CASCADE
);

CREATE TABLE Project(
	ID int AUTO_INCREMENT,
	TimelineOrder int,
	Title varchar(100) UNIQUE,
	ReleaseDate date,
    Released tinyint(1) NOT NULL DEFAULT 0,
    Type varchar(20),
    BoxOffice dec(12),
	`Phase` int,
	Saga varchar(20),
    UniverseEarth varchar(6) DEFAULT '199999',
    StudioName varchar(50) DEFAULT 'Marvel Studios',
    PRIMARY KEY (ID, TimelineOrder, Title),
    FOREIGN KEY (UniverseEarth) REFERENCES Universe(Earth)
        ON DELETE CASCADE,
    FOREIGN KEY (StudioName) REFERENCES Studio(Name)
        ON DELETE CASCADE
);
/*
CREATE TABLE MCU(
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    `Phase` int,
	Saga varchar(20),
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);

CREATE TABLE Film(
    ID int PRIMARY KEY AUTO_INCREMENT,
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    RunningTime int,
    BoxOffice dec(12),
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);

CREATE TABLE Series(
    ID int PRIMARY KEY AUTO_INCREMENT,
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    Episodes int,
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);

CREATE TABLE Special(
    ID int PRIMARY KEY AUTO_INCREMENT,
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    RunningTime int,
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);
*/
CREATE TABLE `Character`(
	LatestAlias varchar(50) PRIMARY KEY,
	FirstName varchar(20),
	LastName varchar(20),
	`Status` varchar(10),
    OriginUniverse varchar(6) DEFAULT '199999',
    OwningStudio varchar(50) DEFAULT 'Marvel Studios',
    FOREIGN KEY (OriginUniverse) REFERENCES Universe(Earth)
        ON DELETE CASCADE,
    FOREIGN KEY (OwningStudio) REFERENCES Studio(Name)
        ON DELETE CASCADE
);

CREATE TABLE ProjectCharacter(
    AppearanceType varchar(50),
    CharacterAlias varchar(50),
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    PRIMARY KEY (CharacterAlias, ProjectID, ProjectTimelineOrder, ProjectTitle),
    FOREIGN KEY (CharacterAlias) REFERENCES `Character`(LatestAlias)
        ON DELETE CASCADE,
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);

CREATE TABLE CrewMember(
    FirstName varchar(20),
    LastName varchar(20),
    Role varchar(20) NOT NULL,
    PRIMARY KEY (FirstName, LastName)
);

CREATE TABLE ProjectCrewMember(
    CrewMemberFirstName varchar(20),
    CrewMemberLastName varchar(20),
    ProjectID int,
    ProjectTimelineOrder int,
    ProjectTitle varchar(100),
    PRIMARY KEY (CrewMemberFirstName, CrewMemberLastName, ProjectID, ProjectTimelineOrder, ProjectTitle),
    CONSTRAINT CrewMemberName FOREIGN KEY (CrewMemberFirstName, CrewMemberLastName) REFERENCES CrewMember(FirstName, LastName)
        ON DELETE CASCADE,
    FOREIGN KEY (ProjectID, ProjectTimelineOrder, ProjectTitle) REFERENCES Project(ID, TimelineOrder, Title)
        ON DELETE CASCADE
);


-- INSERT ROWS

INSERT INTO Studio VALUES
    ('Universal Studios', 19120430, 'Peter Cramer'),
    ('20th Century Fox', 19350531, 'Steve Asbell'),
    ('Marvel Comics', 19390000, NULL),
    ('Sony Pictures', 19871221, 'Tony Vinciquerra'),
    ('Marvel Studios', 19931207, 'Kevin Feige'),
    ('Netflix', 19970829, 'Reed Hastings');

INSERT INTO Universe VALUES
    ('616', 'Prime Marvel Universe', 'Marvel Comics'),
    ('838', NULL, 'Marvel Studios'),
    ('1610', 'Ultimate Marvel Universe', 'Marvel Comics'),
    ('96283', 'Raimiverse', 'Sony Pictures'),
    ('120703', 'Webbverse', 'Sony Pictures'),
    ('199999', 'Marvel Cinematic Universe', 'Marvel Studios'),
    ('TRN414', 'Revised X-Men Cinematic Universe', '20th Century Fox'),
    ('TRN688', 'Sony\'s Spider-Man Universe', 'Sony Pictures'),
    ('TRN700', 'E-1610', 'Sony Pictures');

ALTER TABLE Project AUTO_INCREMENT = 1;

INSERT INTO Project(TimelineOrder, Title, ReleaseDate, BoxOffice) VALUES
    (3, 'Iron Man', 20080430, 585796247),
    (5, 'The Incredible Hulk', 20080613, 264770996),
    (4, 'Iron Man 2', 20100428, 623933331),
    (6, 'Thor', 20110427, 449326618),
    (1, 'Captain America: The First Avenger', 20110729, 370569774),
    (7, 'The Avengers', 20120425, 1518815515),
    (9, 'Iron Man 3', 20130424, 1214811252),
    (8, 'Thor: The Dark World', 20131030, 644783140),
    (10, 'Captain America: The Winter Soldier', 20140326, 714421503),
    (11, 'Guardians of the Galaxy', 20140731, 773350147),
    (14, 'Avengers: Age of Ultron', 20150422, 1402805868),
    (15, 'Ant-Man', 20150714, 519311965),
    (16, 'Captain America: Civil War', 20160427, 1153296293),
    (20, 'Doctor Strange', 20161025, 677718395),
    (12, 'Guardians of the Galaxy Vol. 2', 20170425, 863756051),
    (19, 'Spider-Man: Homecoming', 20170705, 880166924),
    (21, 'Thor: Ragnarok', 20171024, 853977126),
    (18, 'Black Panther', 20180213, 1347280161),
    (23, 'Avengers: Infinity War', 20180427, 2048359754),
    (22, 'Ant-Man and the Wasp', 20180704, 622674139),
    (2, 'Captain Marvel', 20190308, 1128275263),
    (24, 'Avengers: Endgame', 20190426, 2797800564),
    (29, 'Spider-Man: Far From Home', 20190702, 1131927996),
    (27, 'WandaVision', 20210115, NULL),
    (28, 'The Falcon and the Winter Soldier', 20210319, NULL),
    (25, 'Loki (Season 1)', 20210609, NULL),
    (17, 'Black Widow', 20210709, 379751655),
    (26, 'What If...? (Season 1)', 20210811, NULL),
    (30, 'Shang-Chi and the Legend of the Ten Rings', 20210903, 432243292),
    (31, 'Eternals', 20211105, 402064899),
    (34, 'Hawkeye', 20211124, NULL),
    (32, 'Spider-Man: No Way Home', 20211215, 1916306995),
    (35, 'Moon Knight', 20220330, NULL),
    (33, 'Doctor Strange in the Multiverse of Madness', 20220506, 955775804),
    (38, 'Ms. Marvel', 20220608, NULL),
    (39, 'Thor: Love and Thunder', 20220708, 760928081),
    (13, 'I Am Groot', 20220810, NULL),
    (37, 'She-Hulk: Attorney at Law', 20220818, NULL),
    (40, 'Werewolf by Night', 20221007, NULL),
    (36, 'Black Panther: Wakanda Forever', 20221111, 855070308),
    (41, 'The Guardians of the Galaxy Holiday Special', 20221125, NULL),
    (42, 'Ant-Man and the Wasp: Quantumania', 20230217, 0),
    (43, 'Secret Invasion', 20230400, NULL),
    (44, 'Guardians of the Galaxy Vol. 3', 20230505, 0),
    (45, 'Echo', 20230600, NULL),
    (46, 'Loki (Season 2)', 20230600, NULL),
    (47, 'The Marvels', 20230728, 0),
    (48, 'Ironheart', 20230900, NULL),
    (49, 'Agatha: Coven of Chaos', 20240100, NULL),
    (50, 'Daredevil: Born Again', 20240300, NULL),
    (51, 'Captain America: New World Order', 20240503, 0),
    (52, 'Thunderbolts', 20240726, 0),
    (53, 'Blade', 20240906, 0),
    (54, 'Deadpool 3', 20241108, 0),
    (55, 'Fantastic Four', 20250214, 0),
    (56, 'Avengers: The Kang Dynasty', 20250502, 0),
    (57, 'Avengers: Secret Wars', 20260501, 0);

INSERT INTO Project(ID, TimelineOrder, Title, ReleaseDate, BoxOffice, UniverseEarth, StudioName) VALUES
    (1, 1, 'Spider-Man', 20020503, 825025036, '96283', 'Sony Pictures'),
    (2, 2, 'Spider-Man 2', 20040630, 788976453, '96283', 'Sony Pictures'),
    (3, 3, 'Spider-Man 3', 20070504, 894983373, '96283', 'Sony Pictures'),
    (1, 1, 'The Amazing Spider-Man', 20120703, 757930663, '120703', 'Sony Pictures'),
    (2, 2, 'The Amazing Spider-Man 2', 20140416, 708982323, '120703', 'Sony Pictures'),
    (1, 1, 'X-Men: First Class', 20110601, 352616690, 'TRN414', '20th Century Fox'),
    (2, 2, 'X-Men: Days of Future Past', 20140520, 746045700, 'TRN414', '20th Century Fox'),
    (3, 5, 'Deadpool', 20160208, 782836791, 'TRN414', '20th Century Fox'),
    (4, 3, 'X-Men: Apocalypse', 20160518, 543934105, 'TRN414', '20th Century Fox'),
    (5, 7, 'Logan', 20170303, 619179950, 'TRN414', '20th Century Fox'),
    (6, 6, 'Deadpool 2', 20180515, 785896609, 'TRN414', '20th Century Fox'),
    (7, 4, 'Dark Phoenix', 20190605, 252442974, 'TRN414', '20th Century Fox'),
    (1, 1, 'Venom', 20181005, 856085151, 'TRN688', 'Sony Pictures'),
    (2, 2, 'Venom: Let There Be Carnage', 20210930, 506863592, 'TRN688', 'Sony Pictures'),
    (3, 3, 'Morbius', 20220330, 167460961, 'TRN688', 'Sony Pictures');

INSERT INTO `Character`(LatestAlias, FirstName, LastName, `Status`) VALUES
    ('Iron Man', 'Anthony', 'Stark', 'Deceased'),
    ('War Machine', 'James', 'Rhodes', 'Alive'),
    ('Pepper Potts', 'Virginia', 'Potts', 'Alive'),
    ('Happy Hogan', 'Harold', 'Hogan', 'Alive'),
    ('White Vision', 'Vision', NULL, 'Active'),
    ('Nick Fury', 'Nicholas', 'Fury', 'Alive'),
    ('Watcher Informant', 'Stan', 'Lee', 'Alive'),
    ('Abomination', 'Emil', 'Blonsky', 'Alive'),
    ('Thunderbolt Ross', 'Thaddeus', 'Ross', 'Alive'),
    ('Black Widow', 'Natalia', 'Romanoff', 'Deceased'),
    ('Thunder', 'Thor', 'Odinson', 'Alive'),
    ('Loki', 'Loki', 'Laufeyson', 'Deceased'),
    ('Loki (2012 Time Heist)', 'Loki', 'Laufeyson', 'Alive'),
    ('Sylvie (Variant L1190)', 'Sylvie', 'Laufeydottir', 'Alive'),
    ('Heimdall', 'Heimdall', NULL, 'Deceased'),
    ('Mighty Thor', 'Jane', 'Foster', 'Deceased'),
    ('Hawkeye', 'Clinton', 'Barton', 'Alive'),
    ('Steve Rogers', 'Steven', 'Rogers', 'Alive'),
    ('White Wolf', 'James', 'Barnes', 'Alive'),
    ('Thanos', 'Thanos', NULL, 'Deceased'),
    ('Collector', 'Taneleer', 'Tivan', 'Alive'),
    ('Captain America', 'Samuel', 'Wilson', 'Alive'),
    ('Scarlet Witch', 'Wanda', 'Maximoff', NULL),
    ('Star-Lord', 'Peter', 'Quill', 'Alive'),
    ('Rocket Racoon', '89P13', NULL, 'Alive'),
    ('Groot', 'Groot', NULL, 'Alive'),
    ('Drax the Destroyer', 'Drax', NULL, 'Alive'),
    ('Gamora', 'Gamora', 'Zen Whoberi', 'Deceased'),
    ('Gamora (2014 Time Heist)', 'Gamora', 'Zen Whoberi', 'Alive'),
    ('Nebula', 'Nebula', NULL, 'Alive'),
    ('Ultron', 'Ultron', NULL, 'Destroyed'),
    ('Ant-Man', 'Scott', 'Lang', 'Alive'),
    ('Wasp', 'Hope', 'van Dyne', 'Alive'),
    ('Hank Pym', 'Henry', 'Pym', 'Alive'),
    ('Yellowjacket', 'Darren', 'Cross', NULL),
    ('T\'Challa', 'T\'Challa', NULL, 'Deceased'),
    ('Baron Zemo', 'Helmut', 'Zemo', 'Alive'),
    ('Doctor Strange', 'Steven', 'Strange', 'Alive'),
    ('Wong', 'Wong', NULL, 'Alive'),
    ('Mantis', 'Mantis', NULL, 'Alive'),
    ('Vulture', 'Adrian', 'Toomes', 'Alive'),
    ('Black Panther', 'Shuri', NULL, 'Alive'),
    ('Midnight Angel', 'Okoye', NULL, 'Alive'),
    ('M\'Baku', 'M\'Baku', NULL, 'Alive'),
    ('Erik Killmonger', 'N\'Jadaka', NULL, 'Deceased'),
    ('Captain Marvel', 'Carol', 'Danvers', 'Alive'),
    ('Talos', 'Talos', NULL, 'Alive'),
    ('Mysterio', 'Quentin', 'Beck', 'Deceased'),
    ('J. Jonah Jameson', 'John', 'Jameson', 'Alive'),
    ('U.S. Agent', 'Johnathan', 'Walker', 'Alive'),
    ('Val', 'Valentina', 'de Fontaine', 'Alive'),
    ('Mobius', 'Mobius', 'Mobius', 'Alive'),
    ('He Who Remains', 'Nathaniel', 'Richards', 'Deceased'),
    ('Kang', 'Nathaniel', 'Richards', 'Alive'),
    ('Yelena Belova', 'Yelena', 'Belova', 'Alive'),
    ('Red Guardian', 'Alexei', 'Shostakov', 'Alive'),
    ('Taskmaster', 'Antonia', 'Dreykov', 'Alive'),
    ('The Watcher', 'Uatu', NULL, 'Alive'),
    ('Shang-Chi', 'Xu Shang-Chi', NULL, 'Alive'),
    ('Sersi', 'Sersi', NULL, 'Alive'),
    ('Blade', 'Eric', 'Brooks', 'Alive'),
    ('Kate Bishop', 'Katherine', 'Bishop', 'Alive'),
    ('Kingpin', 'Wilson', 'Fisk', 'Alive'),
    ('Daredevil', 'Matthew', 'Murdock', 'Alive'),
    ('Moon Knight', 'Marc', 'Spector', 'Alive'),
    ('America Chavez', 'America', 'Chavez', 'Alive'),
    ('Ms. Marvel', 'Kamala', 'Khan', 'Alive'),
    ('Gorr the God Butcher', 'Gorr', NULL, 'Deceased'),
    ('She-Hulk', 'Jennifer', 'Walters', 'Alive'),
    ('Werewolf by Night', 'Jack', 'Russel', 'Alive'),
    ('Namor', 'K\'uk\'ulkan', NULL, 'Alive'),
    ('Ironheart', 'Riri', 'Williams', 'Alive'),
    ('Kang the Conqueror', 'Nathaniel', 'Richards', 'Deceased'),
    ('Rama-Tut', 'Nathaniel', 'Richards', 'Alive'),
    ('Immortus', 'Nathaniel', 'Richards', 'Alive'),
    ('Scarlet Centurion', 'Nathaniel', 'Richards', 'Alive'),
    ('Mister Gryphon', 'Nathaniel', 'Richards', 'Alive'),
    ('Victor Timely', 'Nathaniel', 'Richards', 'Alive');

INSERT INTO `Character` VALUES
    ('Friendly Neighborhood Spider-Man', 'Peter', 'Parker', 'Alive', '96283', 'Sony Pictures'),
    ('Green Goblin', 'Norman', 'Osborne', 'Alive', '96283', 'Sony Pictures'),
    ('The Amazing Spider-Man', 'Peter', 'Parker', 'Alive', '120703', 'Sony Pictures'),
    ('Smart Hulk', 'Robert', 'Banner', 'Alive', '199999', 'Universal Studios'),
    ('Spider-Man', 'Peter', 'Parker', 'Alive', '199999', 'Sony Pictures'),
    ('Logan', 'James', 'Howlett', 'Deceased', 'TRN414', 'Marvel Studios'),
    ('Deadpool', 'Wade', 'Wilson', 'Alive', 'TRN414', 'Marvel Studios'),
    ('Eddie Brock', 'Edward', 'Brock', 'Alive', 'TRN688', 'Sony Pictures'),
    ('Lethal Protector', 'Venom', NULL, 'Alive', 'TRN688', 'Sony Pictures'),
    ('Riot', 'Riot', NULL, 'Deceased', 'TRN688', 'Sony Pictures'),
    ('Carnage', 'Carnage', NULL, 'Deceased', 'TRN688', 'Sony Pictures'),
    ('Morbius', 'Michael', 'Morbius', 'Alive', 'TRN688', 'Sony Pictures');

INSERT INTO ProjectCharacter(CharacterAlias, ProjectID, ProjectTimelineOrder, ProjectTitle)
    SELECT LatestAlias, ID, TimelineOrder, Title
    FROM `Character`, Project
    WHERE (
        CASE UniverseEarth
            WHEN '96283' THEN (CASE LatestAlias
                WHEN 'Watcher Informant' THEN ID IN (1, 2, 3)
                WHEN 'Friendly Neighborhood Spider-Man' THEN ID IN (1, 2, 3)
                WHEN 'Green Goblin' THEN ID IN (1, 3)
            END)
            WHEN '120703' THEN (CASE LatestAlias
                WHEN 'Watcher Informant' THEN ID IN (1, 2)
                WHEN 'The Amazing Spider-Man' THEN ID IN (1, 2)
            END)
            WHEN '199999' THEN (CASE LatestAlias
           	    WHEN 'Watcher Informant' THEN ID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22)
           	    WHEN 'Iron Man' THEN ID IN (1, 2, 3, 6, 7, 11, 13, 16, 19, 22, 23, 26, 28, 39)
           	    WHEN 'War Machine' THEN ID IN (1, 3, 7, 11, 13, 16, 19, 21, 22, 25)
                WHEN 'Pepper Potts' THEN ID IN (1, 3, 6, 7, 16, 19, 22, 28)
                WHEN 'Happy Hogan' THEN ID IN (1, 3, 7, 16, 22, 23, 28, 32)
                WHEN 'White Vision' THEN ID IN (1, 3, 6, 7, 11, 13, 16, 19, 24, 28)
                WHEN 'Nick Fury' THEN ID IN (1, 3, 4, 5, 6, 9, 11, 19, 21, 22, 23, 28)
           	    WHEN 'Smart Hulk' THEN ID IN (2, 6, 7, 11, 13, 17, 19, 21, 22, 26, 28, 29, 38, 39)
                WHEN 'Abomination' THEN ID IN (2, 29, 38)
                WHEN 'Thunderbolt Ross' THEN ID IN (2, 13, 19, 22, 27)
				WHEN 'Black Widow' THEN ID IN (3, 6, 9, 11, 13, 16, 17, 19, 21, 22, 26, 27, 28, 31, 38, 39)
				WHEN 'Thunder' THEN ID IN (4, 6, 8, 11, 14, 17, 19, 22, 26, 28, 36, 38, 39)
                WHEN 'Loki' THEN ID IN (4, 6, 8, 17, 19, 27, 28, 36)
                WHEN 'Heimdall' THEN ID IN (4, 6, 11, 17, 19, 36)
                WHEN 'Mighty Thor' THEN ID IN (4, 8, 22, 36)
           	    WHEN 'Hawkeye' THEN ID IN (4, 6, 11, 13, 16, 22, 26, 27, 28, 31, 39)
           	    WHEN 'Steve Rogers' THEN ID IN (5, 6, 8, 9, 11, 12, 13, 16, 19, 21, 22, 25, 26, 27, 28, 31, 32, 34, 35, 39)
                WHEN 'White Wolf' THEN ID IN (5, 9, 12, 13, 18, 19, 22, 25, 28)
                WHEN 'Thanos' THEN ID IN (6, 10, 11, 19, 22, 26, 28, 34, 36)
                WHEN 'Collector' THEN ID IN (8, 10, 19, 28)
                WHEN 'Captain America' THEN ID IN (9, 11, 12, 13, 19, 22, 25, 28)
                WHEN 'Scarlet Witch' THEN ID IN (9, 11, 13, 19, 22, 24, 28, 34)
                WHEN 'Star-Lord' THEN ID IN (10, 15, 19, 22, 28, 36, 37, 41)
                WHEN 'Rocket Racoon' THEN ID IN (10, 15, 19, 22, 36, 37, 41)
                WHEN 'Groot' THEN ID IN (10, 15, 19, 22, 36, 37, 41)
                WHEN 'Drax the Destroyer' THEN ID IN (10, 15, 19, 22, 36, 37, 41)
                WHEN 'Gamora' THEN ID IN (10, 15, 19, 28, 37)
                WHEN 'Nebula' THEN ID IN (10, 15, 19, 22, 28, 36, 41)
                WHEN 'Ultron' THEN ID IN (11, 28)
                WHEN 'Ant-Man' THEN ID IN (12, 13, 16, 20, 22, 28, 42)
                WHEN 'Wasp' THEN ID IN (12, 20, 22, 28, 42)
                WHEN 'Hank Pym' THEN ID IN (12, 20, 22, 28, 32, 42)
                WHEN 'M.O.D.O.K.' THEN ID IN (12, 42)
                WHEN 'T\'Challa' THEN ID IN (13, 16, 18, 19, 22, 27, 28, 40)
                WHEN 'Spider-Man' THEN ID IN (3, 13, 16, 19, 22, 23, 28, 32)
                WHEN 'Baron Zemo' THEN ID IN (13, 25)
                WHEN 'Doctor Strange' THEN ID IN (14, 17, 19, 22, 28, 34)
                WHEN 'Wong' THEN ID IN (14, 19, 22, 28, 29, 34, 38)
                WHEN 'Mantis' THEN ID IN (15, 19, 22, 36, 41)
                WHEN 'Vulture' THEN ID = 16
                WHEN 'Black Panther' THEN ID IN (18, 19, 22, 28, 40)
                WHEN 'Midnight Angel' THEN ID IN (18, 19, 22, 28, 40)
                WHEN 'M\'Baku' THEN ID IN (18, 19, 22, 28, 40)
                WHEN 'Erik Killmonger' THEN ID IN (18, 28, 40)
                WHEN 'Captain Marvel' THEN ID IN (21, 22, 28, 29, 35)
                WHEN 'Talos' THEN ID IN (21, 23)
                WHEN 'Loki (2012 Time Heist)' THEN ID IN (22, 26, 42)
                WHEN 'Gamora (2014 Time Heist)' THEN ID = 22
                WHEN 'Mysterio' THEN ID IN (23, 32)
                WHEN 'J. Jonah Jameson' THEN ID IN (23, 32)
                WHEN 'U.S. Agent' THEN ID = 25
                WHEN 'Val' THEN ID IN (25, 27, 40)
                WHEN 'Sylvie (Variant L1190)' THEN ID = 26
                WHEN 'Mobius' THEN ID IN (26, 42)
                WHEN 'He Who Remains' THEN ID = 26
                WHEN 'Kang' THEN ID = 26
                WHEN 'Yelena Belova' THEN ID IN (27, 31)
                WHEN 'Red Guardian' THEN ID = 27
                WHEN 'Taskmaster' THEN ID = 27
                WHEN 'The Watcher' THEN ID IN (28, 36)
                WHEN 'Shang-Chi' THEN ID = 29
                WHEN 'Sersi' THEN ID = 30
                WHEN 'Blade' THEN ID = 30
                WHEN 'Kate Bishop' THEN ID = 31
                WHEN 'Kingpin' THEN ID = 31
                WHEN 'Daredevil' THEN ID IN (32, 38)
                WHEN 'Green Goblin' THEN ID = 32
                WHEN 'The Amazing Spider-Man' THEN ID = 32
                WHEN 'Friendly Neighborhood Spider-Man' THEN ID = 32
           	    WHEN 'Lethal Protector' THEN ID = 32
                WHEN 'Moon Knight' THEN ID = 33
                WHEN 'America Chavez' THEN ID = 34
                WHEN 'Ms. Marvel' THEN ID = 35
                WHEN 'Gorr the God Butcher' THEN ID = 36
                WHEN 'She-Hulk' THEN ID = 38
                WHEN 'Werewolf by Night' THEN ID = 39
                WHEN 'Namor' THEN ID = 40
                WHEN 'Ironheart' THEN ID = 40
                WHEN 'Kang the Conqueror' THEN ID = 42
                WHEN 'Rama-Tut' THEN ID IN (33, 42)
                WHEN 'Immortus' THEN ID = 42
                WHEN 'Scarlet Centurion' THEN ID = 42
                WHEN 'Mister Gryphon' THEN ID = 42
                WHEN 'Victor Timely' THEN ID = 42
           	END)
           	WHEN 'TRN414' THEN (CASE LatestAlias
                WHEN 'Watcher Informant' THEN ID = 3
                WHEN 'Logan' THEN ID IN (1, 2, 4, 5, 6)
           	    WHEN 'Deadpool' THEN ID IN (3, 6)
           	END)
           	WHEN 'TRN688' THEN (CASE LatestAlias
                WHEN 'Watcher Informant' THEN ID = 1
           	    WHEN 'Lethal Protector' THEN ID IN (1, 2)
                WHEN 'J. Jonah Jameson' THEN ID = 2
                WHEN 'Spider-Man' THEN ID = 2
                WHEN 'Vulture' THEN ID = 3
           	END)
        END);

INSERT INTO CrewMember VALUES
    ('Jon', 'Favreau', 'Director'),
    ('Ramin', 'Djawadi', 'Composer'),
    ('Alan', 'Silvestri', 'Composer'),
    ('Joss', 'Whedon', 'Director'),
    ('Brian', 'Tyler', 'Composer'),
    ('Anthony', 'Russo', 'Director'),
    ('Joe', 'Russo', 'Director'),
    ('Henry', 'Jackman', 'Composer'),
    ('James', 'Gunn', 'Director'),
    ('Danny', 'Elfman', 'Composer'),
    ('Michael', 'Giacchino', 'Composer'),
    ('Ludwig', 'Göransson', 'Composer');

# cannot convert to case due to first and last names being separate
INSERT INTO ProjectCrewMember
    SELECT 'Jon', 'Favreau', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (1, 2)
    UNION
    SELECT 'Ramin', 'Djawadi', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (1, 30)
    UNION
    SELECT 'Alan', 'Silvestri', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (5, 6, 19, 22)
    UNION
    SELECT 'Joss', 'Whedon', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (6, 11)
    UNION
    SELECT 'Brian', 'Tyler', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (7, 11)
    UNION
    SELECT 'Anthony', 'Russo', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (9, 13, 19, 22)
    UNION
    SELECT 'Joe', 'Russo', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (9, 13, 19, 22)
    UNION
    SELECT 'Henry', 'Jackman', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (9, 13, 25)
    UNION
    SELECT 'James', 'Gunn', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (10, 15, 41)
    UNION
    SELECT 'Danny', 'Elfman', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '96283' AND ID IN (1, 2)
    OR UniverseEarth = '199999' AND ID IN (11, 34)
    UNION
    SELECT 'Michael', 'Giacchino', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (14, 16, 23, 32, 36, 39)
    UNION
    SELECT 'Ludwig', 'Göransson', ID, TimelineOrder, Title
    FROM Project WHERE UniverseEarth = '199999' AND ID IN (18, 40)
    OR UniverseEarth = 'TRN688' AND ID = 1;


-- UPDATE ROWS

UPDATE Project
SET Released = TRUE
WHERE ReleaseDate <= CURRENT_DATE();

UPDATE Project
SET Released = 2
WHERE ID IN (22, 23, 32);

UPDATE Project
SET Type = CASE
    WHEN BoxOffice IS NOT NULL THEN 'Film'
    WHEN BoxOffice IS NULL THEN 'Original Series'
END;

UPDATE Project
SET Type = 'Special Presentation'
WHERE ID IN (39, 41);

UPDATE Project
SET `Phase` = CASE
    WHEN YEAR(ReleaseDate) BETWEEN 2008 AND 2012 THEN 1
    WHEN YEAR(ReleaseDate) BETWEEN 2013 AND 2015 THEN 2
    WHEN YEAR(ReleaseDate) BETWEEN 2016 AND 2019 THEN 3
    WHEN YEAR(ReleaseDate) BETWEEN 2021 AND 2022 THEN 4
    WHEN YEAR(ReleaseDate) BETWEEN 2023 AND 2024 THEN 5
    WHEN YEAR(ReleaseDate) BETWEEN 2025 AND 2026 THEN 6
END
WHERE StudioName = 'Marvel Studios';

UPDATE Project
SET Saga = CASE
    WHEN `Phase` BETWEEN 1 AND 3 THEN 'Infinity'
    WHEN `Phase` BETWEEN 4 AND 6 THEN 'Multiverse'
END
WHERE StudioName = 'Marvel Studios';

UPDATE ProjectCharacter
SET AppearanceType = CASE
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Iron Man' THEN 2
        WHEN 'Nick Fury' THEN 21
    END) THEN 'Normal (Timeline Order)'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'War Machine' THEN 21
        WHEN 'Nick Fury' THEN 5
        WHEN 'Smart Hulk' THEN 21
        WHEN 'Black Widow' THEN 21
        WHEN 'Steve Rogers' THEN 21
        WHEN 'Val' THEN 27
    END) THEN 'Normal (Release Order)'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Watcher Informant' THEN 22
    END) THEN 'Past Version'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Thunder' THEN 14
        WHEN 'Steve Rogers' THEN 12
        WHEN 'White Wolf' THEN 12
    END) THEN 'Future Scene'
    WHEN (CASE CharacterAlias
        WHEN 'Iron Man' THEN ProjectID = 26
        WHEN 'War Machine' THEN ProjectID = 16
        WHEN 'White Vision' THEN ProjectID = 16
        WHEN 'Smart Hulk' THEN ProjectID IN (13, 26)
        WHEN 'Black Widow' THEN ProjectID IN (16, 17, 26)
        WHEN 'Thunder' THEN ProjectID = 26
        WHEN 'Loki' THEN ProjectID IN (26, 27)
        WHEN 'Hawkeye' THEN ProjectID IN (16, 26, 27)
        WHEN 'Steve Rogers' THEN ProjectID IN (16, 16, 27)
        WHEN 'Thanos' THEN ProjectID = 26
        WHEN 'Captain America' THEN ProjectID = 16
        WHEN 'Ant-Man' THEN ProjectID = 16
        WHEN 'T\'Challa' THEN ProjectID IN (16, 27)
        WHEN 'Mysterio' THEN ProjectID = 32
    END) THEN 'Footage'
    WHEN (CASE CharacterAlias
        WHEN 'Steve Rogers' THEN ProjectID IN (23, 29)
        WHEN 'Hank Pym' THEN ProjectID = 32
    END) THEN 'Picture'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Black Widow' THEN 31
        WHEN 'Loki' THEN 36
        WHEN 'Steve Rogers' THEN 25
        WHEN 'Thanos' THEN 36
        WHEN 'T\'Challa' THEN 40
    END) THEN 'Flashback'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Heimdall' THEN 36
        WHEN 'Erik Killmonger' THEN 40
    END) THEN 'Afterlife'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Iron Man' THEN 23
        WHEN 'Heimdall' THEN 11
        WHEN 'Steve Rogers' THEN 8
        WHEN 'Collector' THEN 19
    END) THEN 'Illusion'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Blade' THEN 30
    END) THEN 'Voice'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Steve Rogers' THEN 35
        WHEN 'Kang' THEN 26
        WHEN 'The Watcher' THEN 36
    END) THEN 'Statue'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Rama-Tut' THEN 33
    END) THEN 'Illustration'
    WHEN (CASE CharacterAlias
        WHEN 'Iron Man' THEN ProjectID = 39
        WHEN 'Smart Hulk' THEN ProjectID = 39
        WHEN 'Black Widow' THEN ProjectID = 39
        WHEN 'Thunder' THEN ProjectID = 39
        WHEN 'Hawkeye' THEN ProjectID = 39
        WHEN 'Steve Rogers' THEN ProjectID IN (31, 32, 34, 39)
    END) THEN 'Art'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Loki (2012 Time Heist)' THEN 42
        WHEN 'Mobius' THEN 42
        WHEN 'Rama-Tut' THEN 42
        WHEN 'Immortus' THEN 42
        WHEN 'Scarlet Centurion' THEN 42
        WHEN 'Mister Gryphon' THEN 42
        WHEN 'Victor Timely' THEN 42
    END) THEN 'Multiverse'
    WHEN ProjectID = (CASE CharacterAlias
        WHEN 'Vulture' THEN 3
    END) THEN 'Multiversal Entrance'
    WHEN (ProjectID = 28 AND CharacterAlias <> 'The Watcher')
    OR ProjectID = (CASE CharacterAlias
        WHEN 'Thanos' THEN 34
    END) THEN 'Multiversal Variant'
    ELSE 'Normal'
END;
# WHERE AppearanceType IS NULL;

            # continue appearances


-- CREATE VIEWS

CREATE OR REPLACE VIEW MCU AS
SELECT * FROM Project
WHERE StudioName = 'Marvel Studios';

CREATE OR REPLACE VIEW MCU_Movies AS
SELECT ID, TimelineOrder, Title, YEAR(ReleaseDate) AS ReleaseYear, Released, FORMAT(BoxOffice, 0) AS BoxOffice, `Phase`, Saga, StudioName
FROM MCU
WHERE Type = 'Film';

CREATE OR REPLACE VIEW MCU_TV AS
SELECT ID, TimelineOrder, Title, YEAR(ReleaseDate) AS ReleaseYear, Released, Type, `Phase`, Saga, StudioName
FROM MCU
WHERE Type <> 'Film';

CREATE OR REPLACE VIEW Raimiverse AS
SELECT ID, TimelineOrder, Title, ReleaseDate, StudioName
FROM Project
WHERE UniverseEarth = '96283';

CREATE OR REPLACE VIEW Webbverse AS
SELECT ID, TimelineOrder, Title, ReleaseDate, StudioName
FROM Project
WHERE UniverseEarth = '120703';

CREATE OR REPLACE VIEW `X-Men` AS
SELECT ID, TimelineOrder, Title, ReleaseDate, StudioName
FROM Project
WHERE UniverseEarth = 'TRN414';

CREATE OR REPLACE VIEW SSU AS
SELECT ID, TimelineOrder, Title, ReleaseDate, StudioName
FROM Project
WHERE UniverseEarth = 'TRN688';


-- SINGLE-TABLE QUERIES

-- (1) Characters that are currently alive or active in the MCU.
SELECT LatestAlias, FirstName, LastName, `Status`
FROM `Character`
WHERE OriginUniverse = '199999'
AND `Status` LIKE 'A%ive'
ORDER BY `Status`;

-- (2) Crew members with first/last name beginning with 'J'.
SELECT DISTINCT *
FROM CrewMember
WHERE FirstName LIKE 'J%'
OR LastName LIKE 'J%'
ORDER BY Role DESC, LastName;

-- (3) Non-MCU projects from 2012-2021.
SELECT Title, ReleaseDate
FROM Project
WHERE ReleaseDate BETWEEN 2012 AND 2021
AND `Phase` IS NULL
AND Saga IS NULL
ORDER BY ReleaseDate;

-- (4) Multiversal character appearances by project.
SELECT ProjectTitle, COUNT(*) AS NumAppearances
FROM ProjectCharacter
WHERE AppearanceType = 'Multiversal'
GROUP BY ProjectTitle;

-- (5) Crew members with 2+ projects.
SELECT CrewMemberFirstName, CrewMemberLastName, COUNT(*) AS NumProjects
FROM ProjectCrewMember
GROUP BY CrewMemberFirstName, CrewMemberLastName
HAVING NumProjects > 2
ORDER BY NumProjects, CrewMemberLastName;

-- (6) Box ofice earnings of film franchises.
SELECT CASE
    WHEN Title LIKE '%Spider-Man%' THEN 'Spider-Man'
    WHEN Title LIKE '%Avengers%' THEN 'Avengers'
    WHEN Title LIKE 'Iron Man%' THEN 'Iron Man'
    WHEN Title LIKE 'Thor%' THEN 'Thor'
    WHEN Title LIKE 'Captain America%' THEN 'Captain America'
    WHEN Title LIKE 'Guardians%' THEN 'Guardians of the Galaxy'
    WHEN Title LIKE 'Deadpool%' THEN 'Deadpool'
    WHEN Title LIKE 'Ant-Man%' THEN 'Ant-Man'
    WHEN Title LIKE 'Black Panther%' THEN 'Black Panther'
    WHEN Title LIKE 'Doctor Strange%' THEN 'Doctor Strange'
    ELSE CASE
        WHEN UniverseEarth = '199999' THEN 'Other MCU'
        WHEN UniverseEarth = 'TRN414' THEN 'X-Men (Revised)'
        WHEN UniverseEarth = 'TRN688' THEN 'SSU'
    END
END AS Franchise, FORMAT(SUM(BoxOffice), 0) AS TotalBoxOffice, StudioName
FROM Project
WHERE BoxOffice IS NOT NULL
GROUP BY Franchise
ORDER BY ReleaseDate, ID;


-- MULTI-TABLE QUERIES

-- (1) Release years and crew members of post-phase 1 projects that made less than $800 million.
SELECT DISTINCT ReleaseDate, CrewMemberFirstName, CrewMemberLastName
FROM Project p, ProjectCrewMember c
WHERE p.Title = c.ProjectTitle
AND p.BoxOffice < 800000000
AND p.Phase > 1;

-- (2) Studios that have created or own a cinematic universe.
SELECT Name, President, (
    SELECT COUNT(*)
    FROM Project p
    WHERE p.StudioName = s.Name
) AS NumProjects
FROM Studio s
WHERE Name IN (
    SELECT StudioName
    FROM Universe
    WHERE Earth IN ('96283', '120703', '199999', 'TRN414', 'TRN688')
)
ORDER BY DateFounded;

-- (3) Directors and their movies.
SELECT CONCAT_WS(' ', c.FirstName, c.LastName) AS Director, d.ProjectTitle
FROM ProjectCrewMember d
JOIN CrewMember c
ON d.CrewMemberFirstName = c.FirstName AND d.CrewMemberLastName = c.LastName
WHERE c.Role = 'Director'
ORDER BY d.ProjectID;

-- (4) Range of box office earnings and highest grossing character for each MCU phase.
SELECT p.Phase, p.Saga, FORMAT(MIN(p.BoxOffice), 0) AS MinBoxOffice, FORMAT(AVG(p.BoxOffice), 0) AS AvgBoxOffice, FORMAT(MAX(p.BoxOffice), 0) AS MaxBoxOffice, a.CharacterAlias AS HighestGrossingCharacter
FROM Project p
JOIN ProjectCharacter a ON p.ID = a.ProjectID AND p.TimelineOrder = a.ProjectTimelineOrder AND p.Title = a.ProjectTitle
WHERE p.UniverseEarth = '199999'
GROUP BY p.Phase
ORDER BY `Phase`, SUM(p.BoxOffice) DESC;

-- (5) Box office earnings for characters with less than 10 appearances.
SELECT a.CharacterAlias, COUNT(*) AS NumAppearances, FORMAT(SUM(BoxOffice), 0) AS TotalBoxOffice, u.EditorialName AS CinematicUniverse
FROM ProjectCharacter a
LEFT JOIN Project p
ON a.ProjectID = p.ID AND a.ProjectTimelineOrder = p.TimelineOrder AND a.ProjectTitle = p.Title
JOIN Universe u
ON p.UniverseEarth = u.Earth
GROUP BY a.CharacterAlias, CinematicUniverse
HAVING NumAppearances < 10
ORDER BY p.ReleaseDate;

-- (6) The major MCU team-up films so far with the status of appearing characters.
SELECT p.Title AS MajorTeamUpFilm, p.ReleaseDate, FORMAT(p.BoxOffice, 0) AS BoxOffice, c.LatestAlias AS CharacterName, c.`Status`, u.EditorialName AS CharacterOriginUniverse
FROM Project p
JOIN ProjectCharacter a ON p.ID = a.ProjectID AND p.TimelineOrder = a.ProjectTimelineOrder AND p.Title = a.ProjectTitle
JOIN `Character` c ON a.CharacterAlias = c.LatestAlias
JOIN Universe u ON c.OriginUniverse = u.Earth
WHERE p.UniverseEarth = '199999'
AND p.ID IN (6, 11, 13, 19, 22, 32)
ORDER BY p.ID DESC;