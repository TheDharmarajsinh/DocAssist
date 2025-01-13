<?php
session_start();

if (!isset($_SESSION['user']) || $_SESSION['user'] == "" || $_SESSION['usertype'] != 'p') {
    header("Location: ../login.php");
    exit();
}

include("../connection.php");

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    $sql = "DELETE FROM appointment WHERE appoid = ?";
    $stmt = $database->prepare($sql);
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        header("Location: appointment.php?action=booking-deleted");
        exit();
    } else {
        header("Location: appointment.php?action=error");
        exit();
    }
} else {
    header("Location: appointment.php?action=error");
    exit();
}
?>