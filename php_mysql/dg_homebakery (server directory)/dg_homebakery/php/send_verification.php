<?php

    function sendEmail($email, $otp)
    {
        $to = $email;
        $subject = "DoughyGoodness Home Bakery - Verify Your Account";
        
        $message = "
        <html>
        <head>
        <title>Verify Your Account</title>
        </head>
        <body>
        <h2>Welcome to DoughyGoodness Home Bakery</h2><br />
        <p>Thank you for registering your account.<br/>To complete your registration, please click the following link to verify your account.<p><br />
        <p><a href ='https://debbien97.000webhostapp.com/dg_homebakery/php/user/verify.php?email=$email&otp=$otp'><button>Verify Here</button></a></p>
        </body>
        </html>
        ";
        
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
        
        mail($to, $subject, $message, $headers);
    }

?>