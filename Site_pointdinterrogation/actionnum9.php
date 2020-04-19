<html>
<head><title>TEST</title></head>
<body>


<?php

        try
        {
	        // On se connecte à MySQL
	        $bdd = new PDO('mysql:host=localhost;dbname=ubisoft;charset=utf8', 'zeus', 'salut');
        }
        catch(Exception $e)
        {
	        // En cas d'erreur, on affiche un message et on arrête tout
                die('Erreur : '.$e->getMessage());
        }
        
        //Sans genre entrer
		$req = $bdd->query('SELECT Jeu.id, Jeu.titre_du_jeu, annee_de_sortie, Supportjeu.support, Jeu.nom_de_la_franchise FROM Jeu INNER JOIN Supportjeu ON Supportjeu.id = Jeu.id WHERE support = \'PS2\' AND annee_de_sortie >= \'2003\';');
		
        // On affiche chaque entrée une à une
        while ($donnees = $req->fetch())
        {
        ?>
            <p>
            <strong>Jeu de la franchise</strong> : <?php echo $donnees['nom_de_la_franchise']; ?><br />
                                    L'ID de ce jeu est : <?php echo $donnees['id']; ?>, son titre est <?php echo $donnees['titre_du_jeu']; ?> !<br />
                                    Sortie en : <?php echo $donnees['annee_de_sortie']; ?> <br />
                                    Sortie sur : <?php echo $donnees['support']; ?> <br />
                                   </p>
        <?php
        }
        
        $reponse->closeCursor(); // Termine le traitement de la requête
        ?>
</body>
</html>
