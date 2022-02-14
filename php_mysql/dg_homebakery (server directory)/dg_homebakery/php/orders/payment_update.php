<?php

    error_reporting(0);

    include_once("../db_connect.php");

    $order_id = $_GET['orderid'];

    $name = $_GET['name'];
    $email = $_GET['email'];
    $phone = $_GET['phone'];
    $total = $_GET['total'];

    $order_trim = trim($order_id, "[]"); // remove square brackets
    $order_url = urldecode($order_trim);
    $order_exp = explode(", ", $order_url); // remove commas and spaces
    
    $order_arr = array();
    foreach($order_exp as $key => $value) {
        $order_arr[$key] = $value;
    }
    
    $data = array(
        'id' =>  $_GET['billplz']['id'],
        'paid_at' => $_GET['billplz']['paid_at'] ,
        'paid' => $_GET['billplz']['paid'],
        'x_signature' => $_GET['billplz']['x_signature']
    );
    
    // Billplz
    $paid_status = $_GET['billplz']['paid'];

    if ($paid_status=="true") {
        $paid_status = "Success";
    }else{
        $paid_status = "Failed";
    }

    $receipt_id = $_GET['billplz']['id'];

    $signing = '';
    foreach ($data as $key => $value) {
        $signing.= 'billplz'. $key . $value;
        if ($key === 'paid') {
            break;
        } else {
            $signing .= '|';
        }
    }

    $signed = hash_hmac('sha256', $signing, 'S-D5hNx7eHEZ2gdPeca8XXhw');

    if ($signed === $data['x_signature']) {
        if ($paid_status == "Success") { // payment success
            
            $status = "Paid";
            
            for($i = 0; $i < count($order_arr); $i++) {
                $sql = "UPDATE orders SET status = '$status', paid_date = '".date("Y-m-d H:i:s")."' WHERE id = '".$order_arr[$i]."'";
                
                $result = $conn -> query($sql);
            }
            
            if($result === TRUE) {
                echo 
                "<html>
                <head>
                <style>
                body {
                	font-size: 250%;
                	padding: 100px 100px 100px 100px;
                	text-align: center
                }
                
                h1 {
                	color: #792396;
                }
                
                table {
                    margin-left: auto;
                    margin-right: auto;
                }
                
                tbody {
                    font-size: 200%;
                    text-align: center
                }
                
                th {
                	background-color: #AC32D6;
                 	color: #FFFFFF;
                }
                </style>
                </head>
                <body>
                <h1>DoughyGoodness Home Bakery</h1>
                <p>Thank you for your order. A copy of your receipt will be emailed to you shortly.</p>
                <p>&nbsp;</p>
                <h2>Order Details:</h2>
                <table style='width: 50%;'>
                <tbody>
                <tr>
                <th>Name:</th>
                <td>".$name."</td>
                </tr>
                <tr>
                <th>Email:</th>
                <td>".$email."</td>
                </tr>
                <tr>
                <th>Phone No.:</th>
                <td>".$phone."</td>
                </tr
                <tr>
                <th>Total Amount:</th>
                <td>RM".$total."</td>
                </tr>
                </tbody>
                </table>
                <p>&nbsp;</p>
                <p>Please go back to the app and tap on Order History to view your purchased order.</p>
                </body>
                </html>";
            }
        }
        else { // payment failed
            echo 
            "<html>
                <head>
                <style>
                body {
                	font-size: 250%;
                	padding: 100px 100px 100px 100px;
                	text-align: center
                }
                
                h1 {
                	color: #792396;
                }
                </style>
                </head>
                <body>
            <h1>DoughyGoodness Home Bakery</h1>
            <p>Thank you for your order. Unfortunately your order couldn't be processed at this time. Please try again.</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            </body>
            </html>";
        }
    }

    mysqli_close($conn);

?>