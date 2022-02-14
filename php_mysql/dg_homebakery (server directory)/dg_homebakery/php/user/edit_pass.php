<?php

    include("../send_json.php");

    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $id = $_POST['id'];
    $old_pass = sha1($_POST['old_pass']);
    $new_pass = sha1($_POST['new_pass']);
    
    $sql_select = "SELECT * FROM user WHERE id = '$id' AND pass = '$old_pass'";
    $result_select = $conn -> query($sql_select);

    if($result_select -> num_rows > 0) {
        $sql_update = "UPDATE user SET pass = '$new_pass' WHERE id = '$id'";
        
        if($conn -> query($sql_update) === TRUE) {
            $response = array('status' => 'success');
            sendJsonRes($response);
        } else {
            $response = array('status' => 'failed');
            sendJsonRes($response);
        }
    } else {
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

    mysqli_close($conn);

?>