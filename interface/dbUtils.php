<link rel="stylesheet" href="CSS/velo.css" type="text/css">

<?php // Utilities to access VELO database

$mainProgram = "index.php";

/**
 * Connect to a mysql database
 * @return mysqli object which represents the connection to a MySQL Server
 */
function connectToDb(): mysqli
{
    $userName = "velo";
    $dbPassword = "P@ssW0rd";
    $serverName = "localhost";
    $dbName = "VELO";

    $dbConnection = mysqli_connect($serverName, $userName, $dbPassword);
    if (!$dbConnection) {
        print "<h3>Erreur lors de la connexion à la base de données...</h3>\n";
        print "<div class=\"error\"><p>" . mysqli_error($dbConnection) . "</p></div>\n";;
    }

    $select = mysqli_select_db($dbConnection, $dbName);
    if (!$select) {
        print "<h3>Erreur lors de la sélection de la base de données $dbName...</h3>\n";
        print "<div class=\"error\"><p>" . mysqli_error($dbConnection) . "</p></div>\n";;
    }

    return $dbConnection;
}

/**
 * Generate HTML code from mysqli query results
 * @param mysqli_result $queryResults query results to convert to HTML table code
 * @return string HTML code corresponding to the desired table
 */
function resultsToTable(mysqli_result $queryResults): string
{
    if (mysqli_num_rows($queryResults) > 0) {
        $htmlCode = "<table>\n";

        $htmlCode .= "<tr>\n";
        while ($field = mysqli_fetch_field($queryResults))
            $htmlCode .= "\t<th>$field->name</th>\n";
        $htmlCode .= "</tr>\n\n";

        while ($row = mysqli_fetch_assoc($queryResults)) {
            $htmlCode .= "<tr>\n";
            foreach ($row as $data)
                $htmlCode .= "\t<td>$data</td>\n";
            $htmlCode .= "</tr>\n\n";
        }

        $htmlCode .= "</table>\n";

        return $htmlCode;
    } else
        return "No results";
}

/**
 * Generate HTML table from mysql query
 * @param $query string query to execute on the database
 * @return string Corresponding table in HTML Code
 */
function queryToTable(string $query): string
{
    $dbConnection = connectToDb();

    $queryResults = mysqli_query($dbConnection, $query);

    return resultsToTable($queryResults);
}

/**
 * Generate HTML table from mysql parameterized query
 * @param string $query template query
 * @param string $types types of the '?' in the sql query
 * @param ...$params mixed substitutes for the '?' in the sql query
 * @return string Corresponding table in HTML Code
 */
function parameterizedQueryToTable(string $query, string $types, ...$params): string
{
    $dbConnection = connectToDb();

    $stmt = mysqli_prepare($dbConnection, $query);
    if (!mysqli_stmt_bind_param($stmt, $types, ...$params)) {
        return "<h3>Erreur lors du binding de la requête...</h3>\n"
            . "<div class=\"error\"><p>" . mysqli_stmt_error($stmt) . "</p></div>\n";
    } else {
        mysqli_stmt_execute($stmt);
        $queryResults = mysqli_stmt_get_result($stmt);

        return resultsToTable($queryResults);
    }
}

/**
 * Generate HTML selectable data from a column in a mysql database
 * @param string $columnName column to extract from $tableName
 * @param string $tableName table in the database
 * @return string HTML code with each element of $columnName within option tags.
 * HTML select tag must be placed beforehand.
 */
function columnToSelect(string $columnName, string $tableName): string
{
    $dbConnection = connectToDb();

    $query = "select distinct $columnName from $tableName order by $columnName ;";

    $queryResults = mysqli_query($dbConnection, $query);

    if (mysqli_num_rows($queryResults) > 0) {
        $htmlCode = "";

        while ($row = mysqli_fetch_assoc($queryResults))
            foreach ($row as $data)
                $htmlCode .= "\t\t<option>$data</option>\n";
        return $htmlCode;
    } else
        return "No results";
}

/**
 * Generate HTML code to edit a mysql table
 * @param string $tableName name of the table in the database
 * @return string HTML code allowing to edit (add, update, delete) table elements
 */
function editTable(string $tableName): string
{
    $dbConnection = connectToDb();

    $tableName = mysqli_real_escape_string($dbConnection, $tableName);

    $query = "select * from $tableName;";

    $queryResults = mysqli_query($dbConnection, $query);

    $htmlCode = "<table>\n";

    $htmlCode .= "<tr>\n";
    while ($field = mysqli_fetch_field($queryResults))
        $htmlCode .= "\t<th>$field->name</th>\n";
    $htmlCode .= "\t<th></th>\n";
    $htmlCode .= "\t<th></th>\n";
    $htmlCode .= "</tr>\n\n";

    $pkName = mysqli_fetch_field_direct($queryResults, 0)->name;
    while ($row = mysqli_fetch_assoc($queryResults)) {
        $htmlCode .= "<tr>\n";
        foreach ($row as $data)
            $htmlCode .= "\t<td>$data</td>\n";
        $pkValue = $row["$pkName"];
        $htmlCode .= <<<HEREDOC
    <td>
    <form action="resultatsSupprimer.php" method="post">
        <fieldset class="fieldsetButton">
            <input type="hidden" name="tableName" value="$tableName" />
            <input type="hidden" name="pkName" value="$pkName" />
            <input type="hidden" name="pkValue" value="$pkValue" />
            <input type="submit" value="delete" class="button delete"/>
        </fieldset>
    </form>
    </td>
HEREDOC;
        $htmlCode .= <<<HEREDOC
    <td>
    <form action="modifierLigne.php" method="post">
        <fieldset class="fieldsetButton">
            <input type="hidden" name="tableName" value="$tableName" />
            <input type="hidden" name="pkName" value="$pkName" />
            <input type="hidden" name="pkValue" value="$pkValue" />
            <input type="submit" value="edit" class="button editButton"/>
        </fieldset>
    </form>
    </td>
HEREDOC;

        $htmlCode .= "</tr>\n\n";
    }

    $htmlCode .= <<<HEREDOC
    <tr>
    <td colspan="100%">
        <form action="ajouterLigne.php" method="post">
            <fieldset class="fieldsetButton">
                <input type="hidden" name="tableName" value="$tableName" />
                <button class="button add" type="submit">Ajouter une ligne</button>
            </fieldset>
        </form>
    </td>
    </tr>
    </table>
HEREDOC;

    return $htmlCode;
}

/**
 * Generate HTML code allowing a user to input and hence edit a record
 * @return string HTML Code allowing to edit a record
 */
function editRecord(): string
{
    $dbConnection = connectToDb();

    $tableName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "tableName"));
    $pkName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkName"));
    $pkValue = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkValue"));

    $htmlCode = "";

    $query = "select * from $tableName where $pkName = $pkValue;";
    $queryResults = mysqli_query($dbConnection, $query);

    $row = mysqli_fetch_assoc($queryResults);

    // get table name from field object
    $tableName = mysqli_fetch_field_direct($queryResults, 0)->table;

    $htmlCode .= <<<HEREDOC
<form action = "resultatsModification.php" method = "post">
<fieldset class="edit">
    <input type = "hidden" name = "tableName" value = "$tableName" />
    <dl>
HEREDOC;

    $isPk = 1;
    foreach ($row as $columnName => $data) {
        if ($isPk == 1) {
            // Don't edit primary key
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd>$data<input type = "hidden" name = "$columnName" value = "$data" /></dd>
HEREDOC;
            $isPk = 0;
        } else if (preg_match("/^NUMERO_(.*?)(?:_|$)/", $columnName, $match)) {
            $values = handleForeignKey($match[1], $columnName, $data);
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd>$values</dd>
HEREDOC;
        } else {
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd><input type="text" name="$columnName" value="$data" /></dd>
HEREDOC;
        }
    }
    $htmlCode .= <<<HEREDOC
    </dl>
    <button class="button" type="submit">Modifier la ligne</button>
</fieldset>
</form>
HEREDOC;
    return $htmlCode;
}

/**
 * Generate a list corresponding to a selected field from the foreign table
 * @param $tableNameSingular string Name of the table in the database without 'S'
 * @param string $columnName Optional parameter to specify initial column name to prevent conflict
 * @param null $pkValue Optional parameter to pre-select a pk in the list
 * @return string HTML Code allowing representing a list of field
 */
function handleForeignKey($tableNameSingular, $columnName = "", $pkValue = null): string
{
    $correspondingForeignFieldName = "";
    $tableName = $tableNameSingular . "S";
    $foreignTablePkName = "NUMERO_$tableNameSingular";

    switch ($tableNameSingular) {
        case "VILLE":
            $correspondingForeignFieldName = "NOM_VILLE";
            break;
        case "ETAT":
            $correspondingForeignFieldName = "ETAT";
            break;
        case "STATION":
            $correspondingForeignFieldName = "NUMERO_STATION";
            break;
        case "VELO":
            $correspondingForeignFieldName = "REFERENCE";
            break;
        case "ADHERENT":
            $correspondingForeignFieldName = "NUMERO_ADHERENT";
            break;
    }

    $dbConnection = connectToDb();
    $query = "select $foreignTablePkName, $correspondingForeignFieldName from $tableName order by $correspondingForeignFieldName;";
    $queryResults = mysqli_query($dbConnection, $query, MYSQLI_STORE_RESULT);

    $htmlCode = empty($columnName) ? "<select name=\"$foreignTablePkName\">\n" : "<select name=\"$columnName\">\n";
    $htmlCode .= "<option value=\"\">null</option>\n";
    while ($row = mysqli_fetch_assoc($queryResults)) {
        $pkRecord = $row["$foreignTablePkName"];
        $data = $row["$correspondingForeignFieldName"];

        $htmlCode .= $pkRecord == $pkValue ? "<option value=\"$pkRecord\" selected>$data</option>\n"
            : "<option value=\"$pkRecord\">$data</option>\n";
    }

    return $htmlCode . "</select>\n";
}

/**
 * Update a record from a table in the database
 * @return string HTML code corresponding to the query sent, and it's success
 */
function updateRecord(): string
{
    $dbConnection = connectToDb();

    $columns = array();
    $values = array();
    $tableName = "";

    foreach ($_REQUEST as $fieldName => $data) {
        if ($fieldName == "tableName") {
            $tableName = $data;
        } else {
            array_push($columns, mysqli_real_escape_string($dbConnection, $fieldName));
            array_push($values, mysqli_real_escape_string($dbConnection, $data));
        }
    }

    $pkName = $columns[0];
    $pkValueToUpdate = $values[0];

    $query = "update $tableName set \n";
    for ($i = 1; $i < count($columns); $i++)
        $query .= ($values[$i] == 'null' || $values[$i] == '')
            ? "$columns[$i] = null,\n" : "$columns[$i] = '$values[$i]',\n";

    $query = substr($query, 0, strlen($query) - 2);  // remove trailing ",\n" from query

    $query .= "\nwhere $pkName = '$pkValueToUpdate';";

    $htmlCode = "Requête envoyée au serveur:<br><div class='query'><p>$query</p></div><br>\n";

    $queryResults = mysqli_query($dbConnection, $query);

    if ($queryResults) {
        $query = "select * from $tableName where $pkName = '$pkValueToUpdate'";
        $htmlCode .= "<h1>Ligne modifiée avec succès</h1>\n";
        $htmlCode .= "<h2>La ligne est maintenant:</h2>";
        $htmlCode .= queryToTable($query);
    } else {
        $htmlCode .= "<h3>Erreur lors de la modification de la ligne...</h3><pre>$query</pre>\n";
        $htmlCode .= "<div class=\"error\"><p>" . mysqli_error($dbConnection) . "</p></div>\n";;
    }

    return $htmlCode;
}

/**
 * Generate HTML code to add a new record
 * @return string HTML Code allowing to the user to input the new record data
 */
function addToTable(): string
{
    $dbConnection = connectToDb();

    $tableName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "tableName"));

    // get field names
    $query = "select * from $tableName;";
    $queryResults = mysqli_query($dbConnection, $query) or die(mysqli_error($dbConnection));

    $htmlCode = <<<HEREDOC
    <form action="resultatsAjout.php" method="post">
        <fieldset>
        <dl>
HEREDOC;

    $isPk = 1;
    while ($field = mysqli_fetch_field($queryResults)) {
        $columnName = $field->name;
        if ($isPk == 1) {
            // Primary key will be automatically incremented
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd>auto_number<input type="hidden" name="$columnName" value="null" ></dd>    
HEREDOC;
            $isPk = 0;
        } else if (preg_match("/^NUMERO_(.*?)(?:_|$)/", $columnName, $match)) {
            $values = handleForeignKey($match[1], $columnName);
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd>$values</dd>
HEREDOC;
        } else {
            // Ordinary field to text box
            $htmlCode .= <<<HEREDOC
            <dt>$columnName</dt>
            <dd><input type="text" name="$columnName" value="" ></dd>
HEREDOC;
        }
    }

    $htmlCode .= <<<HEREDOC
        </dl>
        <input type="hidden" name="tableName" value="$tableName" >
        <button class="button" type="submit">Ajouter la ligne</button>
        </fieldset>
    </form>
HEREDOC;

    return $htmlCode;
}

/**
 * Add a record to a table from the database
 * @return string HTML code corresponding to the query sent, and it's success
 */
function addRecord(): string
{
    $dbConnection = connectToDb();

    foreach ($_REQUEST as $fieldName => $data) {
        if ($fieldName == "tableName")
            $tableName = $data;
        else {
            $columnsName[] = mysqli_real_escape_string($dbConnection, $fieldName);
            $values[] = mysqli_real_escape_string($dbConnection, $data);
        }
    }

    array_shift($columnsName);  // Remove pk field; should be auto incremented
    $query = "insert into $tableName (";
    foreach ($columnsName as $column)
        $query .= "$column, ";

    array_shift($values);  // Remove pk field; should be auto incremented
    $query = substr($query, 0, strlen($query) - 2);  // Delete trailing ", "
    $query .= ") values (";
    foreach ($values as $data) {
        if ($values == 'null' || empty($data)) {
            $query .= "null, ";
        } else
            $query .= "'$data', ";
    }

    $query = substr($query, 0, strlen($query) - 2);  // Delete trailing ", "
    $query .= ");";

    $htmlCode = "Requête envoyée au serveur:<br><div class='query'><p>$query</p></div><br>\n";

    $queryResults = mysqli_query($dbConnection, $query);
    if ($queryResults)
        $htmlCode .= "<h3>Ligne ajoutée avec succès</h3>\n";
    else {
        $htmlCode .= "<h3>Erreur lors de l'ajout de la ligne...</h3>\n";
        $htmlCode .= "<div class=\"error\"><p>" . mysqli_error($dbConnection) . "</p></div>\n";
    }

    return $htmlCode;
}

/**
 * Delete a record from the database
 * @return string HTML code corresponding to the query sent, and it's success
 */
function deleteRecord(): string
{
    $dbConnection = connectToDb();

    $tableName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "tableName"));
    $pkName = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkName"));
    $pkValue = mysqli_real_escape_string($dbConnection, filter_input(INPUT_POST, "pkValue"));

    $query = "delete from $tableName where $pkName = '$pkValue'";
    $htmlCode = "Requête envoyée au serveur:<br><div class=\"query\"><p>$query</p></div><br>\n";

    $queryResults = mysqli_query($dbConnection, $query);

    if ($queryResults)
        $htmlCode .= "<h3>Ligne supprimée avec succès</h3>\n";
    else {
        $htmlCode .= "<h3>Erreur lors de la suppression de la ligne...</h3>\n";
        $htmlCode .= "<div class=\"error\"><p>" . mysqli_error($dbConnection) . "</p></div>\n";
    }
    return $htmlCode;
}