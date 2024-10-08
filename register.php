<?php
// Database connection details
$host = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbname = 'cafeat_database';

// Create connection
$conn = new mysqli($host, $dbUsername, $dbPassword, $dbname);

// Check connection
if ($conn->connect_error) {
    die('Connection Failed: ' . $conn->connect_error);
}

// Get the data from the Flutter app
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $fullname = $_POST['fullname'];
    $email = $_POST['email'];
    $contact = $_POST['contact'];
    $userType = $_POST['role'];
    $password = $_POST['password'];

    // Hash the password before storing
    //$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Insert the user data into the database
    $sql = "INSERT INTO Users (User_name, Email, Contact, Role, password) VALUES (?, ?, ?, ?, ?)";

    // Prepare and bind
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssiss", $fullname, $email, $contact, $userType, $password);

    if ($stmt->execute()) {
        // Send a success response to the Flutter app
        echo json_encode(array('message' => 'User registered successfully'));
    } else {
        // Send a failure response to the Flutter app
        echo json_encode(array('error' => 'Failed to register user'));
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
} else {
    echo json_encode(array('error' => 'Invalid Request Method'));
}
?>
