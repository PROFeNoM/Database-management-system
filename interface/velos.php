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
        | <a href="adherents.php">Adhérents</a>
        | <a href="emprunts.php">Emprunts</a>
    </div>
</head>

<body>
<hr>

<!-- START VELOS EN COURS UTILISATION -->
<h2>Liste des vélos en cours d'utilisation</h2>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/velosEnCoursUtilisation.sql');
print queryToTable($query);
?>
<!-- END VELOS EN COURS UTILISATION -->

<!-- START KM VELOS -->
<h2>Kilométrage des vélos</h2>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/kilometrageParVelo.sql');
print queryToTable($query);
?>
<!-- END KM VELOS -->

<hr>

<!-- START USAGERS VELOS JOUR -->
<h2>Nombre d’usagers par vélo par jour</h2>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/nombreUsagersVelosParJour.sql');
print queryToTable($query);
?>
<!-- END USAGERS VELOS JOUR -->
<hr>

<!-- START CHERCHER VELOS DANS STATION -->
<h2>Liste des vélos par station</h2>

<form action="" method="post">
    <label>Chercher vélos à la station:
        <select name="stationInput1">
            <?php
            print columnToSelect('NUMERO_STATION', 'STATIONS');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/velosParStation.sql');

if (isset($_POST['stationInput1']) && !empty($_POST['stationInput1'])) {
    print "<p>Vélos à la station " . $_POST['stationInput1'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['stationInput1']);
} else
    print "<div class=\"error\"><p>Choisissez une station</p></div>\n";
?>
<!-- END CHERCHER VELOS DANS STATION -->

<hr>

<!-- START CLASSEMENT VELOS BATTERY -->
<h2>Classement des vélos les plus chargés par station</h2>

<form action="" method="post">
    <label>Obtenir le classement pour la station:
        <select name="stationInput2">
            <?php
            print columnToSelect('NUMERO_STATION', 'STATIONS');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../requetes/classementVelosChargeParStation.sql');

if (isset($_POST['stationInput2']) && !empty($_POST['stationInput2'])) {
    print "<p>Classement des stations pour la ville de " . $_POST['stationInput2'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['stationInput2']);
} else
    print "<div class=\"error\"><p>Choisissez une station</p></div>\n";
?>
<!-- END CLASSEMENT VELOS BATTERY-->

<hr>

<!-- START EDIT VELOS -->
<h2>Informations sur les vélos</h2>
<?php
print editTable('VELOS');
?>
<!-- END EDIT VELOS -->

</body>
</html>