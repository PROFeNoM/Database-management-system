<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Informations vélos</title>
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
Velos en cours d'utilisation (Test requete 'statique')

<?php
$query = file_get_contents(__DIR__ . '/../requetes/velosEnCoursUtilisation.sql');
print queryToTable($query);
?>

Velos à la station ? (Test requete 'configurable')

<form action="" method="post">
    <label>Chercher vélos à la station:
        <select name="stationInput">
            <?php
            print columnToSelect('NUMERO_STATION', 'STATIONS');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>


<?php
$query = file_get_contents(__DIR__ . '/../requetes/velosParStation.sql');

if (isset($_POST['stationInput']) && !empty($_POST['stationInput'])) {
    print "<p>Vélos à la station " . $_POST['stationInput'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['stationInput']);
} else
    print "Choisissez une station";
?>

</body>
</html>