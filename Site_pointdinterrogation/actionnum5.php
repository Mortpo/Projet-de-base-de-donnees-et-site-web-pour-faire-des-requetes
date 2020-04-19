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

        $req = $bdd->prepare('SELECT Jeu.id, Jeu.titre_du_jeu, Studiojeu.nom_studio,Jeu.nom_de_la_franchise FROM Jeu INNER JOIN Studiojeu ON Studiojeu.id = Jeu.id WHERE nom_studio =:poststud;');
        $req->execute(array('poststud' => $_POST["studio"]));
        // On affiche chaque entrée une à une

        while ($donnees = $req->fetch())
        {
        ?>
            <p>
            <strong>Jeu de la franchise</strong> : <?php echo $donnees['nom_de_la_franchise']; ?><br />
                                    L'ID de ce jeu est : <?php echo $donnees['id']; ?>, son titre est <?php echo $donnees['titre_du_jeu']; ?> !<br />
                                    Son studio est : <?php echo $donnees['nom_studio']; ?> <br />
                                   </p>
        <?php
        }
        
        $reponse->closeCursor(); // Termine le traitement de la requête

        ?>
</body>
</html>
 
