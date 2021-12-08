<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" content="text/html; charset=UTF-8">
    <title>Edit Record</title>
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

<?php

print editRecord();

?>

</body>