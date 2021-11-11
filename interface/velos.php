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
$dbConnection = connectToDb();

$query = file_get_contents(__DIR__ . '/../requetes/velosEnCoursUtilisation.sql');

print queryToTable($dbConnection, $query);
?>

Velos à la station 10 (Test requete 'configurable')

<?php
$dbConnection = connectToDb();

$query = file_get_contents(__DIR__ . '/../requetes/velosParStation.sql');

$stmt = mysqli_prepare($dbConnection, $query);
if (!mysqli_stmt_bind_param($stmt, 'i', $station))
    print "<h3>problem binding query...</h3>\n";

$station = 10;  // THIS will have to be in somehting like <form ...> for the user to select what he wants
// Handle SQL Injections

mysqli_stmt_execute($stmt);
$queryResults = $stmt->get_result();

print resultsToTable($queryResults);

?>

</body>
</html>