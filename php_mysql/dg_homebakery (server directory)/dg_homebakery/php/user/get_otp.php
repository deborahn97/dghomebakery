<?php

    include("../send_json.php");
    
    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $email = $_POST['email'];
    
    $sql = "SELECT * FROM user WHERE email = '$email'";
    $result = $conn -> query($sql);
    
    if ($result -> num_rows > 0) {
        $row = $result-> fetch_assoc();
        sendOTPEmail($row['email'], $row['otp']);
        $response = array('status' => 'success');
        sendJsonRes($response);
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }
    
    function sendOTPEmail($email, $otp)
    {
        $to = $email;
        $subject = "DoughyGoodness Home Bakery - OTP Request";
        
        $message = "
        <html>
        <head>
        <title>Reset Password</title>
        </head>
        <body>
        <h2>Welcome to DoughyGoodness Home Bakery</h2><br />
        <p>You have requested your OTP to reset your account password: </p>
        <br />
        <h1>$otp</h1>
        <br />
        <p>Please enter this OTP in the app to proceed with resetting your password.<br />The OTP will be invalid once you successfully reset your password.</p>
        <br />
        <p>Thank you.</p>
        </body>
        </html>
        ";
        
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
        
        mail($to, $subject, $message, $headers);
    }

?>