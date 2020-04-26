<html>
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
        
        
        $req = $bdd->query('SELECT COUNT(*) as total FROM Jeu;');
        $donnee= $req->fetch();
		
        // On affiche l'entrée

        ?>
            <p>
            <strong> Nombre de jeu dans la base </strong> : <?php echo $donnee['total']; ?><br /></p>
        <?php
        
        
        $reponse->closeCursor(); // Termine le traitement de la requête
        ?>
</body>
</html>
 

