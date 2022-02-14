<?php

    function sendJsonRes($res) {
        header("Content-Type: application/json");
        echo json_encode($res);
    }

?>