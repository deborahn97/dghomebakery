<?php

    error_reporting(0);
    
    include_once("../db_connect.php");
    
    $email = $_GET['email'];
    $otp = $_GET['otp'];
    $new_otp = rand(100000,999999);
    
    $sql = "SELECT * FROM user WHERE email = '$email' AND otp = '$otp'";
    $result = $conn -> query($sql);
    
    if ($result->num_rows > 0)
    {
       $status = 'Verified';
       $verify = "UPDATE user SET status = '$status', otp = '$new_otp' WHERE email = '$email'";
       
      if ($conn -> query($verify) === TRUE) {
            echo "<h2>Success</h2> <p>Accont Verification Success. Thank you for verifying your account.</p>";
      } else {
          echo "<h2>Failed</h2> <p>Failed to verify your account. Please try again.</p>";
      }
    }
 
?>