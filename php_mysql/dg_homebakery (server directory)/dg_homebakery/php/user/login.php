<?php

    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        echo "failed";
        die();
    }

    include_once("../db_connect.php");

    $email = $_POST['email'];
    $pass = sha1($_POST['pass']);

    $sql = "SELECT * FROM user WHERE email = '$email' AND pass = '$pass'";
    $result = $conn -> query($sql);

    if($result -> num_rows > 0) {
        while($row = $result -> fetch_assoc()) {
            $user = array();
            $user['id'] = $row['id'];
            $user['name'] = $row['name'];
            $user['email'] = $row['email'];
            $user['phone'] = $row['phone'];
            $user['address'] = $row['address'];
            $user['otp'] = $row['otp'];
            $user['status'] = $row['status'];

            echo json_encode($user);
            return;
        }
    } else
        echo "failed";

    mysqli_close($conn);

?>