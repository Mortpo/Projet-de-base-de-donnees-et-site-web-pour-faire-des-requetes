DROP DATABASE IF EXISTS ubisoft;
CREATE DATABASE ubisoft;
USE ubisoft;

CREATE TABLE IF NOT EXISTS Jeu( 
       id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
       titre_du_jeu VARCHAR(40) UNIQUE NOT NULL, 
       annee_de_sortie INT(4) NOT NULL, 
       directeur_du_jeu VARCHAR(40) NOT NULL, 
       nom_de_la_franchise VARCHAR(30)
) ENGINE=INNODB; 

LOAD DATA LOCAL INFILE 'jeu.csv' 
INTO TABLE Jeu 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id,titre_du_jeu,annee_de_sortie,directeur_du_jeu,nom_de_la_franchise);

CREATE TABLE IF NOT EXISTS Genre( 
    genre VARCHAR(40) UNIQUE NOT NULL, 
       PRIMARY KEY (genre) 
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'genre.csv' 
INTO TABLE Genre 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(genre);

CREATE TABLE IF NOT EXISTS Genrejeu( 
       id_jeu SMALLINT UNSIGNED NOT NULL,
       genre_jeu VARCHAR(40) NOT NULL,
       
       CONSTRAINT fk_genre_genrejeu
        FOREIGN KEY (genre_jeu)
        REFERENCES Genre(genre),

       CONSTRAINT fk_jeu_id_jeu
        FOREIGN KEY (id_jeu)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'genrejeu.csv' 
INTO TABLE Genrejeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id_jeu, genre_jeu);

CREATE TABLE IF NOT EXISTS NomDLC(
       id_jeu_DLC SMALLINT UNSIGNED NOT NULL,
       nomDLC VARCHAR(40) NOT NULL PRIMARY KEY,

       CONSTRAINT fk_jeu_id_jeu_DLC
        FOREIGN KEY (id_jeu_DLC)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'nomDLC.csv' 
INTO TABLE NomDLC
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(nomDLC,id_jeu_DLC);


CREATE TABLE IF NOT EXISTS Personnage( 
       personnage_principal VARCHAR(40) NOT NULL PRIMARY KEY   
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'personnage.csv' 
INTO TABLE Personnage
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(personnage_principal);

CREATE TABLE IF NOT EXISTS Personnagejeu( 
       id_jeu_personnagejeu SMALLINT UNSIGNED NOT NULL,
       personnage_principaljeu VARCHAR(40) NOT NULL,

       CONSTRAINT fk_personnagejeu_principal
        FOREIGN KEY (personnage_principaljeu)
        REFERENCES Personnage(personnage_principal),

       CONSTRAINT fk_personnagejeu_id
        FOREIGN KEY (id_jeu_personnagejeu)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'personnagejeu.csv' 
INTO TABLE Personnagejeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id_jeu_personnagejeu, personnage_principaljeu);

CREATE TABLE IF NOT EXISTS Studio( 
       nom_studio VARCHAR(40) NOT NULL PRIMARY KEY      
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'studio.csv' 
INTO TABLE Studio
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(nom_studio);

CREATE TABLE IF NOT EXISTS Studiojeu( 
       id_jeu_studiojeu SMALLINT UNSIGNED NOT NULL,
       studio_studiojeu VARCHAR(40) NOT NULL,

       CONSTRAINT fk_studio_studiojeu
        FOREIGN KEY (studio_studiojeu)
        REFERENCES Studio(nom_studio),

       CONSTRAINT fk_id_studiojeu
        FOREIGN KEY (id_jeu_studiojeu)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'studiojeu.csv' 
INTO TABLE Studiojeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id_jeu_studiojeu, studio_studiojeu);


CREATE TABLE IF NOT EXISTS Support( 
       support VARCHAR(40) NOT NULL PRIMARY KEY     
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'support.csv' 
INTO TABLE Support
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(support);

CREATE TABLE IF NOT EXISTS Supportjeu( 
       supportjeu VARCHAR(40) NOT NULL,
       id_jeu_support SMALLINT UNSIGNED NOT NULL,
       CONSTRAINT fk_supportjeu
        FOREIGN KEY (supportjeu)
        REFERENCES Support(support),

       CONSTRAINT fk_id_supportjeu
        FOREIGN KEY (id_jeu_support)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'supportjeu.csv' 
INTO TABLE Supportjeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id_jeu_support, supportjeu);

--afficher tout les jeux d'actions
SELECT Jeu.id, Jeu.titre_du_jeu FROM Jeu  INNER JOIN Genrejeu     ON Genrejeu.id_jeu = Jeu.id WHERE genre_jeu = 'Action';

--afficher tout les jeux dont le personnage principal est Dartan
SELECT Jeu.id, Jeu.titre_du_jeu FROM Jeu  INNER JOIN Personnagejeu     ON Personnagejeu.id_jeu_personnagejeu = Jeu.id WHERE personnage_principaljeu = 'Dastan';


