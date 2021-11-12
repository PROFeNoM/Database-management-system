<link rel="stylesheet" href="CSS/velo.css" type="text/css">

<?php // Utilities to access VELO database

$mainProgram = "index.php";

/**
 * Connect to the database
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
        print "<h3>problem connecting to database...</h3>\n";
        print "<h3>" . mysqli_error($dbConnection) . "</h3>\n";
    }

    $select = mysqli_select_db($dbConnection, $dbName);
    if (!$select) {
        print "<h3>problem selecting database...</h3>\n";
        print "<h3>" . mysqli_error($dbConnection) . "</h3>\n";
    }

    return $dbConnection;
}

/**
 * @param mysqli_result $queryResults query results to convert to HTML table code
 * @return string HTML code corresponding to the desired table
 */
function resultsToTable(mysqli_result $queryResults): string
{
    if (mysqli_num_rows($queryResults) > 0) {
        $htmlCode = "<table>\n";

        $htmlCode .= "<tr>\n";
        while ($field = mysqli_fetch_field($queryResults))
            $htmlCode .= "    <th>$field->name</th>\n";
        $htmlCode .= "</tr>\n\n";

        while ($row = mysqli_fetch_assoc($queryResults)) {
            $htmlCode .= "<tr>\n";
            foreach ($row as $data)
                $htmlCode .= "    <td>$data</td>\n";
            $htmlCode .= "</tr>\n\n";
        }

        $htmlCode .= "</table>\n";
        return $htmlCode;
    } else {
        return "No results";
    }
}

/**
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
 * @param string $query template query
 * @param string $types types of the '?' in the sql query
 * @param ...$params mixed substitutes for the '?' in the sql query
 * @return string Corresponding table in HTML Code
 */
function parameterizedQueryToTable(string $query, string $types, ...$params): string
{
    $dbConnection = connectToDb();

    $stmt = mysqli_prepare($dbConnection, $query);
    if (!mysqli_stmt_bind_param($stmt, $types, ...$params))
        print "<h3>problem binding query...</h3>\n";
    mysqli_stmt_execute($stmt);
    $queryResults = mysqli_stmt_get_result($stmt);

    return resultsToTable($queryResults);
}

/**
 * @param string $columnName column to extract from $tableName
 * @param string $tableName table in the database
 * @return string HTML code with each element of $columnName within option tags.
 * HTML select tag must be placed beforehand.
 */
function columnToSelect(string $columnName, string $tableName): string
{
    $dbConnection = connectToDb();

    $query = "select " . $columnName . " from " . $tableName . " order by " . $columnName . ";";

    $queryResults = mysqli_query($dbConnection, $query);

    if (mysqli_num_rows($queryResults) > 0) {
        $htmlCode = "";

        while ($row = mysqli_fetch_assoc($queryResults))
            foreach ($row as $data)
                $htmlCode .= "        <option>$data</option>\n";
        return $htmlCode;
    } else {
        return "No results";
    }
}