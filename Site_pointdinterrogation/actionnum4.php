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
            $req = $bdd->prepare('SELECT Jeu.id, Jeu.titre_du_jeu, Jeu.nom_de_la_franchise, annee_de_sortie FROM Jeu WHERE annee_de_sortie >=:postdate;');
        }else {
            $req = $bdd->prepare('SELECT Jeu.id, Jeu.titre_du_jeu, Jeu.nom_de_la_franchise, annee_de_sortie FROM Jeu WHERE annee_de_sortie <=:postdate;');
        }


        $req->execute(array('postdate' => $_POST["date"]));
        // On affiche chaque entrée une à une

        while ($donnees = $req->fetch())
        {
            ?>
                <p>
                <strong>Jeu de la franchise</strong> : <?php echo $donnees['nom_de_la_franchise']; ?><br />
                                        L'ID de ce jeu est : <?php echo $donnees['id']; ?>, son titre est <?php echo $donnees['titre_du_jeu']; ?>, année de sortie : <?php echo $donnees['annee_de_sortie']; ?> !<br />
                                       </p>
            <?php
            }
        
        $reponse->closeCursor(); // Termine le traitement de la requête

        ?>
</body>
</html>
 
