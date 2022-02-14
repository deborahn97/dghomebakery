<?php

    $server = "localhost";
    $username = "id18345580_deborahn97";
    $pass = "TbouTd.20200511";
    $db_name = "id18345580_dg_homebakery";

    $conn = new mysqli($server, $username, $pass, $db_name);

    if($conn -> connect_error)
        die("Connection failed: " . $conn -> connect_error);

?>