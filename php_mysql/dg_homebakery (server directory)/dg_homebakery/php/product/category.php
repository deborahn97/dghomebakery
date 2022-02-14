<?php

    include_once("../db_connect.php");
    include("../send_json.php");

    $query = "SELECT DISTINCT category FROM product ORDER BY category ASC";
    $result = $conn -> query($query);
    $data = $result -> fetch_all(MYSQLI_ASSOC);
    
    if(count($data) != 0)
    {
        $output = array('category' => $data);
        sendJsonRes($output);
    }
    else
    {
        $output = array('category' => 'no data');
        sendJsonRes($output);
    }
    
?>