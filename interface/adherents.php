<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html lang="fr" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" content="text/html; charset=UTF-8">
    <title>Informations adhérents</title>
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

<!-- START ADHERENTS + 2 VELOS POUR JOUR DONNEE -->
<h2>Liste des adhérents qui ont emprunté au moins deux vélos différents pour un jour donné</h2>

<form action="" method="post">
    <label>Chercher pour la date du:
        <select name="dateInput1">
            <?php
            print columnToSelect('DATE_EMPRUNT', 'EMPRUNTS');
            ?>
        </select>
    </label>
    <p><input type="submit" value="Submit Query"/></p>
</form>

<?php
$query = file_get_contents(__DIR__ . '/../SQL/adherentsPlus2VelosJourDonnee.sql');

if (isset($_POST['dateInput1']) && !empty($_POST['dateInput1'])) {
    print "<p>Adhérents ayant emprunté au moins deux vélos différents le " . $_POST['dateInput1'] . "</p>";
    print parameterizedQueryToTable($query, 's', $_POST['dateInput1']);
} else
    print "Choisissez une date.";
?>
<!-- END ADHERENTS + 2 VELOS POUR JOUR DONNEE -->

<hr>

<!-- START EDIT ADHERENTS -->
<h2>Informations sur les adhérents</h2>
<?php
print editTable('ADHERENTS');
?>
<!-- END EDIT ADHERENTS -->

</body>