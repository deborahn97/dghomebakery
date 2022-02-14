<?php

    include_once("../db_connect.php");
    include("../send_json.php");

    $user_id = $_POST['user_id'];
    $status = "Paid";
    
    $sql = "SELECT * FROM orders WHERE user_id = '$user_id' AND status = '$status' ORDER BY paid_date DESC";
    $result = $conn -> query($sql);
    $data = $result -> fetch_all(MYSQLI_ASSOC);
    
    if(count($data) != 0)
    {
        $output = array('order' => $data);
        sendJsonRes($output);
    }
    else
    {
        $output = array('order' => 'no data');
        sendJsonRes($output);
    }
    
?>