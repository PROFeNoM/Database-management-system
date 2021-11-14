<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Delete Record</title>
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

<?php

$dbConnection = connectToDb();

$tableName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "tableName"));
$pkName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkName"));
$pkValue = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkValue"));

print deleteRecord($tableName, $pkName, $pkValue);

?>

</body>