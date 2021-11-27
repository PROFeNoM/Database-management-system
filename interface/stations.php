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
        | <a href="adherents.php">Adhérents</a>
        | <a href="emprunts.php">Emprunts</a>
        | <a href="etats.php">Etats</a>
        | <a href="separer.php">Séparer</a>
        | <a href="villes.php">Villes</a>
    </div>
</head>

<body>
<hr>

<!-- START CHERCHER STATION DANS VILLE -->
<h2>Liste des stations dans une commune donnée</h2>

<form action="" method="post">
    <label>Chercher station dans la ville:
        <select name="villeInput1">
            <?php
            print columnToSelect('NOM_VILLE', 'VILLES');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/stationsDansVilleNomVille.sql');

if (isset($_POST['villeInput1']) && !empty($_POST['villeInput1'])) {
    print "<p>Stations à la ville " . $_POST['villeInput1'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['villeInput1']);
} else
    print "Choisissez une ville";
?>
<!-- END CHERCHER STATION DANS VILLE -->

<hr>

<!-- START CLASSEMENT STATIONS PLACES DISPO PAR COMMUNE -->
<h2>Classement des stations par nombre de places disponibles par ville</h2>

<form action="" method="post">
    <label>Obtenir le classement pour la ville:
        <select name="villeInput2">
            <?php
            print columnToSelect('NOM_VILLE', 'VILLES');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/classementStationPlaceDispoParCommune.sql');

if (isset($_POST['villeInput2']) && !empty($_POST['villeInput2'])) {
    print "<p>Classement des stations pour la ville de " . $_POST['villeInput2'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['villeInput2']);
} else
    print "Choisissez une ville.";
?>
<!-- END CLASSEMENT STATIONS PLACES DISPO PAR COMMUNE -->

<hr>
<!-- START EDIT STATIONS -->
<h2>Informations sur les stations</h2>

<?php
print editTable('STATIONS');
?>
<!-- END EDIT STATIONS -->

</body>