<?php

    error_reporting(0);

    $order_id = $_GET['orderid'];

    $name = $_GET['name'];
    $email = $_GET['email'];
    $phone = $_GET['phone'];
    $total = $_GET['total'];

    $api_key = '1dd87e74-77ce-40bf-9933-68eaf74791af';
    $collection_id = '0yujws1h';
    $host = 'https://billplz-staging.herokuapp.com/api/v3/bills';

    $data = array(
            'collection_id' => $collection_id,
            'name' => $name,
            'email' => $email,
            'mobile' => $phone,
            'amount' => $total * 100,
            'description' => 'Payment for order by: ' . $name,
            'callback_url' => "https://debbien97.000webhostapp.com/dg_homebakery/php/orders/return_url",
            'redirect_url' => "https://debbien97.000webhostapp.com/dg_homebakery/php/orders/payment_update.php?orderid=$order_id&name=$name&email=$email&phone=$phone&total=$total" 
    );


    $process = curl_init($host);
    curl_setopt($process, CURLOPT_HEADER, 0);
    curl_setopt($process, CURLOPT_USERPWD, $api_key . ":");
    curl_setopt($process, CURLOPT_TIMEOUT, 30);
    curl_setopt($process, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($process, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($process, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($process, CURLOPT_POSTFIELDS, http_build_query($data)); 

    $return = curl_exec($process);
    curl_close($process);

    $bill = json_decode($return, true);
    header("Location: {$bill['url']}");

?>