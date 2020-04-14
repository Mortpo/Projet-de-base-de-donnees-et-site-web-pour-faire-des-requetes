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



        
        

    
         $txt = $_POST["genre"];
         echo $txt;
         

        
        

        //Sans genre entrer
		$req = $bdd->query("SELECT Jeu.id, Jeu.titre_du_jeu, Jeu.nom_de_la_franchise, Genrejeu.genre FROM Jeu  INNER JOIN Genrejeu ON Genrejeu.id = Jeu.id WHERE genre = '$txt'");
		
        // On affiche chaque entrée une à une
        while ($donnees = $req->fetch())
        {
        ?>
            <p>
            <strong>Jeu de la franchise</strong> : <?php echo $donnees['nom_de_la_franchise']; ?><br />
                                    L'ID de ce jeu est : <?php echo $donnees['id']; ?>, son titre est <?php echo $donnees['titre_du_jeu']; ?> !<br />
                                    De genre <?php echo $donnees['genre']; ?> <br />
                                   </p>
        <?php
        }
        
        $reponse->closeCursor(); // Termine le traitement de la requête

        ?>
</body>
</html>
 
