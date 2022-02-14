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
    $prod_name = $_POST['prod_name'];
    $prod_price = $_POST['prod_price'];
    $default_qty = 1;
    $status = "Pending";
    
    $sql_select = "SELECT * FROM orders WHERE user_id = '$user_id' AND prod_id = '$prod_id' AND status = '$status'";
    $result_select = $conn -> query($sql_select);
    
    $count = $result_select -> num_rows;
    
    if($count > 0) { // update order for existing item
        while($row = $result_select -> fetch_assoc()) {
            $cart = array();
            $cart['user_id'] = $row['user_id'];
            $cart['prod_id'] = $row['prod_id'];
            $cart['price'] = $row['price'];
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
    } elseif($count == 0) { // insert new order for item
        $sql_insert = "INSERT INTO orders (user_id, prod_id, prod_name, price, quantity, status) VALUES ('$user_id', '$prod_id', '$prod_name', '$prod_price', '$default_qty', '$status')";
            
        if($conn -> query($sql_insert) === TRUE) {
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