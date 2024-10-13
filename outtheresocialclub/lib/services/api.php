<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$host = 'pool195-106-36.bur.atomicsites.net'; // Your database host
$user = 'maxwellclubcom.wordpress.com'; // Your database username
$password = 'zFT5QiWhNblGoCZ6vQIm'; // Your database password
$database = '150552279'; // Your database name

// Create a connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Fetch users
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $sql = "SELECT id, name FROM users"; // Modify your query as needed
    $result = $conn->query($sql);

    $users = array();
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
    echo json_encode($users);
}

// Close the connection
$conn->close();
?>
