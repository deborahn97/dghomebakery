<?php

    include_once("../db_connect.php");
    include("../send_json.php");

    $query = "SELECT * FROM product ORDER BY date_created DESC LIMIT 6";
    $result = $conn -> query($query);
    $data = $result -> fetch_all(MYSQLI_ASSOC);
    
    if(count($data) != 0)
    {
        $output = array('latest' => $data);
        sendJsonRes($output);
    }
    else
    {
        $output = array('latest' => 'no data');
        sendJsonRes($output);
    }
    
?>