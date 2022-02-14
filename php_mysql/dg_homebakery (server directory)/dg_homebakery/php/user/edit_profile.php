<?php

    include("../send_json.php");

    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $id = $_POST['id'];
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    
    $sql = 
    "UPDATE user SET name = '$name', email = '$email', phone = '$phone', address = '$address' WHERE id = '$id'";
    
    if($conn -> query($sql) === TRUE) {
        $response = array('status' => 'success');
        sendJsonRes($response);
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

    mysqli_close($conn);

?>