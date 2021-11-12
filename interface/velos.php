<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Velo Informations</title>
    <?php include "dbUtils.php"; ?>
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
        <input type="number" pattern="\d+" name="stationInput" placeholder="numéro de la station"/>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>


<?php
$query = file_get_contents(__DIR__ . '/../requetes/velosParStation.sql');
if (isset($_POST['stationInput']) && !empty($_POST['stationInput'])) {
    print "<p>Vélos à la station " . $_POST['stationInput'] . "</p>";
    parameterizedQueryToTable($query, 's', $_POST['stationInput']);
} else
    print "Choisissez une station";
?>

</body>
</html>