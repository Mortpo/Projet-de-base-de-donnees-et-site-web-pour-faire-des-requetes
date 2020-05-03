<html>
<head><title>TEST</title></head>
<body>


<?php

        try
        {
	        // On se connecte à MySQL
	        $bdd = new PDO('mysql:host=localhost;dbname=ubisoft;charset=utf8', 'romain', 'romain');
        }
        catch(Exception $e)
        {
	        // En cas d'erreur, on affiche un message et on arrête tout
                die('Erreur : '.$e->getMessage());
        }

        //Sans genre entrer
        if (!empty($_POST["temps"])) {
            $req = $bdd->prepare('SELECT Jeu.id, Jeu.titre_du_jeu, Studiojeu.nom_studio, annee_de_sortie ,Jeu.nom_de_la_franchise  FROM Jeu INNER JOIN Studiojeu ON Studiojeu.id = Jeu.id WHERE nom_studio =:poststud AND annee_de_sortie >=:postdate;');
        }else {
            $req = $bdd->prepare('SELECT Jeu.id, Jeu.titre_du_jeu, Studiojeu.nom_studio, annee_de_sortie,Jeu.nom_de_la_franchise  FROM Jeu INNER JOIN Studiojeu ON Studiojeu.id = Jeu.id WHERE nom_studio =:poststud AND annee_de_sortie <=:postdate;');
        }


        $req->execute(array('postdate' => $_POST["date"],'poststud' => $_POST["studio"]));
        // On affiche chaque entrée une à une

        while ($donnees = $req->fetch())
        {
            ?>
                <p>
                <strong>Jeu de la franchise</strong> : <?php echo $donnees['nom_de_la_franchise']; ?><br />
                                        L'ID de ce jeu est : <?php echo $donnees['id']; ?>, son titre est <?php echo $donnees['titre_du_jeu']; ?>, année de sortie : <?php echo $donnees['annee_de_sortie']; ?> !<br />
                                        Son studio est : <?php echo $donnees['nom_studio']; ?> <br />
                                    </p>
            <?php
            }
        
            $req->closeCursor(); // Termine le traitement de la requête

        ?>
</body>
</html>
 
