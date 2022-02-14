<?php

    include_once("../db_connect.php");
    include("../send_json.php");

    $cat = $_POST['category'];
    $query = "SELECT * FROM product WHERE category = '$cat'";
    $result = $conn -> query($query);
    $data = $result -> fetch_all(MYSQLI_ASSOC);
    
    if(count($data) != 0)
    {
        $output = array('product' => $data);
        sendJsonRes($output);
    }
    else
    {
        $output = array('product' => 'no data');
        sendJsonRes($output);
    }
    
?>