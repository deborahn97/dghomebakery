<?php

    include("../send_json.php");
    
    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $email = $_POST['email'];
    $otp = $_POST['otp'];
    
    $sql = "SELECT * FROM user WHERE email = '$email' AND otp = '$otp'";
    $result = $conn -> query($sql);
    
    if ($result -> num_rows > 0) {
        $response = array('status' => 'success');
        sendJsonRes($response);
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

?>