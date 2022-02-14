<?php

    include("../send_json.php");
    
    if(!isset($_POST)) {
        $response = array('status' => 'failed');
        sendJsonRes($response);
        die();
    }

    include_once("../db_connect.php");
    
    $user_id = $_POST['user_id'];
    $prod_id = $_POST['prod_id'];
    $default_qty = 1;
    
    $sql_select = "SELECT * FROM orders WHERE user_id = '$user_id' AND prod_id = '$prod_id'";
    $result_select = $conn -> query($sql_select);
    
    if($result_select -> num_rows > 0) { // add item quantity
        while($row = $result_select -> fetch_assoc()) {
            $cart = array();
            $cart['user_id'] = $row['user_id'];
            $cart['prod_id'] = $row['prod_id'];
            $cart['quantity'] = $row['quantity'];
        }
        
        $add_item = $cart['quantity'] + 1;
        
        $sql_update = "UPDATE orders SET quantity = '$add_item' WHERE user_id = '$user_id' AND prod_id = '$prod_id'";
        
        if($conn -> query($sql_update) === TRUE) {
            $response = array('status' => 'success');
            sendJsonRes($response);
        } else {
            $response = array('status' => 'failed');
            sendJsonRes($response);
        }
    } else { // fail
        $response = array('status' => 'failed');
        sendJsonRes($response);
    }

    mysqli_close($conn);

?>