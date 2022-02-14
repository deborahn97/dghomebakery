<?php

    include_once("../db_connect.php");
    include("../send_json.php");

    $user_id = $_POST['user_id'];
    $status = "Pending";
    
    $sql = "SELECT * FROM orders WHERE user_id = '$user_id' AND status = '$status'";
    $result = $conn -> query($sql);
    $data = $result -> fetch_all(MYSQLI_ASSOC);
    
    if(count($data) != 0)
    {
        $output = array('cart' => $data);
        sendJsonRes($output);
    }
    else
    {
        $output = array('cart' => 'no data');
        sendJsonRes($output);
    }
    
?>