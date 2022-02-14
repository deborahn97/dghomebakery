<?php

    include_once("../send_verification.php");

    $email = $_POST['email'];
    $otp = $_POST['otp'];

    sendEmail($email, $otp);

?>