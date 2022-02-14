<?php

    include("../send_json.php");

    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $email = $_POST['email'];
    $pass = sha1($_POST['pass']);
    $otp = rand(100000,999999);
    
    $sql_select = "SELECT * FROM user WHERE email = '$email'";
    $result_select = $conn -> query($sql_select);

    if($result_select -> num_rows > 0) {
        $sql_update = "UPDATE user SET pass = '$pass', otp = '$otp' WHERE email = '$email'";
        
        if($conn -> query($sql_update) === TRUE) {
            $response = array('status' => 'success');
            sendJsonRes($response);
        } else {
            $response = array('status' => 'failed');
            sendJsonRes($response);
        }
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

    mysqli_close($conn);

?>