DROP DATABASE IF EXISTS ubisoft;
CREATE DATABASE ubisoft;
USE ubisoft;

CREATE TABLE IF NOT EXISTS Jeu( 
       id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
       titre_du_jeu VARCHAR(200) UNIQUE NOT NULL, 
       annee_de_sortie INT(4) NOT NULL, 
       directeur_du_jeu VARCHAR(100) NOT NULL, 
       nom_de_la_franchise VARCHAR(30)
) ENGINE=INNODB; 

LOAD DATA LOCAL INFILE 'jeu.csv' 
INTO TABLE Jeu 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id,titre_du_jeu,annee_de_sortie,directeur_du_jeu,nom_de_la_franchise);

CREATE TABLE IF NOT EXISTS Genre( 
    genre VARCHAR(100) UNIQUE NOT NULL, 
       PRIMARY KEY (genre) 
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'genre.csv' 
INTO TABLE Genre 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(genre);

CREATE TABLE IF NOT EXISTS Genrejeu( 
       id SMALLINT UNSIGNED NOT NULL,
       genre VARCHAR(100) NOT NULL,
       
       CONSTRAINT fk_genre_genrejeu
        FOREIGN KEY (genre)
        REFERENCES Genre(genre),

       CONSTRAINT fk_jeu_id
        FOREIGN KEY (id)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'genrejeu.csv' 
INTO TABLE Genrejeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, genre);

CREATE TABLE IF NOT EXISTS NomDLC(
       id SMALLINT UNSIGNED NOT NULL,
       nomDLC VARCHAR(100) NOT NULL PRIMARY KEY,

       CONSTRAINT fk_DLC_id
        FOREIGN KEY (id)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'nomDLC.csv' 
INTO TABLE NomDLC
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(nomDLC,id);


CREATE TABLE IF NOT EXISTS Personnage( 
       personnage_principal VARCHAR(200) NOT NULL PRIMARY KEY   
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'personnage.csv' 
INTO TABLE Personnage
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(personnage_principal);

CREATE TABLE IF NOT EXISTS Personnagejeu( 
       id SMALLINT UNSIGNED NOT NULL,
       personnage_principal VARCHAR(200) NULL,

       CONSTRAINT fk_personnagejeu_principal
        FOREIGN KEY (personnage_principal)
        REFERENCES Personnage(personnage_principal),

       CONSTRAINT fk_personnagejeu_id
        FOREIGN KEY (id)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'personnagejeu.csv' 
INTO TABLE Personnagejeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, personnage_principal);

CREATE TABLE IF NOT EXISTS Studio( 
       nom_studio VARCHAR(100) NOT NULL PRIMARY KEY      
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'studio.csv' 
INTO TABLE Studio
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(nom_studio);

CREATE TABLE IF NOT EXISTS Studiojeu( 
       id SMALLINT UNSIGNED NOT NULL,
       nom_studio VARCHAR(100) NOT NULL,

       CONSTRAINT fk_nom_studio
        FOREIGN KEY (nom_studio)
        REFERENCES Studio(nom_studio),

       CONSTRAINT fk_id
        FOREIGN KEY (id)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'studiojeu.csv' 
INTO TABLE Studiojeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, nom_studio);


CREATE TABLE IF NOT EXISTS Support( 
       support VARCHAR(70) NOT NULL PRIMARY KEY     
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'support.csv' 
INTO TABLE Support
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(support);

CREATE TABLE IF NOT EXISTS Supportjeu( 
       support VARCHAR(100) NOT NULL,
       id SMALLINT UNSIGNED NOT NULL,
       CONSTRAINT fk_support
        FOREIGN KEY (support)
        REFERENCES Support(support),

       CONSTRAINT fk_id_support
        FOREIGN KEY (id)
        REFERENCES Jeu(id)       
       
) ENGINE=INNODB;

LOAD DATA LOCAL INFILE 'supportjeu.csv' 
INTO TABLE Supportjeu
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, support);

--afficher tout les jeux d'actions
SELECT Jeu.id, Jeu.titre_du_jeu, Genrejeu.genre FROM Jeu  INNER JOIN Genrejeu     ON Genrejeu.id = Jeu.id WHERE genre = 'Action';

--afficher tout les jeux dont le personnage principal est Dartan
SELECT Jeu.id, Jeu.titre_du_jeu, Personnagejeu.personnage_principal FROM Jeu  INNER JOIN Personnagejeu     ON Personnagejeu.id = Jeu.id WHERE personnage_principal = 'Dastan';

--afficher tout les jeux creer par kevin Guillemette
SELECT Jeu.id, Jeu.titre_du_jeu, directeur_du_jeu FROM Jeu WHERE directeur_du_jeu = 'Kevin Guillemette';

--afficher tout les jeux creer par BLue Byte Software
SELECT Jeu.id, Jeu.titre_du_jeu, Studiojeu.nom_studio FROM Jeu INNER JOIN Studiojeu ON Studiojeu.id = Jeu.id WHERE nom_studio = 'Blue Byte Software';

--afficher tout les jeux sortie par ubisoft montreal sortie en 2003
SELECT Jeu.id, Jeu.titre_du_jeu, Studiojeu.nom_studio, annee_de_sortie FROM Jeu INNER JOIN Studiojeu ON Studiojeu.id = Jeu.id WHERE nom_studio = 'Ubisoft Montréal' AND annee_de_sortie = '2003';

--afficher tous les jeux d'actions a etre sortie apres 2001
SELECT Jeu.id, Jeu.titre_du_jeu, annee_de_sortie FROM Jeu INNER JOIN Genrejeu ON Genrejeu.id = Jeu.id WHERE genre = 'Action' AND annee_de_sortie >= '2001';

SELECT Jeu.id,Jeu.titre_du_jeu,Jeu.annee_de_sortie,Personnagejeu.personnage_principal,Genrejeu.genre,Studiojeu.nom_studio,Supportjeu.support FROM Jeu JOIN Personnagejeu JOIN Genrejeu JOIN Studiojeu JOIN Supportjeu  ON Personnagejeu.id = Jeu.id && Jeu.id=Genrejeu.id && Jeu.id = Studiojeu.id && Jeu.id = Supportjeu.id;

SELECT * FROM Jeu JOIN Studiojeu JOIN Genrejeu JOIN Personnagejeu  ON  Jeu.id = Studiojeu.id && Jeu.id = Genrejeu.id && Jeu.id = Personnagejeu.id;


