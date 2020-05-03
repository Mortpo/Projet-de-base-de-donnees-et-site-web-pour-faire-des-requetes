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


        //general
        $req = $bdd->query("INSERT INTO Genre (genre) VALUE ('$_POST[Genre_du_jeu]') ;");
        $req = $bdd->query("INSERT INTO Studio (nom_studio,date_creation) VALUE ('$_POST[Nom_du_studio]' , '$_POST[Date_de_creation]');");
        $req = $bdd->query("INSERT INTO Support (support, annee_de_sortie, marque) VALUE ('$_POST[Nom_du_support]', '$_POST[Année_de_sortie_du_support]' ,'$_POST[Marque_du_support]');");
        $req = $bdd->query("INSERT INTO Personnage (personnage_principal) VALUE ('$_POST[Personnage_du_jeu]');");



        //le jeu
        $req = $bdd->query("INSERT INTO Jeu (titre_du_jeu, annee_de_sortie, directeur_du_jeu , nom_de_la_franchise) VALUE ('$_POST[Titre_du_jeu]' ,'$_POST[Année_de_sortie_du_jeu]' ,'$_POST[Directeur_du_jeu]' ,'$_POST[Franchise_du_jeu]' );");
        //$req = $bdd->query("INSERT INTO Jeu (titre_du_jeu, annee_de_sortie, directeur_du_jeu , nom_de_la_franchise) VALUE ('qsffsqdqqz' ,'24' ,'qfs' ,'fqsf' );");


        $req = $bdd->query("SELECT COUNT(*) as total FROM Jeu ;");
        $donnee = $req->fetch();
        $total = $donnee["total"];

        echo "ID du jeu crée est : $total";

        //jeu
        $req = $bdd->query("INSERT INTO Genrejeu (id,genre) VALUE ('$total', '$_POST[Genre_du_jeu]');");
        $req = $bdd->query("INSERT INTO Studiojeu (id,nom_studio) VALUE ('$total','$_POST[Nom_du_studio]');");
        $req = $bdd->query("INSERT INTO Supportjeu (id,support) VALUE ('$total','$_POST[Nom_du_support]');");
        $req = $bdd->query("INSERT INTO Personnagejeu (id,personnage_principal) VALUE ('$total','$_POST[Personnage_du_jeu]');");


        
        $req->closeCursor(); // Termine le traitement de la requête
        ?>
</body>
</html>
