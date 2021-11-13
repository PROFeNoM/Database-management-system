<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Informations stations</title>
    <?php include "dbUtils.php"; ?>
    <h1>
        <a href="index.php">
            Gestion d'une flotte de vélos électriques
        </a>
    </h1>
    <div class="container">
        <a href="velos.php">Vélos</a>
        | <a href="stations.php">Stations</a>
    </div>
</head>

<body>
<form action="" method="post">
    <label>Chercher station dans la ville:
        <select name="villeInput">
            <?php
            print columnToSelect('NOM_VILLE', 'VILLES');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/stationsDansVilleNomVille.sql');

if (isset($_POST['villeInput']) && !empty($_POST['villeInput'])) {
    print "<p>Stations à la ville " . $_POST['villeInput'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['villeInput']);
} else
    print "Choisissez une ville";
?>

</body>