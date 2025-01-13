<?php

    $database= new mysqli("localhost","root","","doc_assist");
    if ($database->connect_error){
        die("Connection failed:  ".$database->connect_error);
    }

?>