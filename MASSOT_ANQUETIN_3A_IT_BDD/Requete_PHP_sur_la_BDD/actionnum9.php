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
        
        $req = $bdd->prepare('SELECT COUNT(*) as totalsursupp FROM Supportjeu WHERE support =:postsupport;');
    

        $req->execute(array('postsupport' => $_POST["support"]));
        // On affiche chaque entrée une à une
        $donnees = $req->fetch()
        
        ?>
            <p>
            <strong>Le nombre de jeu sur le/la <?php echo $_POST["support"]; ?> </strong> : <?php echo $donnees['totalsursupp']; ?><br /></p>
        <?php
        
        
        $req->closeCursor(); // Termine le traitement de la requête
        ?>
</body>
</html>
