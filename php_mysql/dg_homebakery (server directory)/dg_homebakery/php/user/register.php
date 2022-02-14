<?php

    include("../send_json.php");

    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    include_once("../send_verification.php");
    
    $name = $_POST['name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $pass = sha1($_POST['pass']);
    $otp = rand(100000,999999);
    
    $sql = 
    "INSERT INTO user (name, email, phone, pass, address, otp, status) 
     VALUES ('$name', '$email', '$phone', '$pass', 'N/A', '$otp', 'Unverified')";
    
    if($conn -> query($sql) === TRUE) {
        $response = array('status' => 'success');
        sendEmail($email, $otp);
        sendJsonRes($response);
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

    mysqli_close($conn);

?>