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

function parameterizedQueryToTable(string $query, string $types, ...$params) {
    $dbConnection = connectToDb();

    $stmt = mysqli_prepare($dbConnection, $query);
    if (!mysqli_stmt_bind_param($stmt, $types, ...$params))
        print "<h3>problem binding query...</h3>\n";
    mysqli_stmt_execute($stmt);
    $queryResults = mysqli_stmt_get_result($stmt);

    print resultsToTable($queryResults);
}